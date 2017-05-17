//
//  SunRefresh.swift
//  iOSComponent
//
//  Created by liyang on 16/5/25.
//  Copyright © 2016年 liyang. All rights reserved.
//  上拉下拉插件

import Foundation

enum RefreshType:Int {
    case pullNone   = 0 //默认状态，没有任何上啦下啦
    case pullDown   = 1 //只有上拉
    case pullUp     = 2 //只有下拉
    case pullBoth   = 3 //上拉下拉同时（暂时默认上拉，也必须拉动，以后有空扩展类似qq的滚动到底部自动刷新）
}

enum RefreshDataType:Int {//状态控制
    case refreshNone        = 0 //默认状态
    
    case pullDownIng        = 1 //下拉中
    case pullDownOverZero   = 2 //下拉到零界点
    case pullDownRefreshing = 3 //下拉松开手势，刷新中
    case pullDownRefreshed  = 4 //下拉结束
    
    case pullUpIng          = 5 //上拉中
    case pullUpOverZero     = 6 //上拉到零界点
    case pullUpRefreshing   = 7 //上拉松开手势，刷新中
    case pullUpRefreshed    = 8 //上拉结束
}



protocol RefreshProtocol { //暴露给外部接口实现
    func loadMoreData()
    func refreshData()
}

//MARK:PullDownRefreshing and PullUpRefreshing的动画样式不能用形变亮控制
protocol RefreshViewProtocol {
    func refreshViewWithState(_ refreshDataType: RefreshDataType,pullDownOffset:CGFloat,pullUpOffset:CGFloat)
}

//MARK:UIScrollView extension
extension UIScrollView{
    struct AssociateKeys {
        static var headerRefreshView        = "headerRefreshView"
        static var footerRefreshView        = "footerRefreshView"
        static var refreshType              = "sunRefreshType"
        static var headerOverZero           = "headerOverZero"
        static var footerOverZero           = "footerOverZero"
        static var currentRefreshDataState  = "currentRefreshDataState"
        static var refreshDelegate          = "refreshDelegate"
        static var isHaveDrag               = "isHaveDrag"
        
    }
    
    struct AssociateTag {
        static var headerRefreshViewTag = Int.max
        static var footerRefreshViewTag = Int.max - 1
    }
    /*
     *RefreshType,这个是参数
     */
    //MARK:属性
    var refreshType: RefreshType{
        get{
            let b = objc_getAssociatedObject(self, &AssociateKeys.refreshType)
            let c = b as? Int ?? 0
            return RefreshType(rawValue: c)!
        }
        set{
            let b = self.refreshType == RefreshType.pullNone//因为运行时是在底层切割，所以这个需要放在前面
            objc_setAssociatedObject(self, &AssociateKeys.refreshType, newValue.rawValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            
            if newValue != RefreshType.pullNone && b{ //防止重复添加监听
                //添加监听
                self.addRefreshObserve()
            }
            self.removeHeaderFooterView()
            self.addRefreshFooterAndHeaderView()
        }
    }
    
    fileprivate func addRefreshObserve(){
        let obserKeys = ["contentOffset","contentSize"]
        for key in obserKeys {
            self.addObserver(RefreshStaticParametter.publicObserve, forKeyPath: key, options: NSKeyValueObservingOptions.new, context: nil)
        }
    }
    
    
    
    
    
    
    open override func removeFromSuperview() {
        super.removeFromSuperview()
        if self.refreshType != RefreshType.pullNone {
            let obserKeys = ["contentOffset","contentSize"]
            for key in obserKeys {
                self.removeObserver(RefreshStaticParametter.publicObserve, forKeyPath: key)
            }
        }
    }
    /*
     *作用于,Scrollview的ContentSize小于Frame的话就不启动上拉刷新
     */
    open  override func didChangeValue(forKey key: String) {
        super.didChangeValue(forKey: key)
        if self.refreshType != RefreshType.pullNone {
            if key == "contentSize"{
                self.addRefreshFooterAndHeaderView(CareType.onlyFooter)
            }
        }
    }
    
    /*
     *RefreshProtocol需要实现这个接口
     */
    var refreshDelegate: AnyObject?{
        get{
            let b = objc_getAssociatedObject(self, &AssociateKeys.refreshDelegate)
            return b as AnyObject
        }
        set{
            objc_setAssociatedObject(self, &AssociateKeys.refreshDelegate, newValue , objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            
        }
        
    }
    /*
     *设置当前状态
     */
    
    var currentRefreshDataState:RefreshDataType{
        get{
            let b = objc_getAssociatedObject(self, &AssociateKeys.currentRefreshDataState) as? Int ?? 0
            
            return RefreshDataType(rawValue: b)!
        }
        
        set{
            if newValue != self.currentRefreshDataState {
                objc_setAssociatedObject(self, &AssociateKeys.currentRefreshDataState, newValue.rawValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                //这里来设置状态,根据不同的状态惊醒切换
                self.changeRefreshDataType(newValue)
            }
        }
        
    }
    
    ////所有状态监听，都是在已经有拖动效果的情况下，这个状态维护，只要是是用于适配ControllerVC,自动为ScrollView添加上contentInset（）而维护的
    //是否渲染后是否被拖动过，是1，否 0
    var isHaveDrag:Int{
        get{
            return objc_getAssociatedObject(self, &AssociateKeys.isHaveDrag) as? Int ?? 0
        }
        
        set{
            objc_setAssociatedObject(self, &AssociateKeys.isHaveDrag, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            
        }
        
    }
    
    
    fileprivate var headerViewOverHeightZero:CGFloat{
        get{
            let b = objc_getAssociatedObject(self, &AssociateKeys.headerOverZero)
            
            return b as? CGFloat ?? 0.0
        }
        set{
            objc_setAssociatedObject(self, &AssociateKeys.headerOverZero, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
    fileprivate var footerViewOverHeightZero:CGFloat{
        get{
            let b = objc_getAssociatedObject(self, &AssociateKeys.footerOverZero)
            return b as? CGFloat ?? 0.0
        }
        set{
            objc_setAssociatedObject(self, &AssociateKeys.footerOverZero, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
    
    
    
    fileprivate var headerRefreshView:UIView {
        get{
            var headerView  = objc_getAssociatedObject(self, &AssociateKeys.headerRefreshView) as? UIView
            if headerView == nil {
                headerView = self.defaultHeaderRefreshView
                self.headerRefreshView = headerView!
            }
            
            headerView!.tag  = AssociateTag.headerRefreshViewTag
            self.headerViewOverHeightZero = headerView!.frame.size.height
            return headerView!
        }
        set{
            objc_setAssociatedObject(self, &AssociateKeys.headerRefreshView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        
    }
    
    
    fileprivate var footerRefreshView:UIView {
        get{
            var footerView  = objc_getAssociatedObject(self, &AssociateKeys.footerRefreshView) as? UIView
            
            if footerView == nil {
                footerView = self.defaultFooterRefreshView
                self.footerRefreshView = footerView!
            }
            footerView!.tag  = AssociateTag.footerRefreshViewTag
            self.footerViewOverHeightZero = footerView!.frame.size.height
            return footerView!
        }
        set{
            objc_setAssociatedObject(self, &AssociateKeys.footerRefreshView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    fileprivate var defaultHeaderRefreshView:UIView{
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        //        headerView.backgroundColor = UIColor.redColor()
        return headerView
    }
    fileprivate var defaultFooterRefreshView:UIView{
        let footerView = HeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        //        footerView.backgroundColor = UIColor.brownColor()
        return footerView
    }
    
    
    
    
    //MARK:方法
    fileprivate func changeRefreshDataType(_ refreshDataType:RefreshDataType){
        
        switch refreshDataType {
        case RefreshDataType.refreshNone:
            print("默认状态")
            if self.refreshType == RefreshType.pullUp || self.refreshType == RefreshType.pullBoth {
                self.footerRefreshView.isHidden = self.contentSize.height < self.frame.size.height
            }
        case RefreshDataType.pullDownIng:
            print("下拉中")
        case RefreshDataType.pullDownOverZero:
            print("下拉临界点")
        case RefreshDataType.pullDownRefreshing:
            print("下拉松开手势，刷新中")
            var tmpContentInset = self.contentInset
            tmpContentInset.top += self.headerViewOverHeightZero
            //启动事件
            (self.refreshDelegate as? RefreshProtocol)?.refreshData()
            UIView.animate(withDuration: 0.3, animations: {
                self.contentInset = tmpContentInset
            })
            
        case RefreshDataType.pullDownRefreshed:
            var tmpContentInset = self.contentInset
            tmpContentInset.top -= self.headerViewOverHeightZero
            
            UIView.animate(withDuration: 0.3, animations: {
                self.contentInset = tmpContentInset
            })
            print("下拉结束")
        case RefreshDataType.pullUpIng:
            print("上拉中")
        case RefreshDataType.pullUpOverZero:
            print("上拉临界点")
        case RefreshDataType.pullUpRefreshing:
            print("上拉松开手势，刷新中")
            guard self.refreshType == .pullBoth || self.refreshType == .pullUp else{
                return
            }
            
            if self.frame.size.height <= self.contentSize.height{
                var tmpContentInset = self.contentInset
                tmpContentInset.bottom += self.footerViewOverHeightZero
                (self.refreshDelegate as? RefreshProtocol)?.loadMoreData()
                UIView.animate(withDuration: 0.3, animations: {
                    self.contentInset = tmpContentInset
                })
            }//这种状况下就只能操作frame,但是操作失败，暂时不支持这种情况下的下拉刷新
            
            
        case RefreshDataType.pullUpRefreshed:
            if self.frame.size.height <= self.contentSize.height{
                var tmpContentInset = self.contentInset
                tmpContentInset.bottom -= self.footerViewOverHeightZero
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.contentInset = tmpContentInset
                })
            }
        }
        
    }
    
    
    
    
    fileprivate enum CareType:Int {
        case onlyHeader = 0
        case onlyFooter = 1
        case both       = 3
    }
    
    fileprivate func addRefreshFooterAndHeaderView(_ careType:CareType = CareType.onlyHeader){
        switch self.refreshType {
        case RefreshType.pullNone:
            self.removeHeaderFooterView()
        case RefreshType.pullDown:
            if careType == CareType.onlyHeader || careType == CareType.both{
                self.addRefreshHeaderView()
            }
            
        case RefreshType.pullUp:
            if careType == CareType.onlyFooter || careType == CareType.both{
                self.addRefreshFooterView()
            }
        case RefreshType.pullBoth:
            if careType == CareType.onlyHeader || careType == CareType.both{
                self.addRefreshHeaderView()
            }
            if careType == CareType.onlyFooter || careType == CareType.both{
                self.addRefreshFooterView()
            }
            
        }
    }
    fileprivate func removeHeaderFooterView(){
        self.viewWithTag(AssociateTag.headerRefreshViewTag)?.removeFromSuperview()
        self.viewWithTag(AssociateTag.footerRefreshViewTag)?.removeFromSuperview()
    }
    
    fileprivate func addRefreshHeaderView(){
        let headerView = self.headerRefreshView
        self.viewWithTag(AssociateTag.headerRefreshViewTag)?.removeFromSuperview()
        headerView.translatesAutoresizingMaskIntoConstraints    = false
        self.addSubview(headerView)
        
        //addConstraint
        let width =   NSLayoutConstraint(item: headerView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint(item: headerView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let trainingC =   NSLayoutConstraint(item: headerView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let heightC =   NSLayoutConstraint(item: headerView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: headerView.frame.size.height)
        self.addConstraints([width,centerX,trainingC,heightC])
    }
    
    fileprivate func addRefreshFooterView(){
        let footerView = self.footerRefreshView
        self.viewWithTag(AssociateTag.footerRefreshViewTag)?.removeFromSuperview()
        footerView.translatesAutoresizingMaskIntoConstraints   = false
        self.addSubview(footerView)
        
        let frameHeight         = self.frame.size.height - self.contentInset.top
        let contentSizeHeight   = self.contentSize.height
        
        //addConstraint
        let width =   NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let trainingC =   NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: max(frameHeight, contentSizeHeight))
        let heightC =   NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: footerView.frame.size.height)
        self.addConstraints([width,centerX,trainingC,heightC])
        
    }
    
    
    
    
}

/*
 *完全是出于moudle的保护
 */
struct RefreshStaticParametter {
    static var  publicObserve       = ObserObject()
}


//warning静止移除(在这里设置状态)
var  isDraging       = false//是否在拖动，默认为否
class ObserObject: NSObject {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset"{
            
            
            if let table = object as? UIScrollView{
                /*这里为什么要屏蔽掉，暂时不知道2016年8月10日
                 if table.dragging {
                 table.isHaveDrag = 1
                 }
                 guard table.isHaveDrag == 1 else{return}
                 */
                if table.refreshType == RefreshType.pullNone {
                    return
                }
                let contentOffset       = table.contentOffset
                let contentSize         = table.contentSize
                let contentInset        = table.contentInset
                let tmpPullDownOffset   = -contentInset.top - contentOffset.y
                let tmpOffset           = contentOffset.y + contentInset.top + table.frame.size.height  - max(contentSize.height + contentInset.bottom + contentInset.top, table.frame.size.height)
                
                //这里是协议实现refreshVew，这里是操作刷新View的动画
                (table.headerRefreshView as? RefreshViewProtocol)?.refreshViewWithState(table.currentRefreshDataState, pullDownOffset: tmpPullDownOffset, pullUpOffset: tmpOffset)
                (table.footerRefreshView as? RefreshViewProtocol)?.refreshViewWithState(table.currentRefreshDataState, pullDownOffset: tmpPullDownOffset, pullUpOffset: tmpOffset)
                
                //                print("tmpPullDownOffset:\(tmpPullDownOffset),tmpOffset:\(tmpOffset)")
                //                if RefreshStaticParametter.isDraging != table.dragging {
                //                    if RefreshStaticParametter.isDraging {//拖动到不拖动
                if table.headerViewOverHeightZero <= tmpPullDownOffset && !table.isDragging{
                    //上啦超过零界点(启动刷新)
                    if table.currentRefreshDataState != RefreshDataType.pullUpRefreshing {
                        table.currentRefreshDataState = RefreshDataType.pullDownRefreshing
                    }
                    
                    //                            print("启动下拉刷新")
                }
                
                if tmpOffset >= table.footerViewOverHeightZero && !table.isDragging{
                    //下拉刷新的时候，上啦无效
                    if table.currentRefreshDataState != RefreshDataType.pullDownRefreshing{
                        if table.contentSize.height > table.frame.size.height{
                            table.currentRefreshDataState = RefreshDataType.pullUpRefreshing
                        }
                    }
                    
                    
                    //                            print("启动上拉刷新")
                }
                
                //                    }else{//不拖动到拖动
                if tmpPullDownOffset < table.headerViewOverHeightZero && 0 < tmpPullDownOffset {
                    //下拉中
                    if table.currentRefreshDataState != RefreshDataType.pullDownRefreshing && table.currentRefreshDataState != RefreshDataType.pullUpRefreshing{
                        table.currentRefreshDataState = RefreshDataType.pullDownIng
                    }
                    
                    //                             print("下拉中")
                }
                
                if tmpOffset > 0 && tmpOffset < table.footerViewOverHeightZero{
                    if table.currentRefreshDataState != RefreshDataType.pullDownRefreshing && table.currentRefreshDataState != RefreshDataType.pullUpRefreshing{
                        table.currentRefreshDataState = RefreshDataType.pullUpIng
                    }
                    
                    //                            print("上拉中")
                    
                }
                
                if table.headerViewOverHeightZero <= tmpPullDownOffset {
                    //下拉超过零界点
                    if table.currentRefreshDataState != RefreshDataType.pullDownRefreshing && table.currentRefreshDataState != RefreshDataType.pullUpRefreshing {
                        table.currentRefreshDataState = RefreshDataType.pullDownOverZero
                        //                        print("下拉超过临界点")
                    }
                    
                }
                
                if tmpOffset >= table.footerViewOverHeightZero{
                    if table.currentRefreshDataState != RefreshDataType.pullDownRefreshing && table.currentRefreshDataState != RefreshDataType.pullUpRefreshing {
                        table.currentRefreshDataState = RefreshDataType.pullUpOverZero
                        //                        print("上拉超过临界点:\(tmpOffset),footerViewOverHeightZero:\(table.footerViewOverHeightZero)")
                    }
                }
                
                if 0 == tmpPullDownOffset || abs(tmpOffset) < 0.1 {//0.1是模糊的数据
                    //恢复初始状态
                    if table.currentRefreshDataState != RefreshDataType.pullDownRefreshing && table.currentRefreshDataState != RefreshDataType.pullUpRefreshing{
                        table.currentRefreshDataState = RefreshDataType.refreshNone
                        //                        print("---------进入默认状态：\(RefreshStaticParametter.isDraging)")
                    }
                    //                    print("恢复初始状态")
                    
                }
                
                
            }
        }
        
        if keyPath == "contentSize"{
            if let table = object as? UITableView{
                if table.refreshType == RefreshType.pullUp || table.refreshType == RefreshType.pullBoth {
                    table.footerRefreshView.isHidden = table.contentSize.height < table.frame.size.height
                }
                
            }
        }
        
    }
}




//不包含其中
class HeaderView:UIView,RefreshViewProtocol{
    
    var stateLabel          = UILabel(frame: CGRect(x: 0, y: 0, width:ScreenWidth, height: 50))
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stateLabel)
        self.backgroundColor = UIColor.colorWithHexColorString("f0f0f0")
        
        stateLabel.textAlignment = NSTextAlignment.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func refreshViewWithState(_ refreshDataType: RefreshDataType, pullDownOffset: CGFloat, pullUpOffset: CGFloat) {
        
        var notice = "刷新中"
        switch refreshDataType.rawValue {
        case 0:
            notice = "默认状态";
        case 1:
            notice = "下拉中";
        case 2:
            notice = "松开刷新";
        case 3:
            notice = "刷新中";
        case 4:
            notice = "刷新结束";
        case 5:
            notice = "上拉中";
        case 6:
            notice = "松开刷新";
        case 7:
            notice = "刷新中";
        case 8:
            notice = "刷新结束";
        default:
            break;
        }
        
        stateLabel.text = notice
    }
    
}

class SunTableView:UITableView{}

