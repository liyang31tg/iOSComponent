//
//  SunRefresh.swift
//  iOSComponent
//
//  Created by liyang on 16/5/25.
//  Copyright © 2016年 liyang. All rights reserved.
//  上拉下拉插件

import Foundation

enum RefreshType:Int {
    case PullNone   = 0 //默认状态，没有任何上啦下啦
    case PullDown   = 1 //只有上拉
    case PullUp     = 2 //只有下拉
    case PullBoth   = 3 //上拉下拉同时（暂时默认上拉，也必须拉动，以后有空扩展类似qq的滚动到底部自动刷新）
}

enum RefreshDataType:Int {//状态控制
    case RefreshNone        = 0 //默认状态
    
    case PullDownIng        = 1 //下拉中
    case PullDownOverZero   = 2 //下拉到零界点
    case PullDownRefreshing = 3 //下拉松开手势，刷新中
    case PullDownRefreshed  = 4 //下拉结束
    
    case PullUpIng          = 5 //上拉中
    case PullUpOverZero     = 6 //上拉到零界点
    case PullUpRefreshing   = 7 //上拉松开手势，刷新中
    case PullUpRefreshed    = 8 //上拉结束
}



protocol RefreshProtocol { //暴露给外部接口实现
    func loadMoreData()
    func refreshData()
}

//MARK:PullDownRefreshing and PullUpRefreshing的动画样式不能用形变亮控制
protocol RefreshViewProtocol {
    func refreshViewWithState(refreshDataType: RefreshDataType,pullDownOffset:CGFloat,pullUpOffset:CGFloat)
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
            objc_setAssociatedObject(self, &AssociateKeys.refreshType, newValue.rawValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if newValue != RefreshType.PullNone{
                //添加监听
                self.addRefreshObserve()
            }
            self.addRefreshFooterAndHeaderView()
        }
    }
    
    private func addRefreshObserve(){
        let obserKeys = ["contentOffset","contentSize"]
        for key in obserKeys {
            self.addObserver(RefreshStaticParametter.publicObserve, forKeyPath: key, options: NSKeyValueObservingOptions.New, context: nil)
        }
    }
    
    
    public override func removeFromSuperview() {
        if self.refreshType != RefreshType.PullNone {
            let obserKeys = ["contentOffset","contentSize"]
            for key in obserKeys {
                self.removeObserver(RefreshStaticParametter.publicObserve, forKeyPath: key)
            }
        }
        super.removeFromSuperview()
    }
    /*
     *作用于,Scrollview的ContentSize小于Frame的话就不启动上拉刷新
     */
    public  override func didChangeValueForKey(key: String) {
        super.didChangeValueForKey(key)
        if self.refreshType != RefreshType.PullNone {
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
            return b
        }
        set{
            objc_setAssociatedObject(self, &AssociateKeys.refreshDelegate, newValue , objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
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
    
    ////所有状态监听，都是在已经有拖动效果的情况下，这个状态维护，只要是是用于适配ControllerVC,自动为ScrollView添加上contentInset（就是那个controllerVC自动适配改变contentInset）而维护的
    //是否渲染后是否被拖动过，是1，否 0
    var isHaveDrag:Int{
        get{
            return objc_getAssociatedObject(self, &AssociateKeys.isHaveDrag) as? Int ?? 0
        }
        
        set{
            objc_setAssociatedObject(self, &AssociateKeys.isHaveDrag, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            
        }
        
    }
    
    
    private var headerViewOverHeightZero:CGFloat{
        get{
            let b = objc_getAssociatedObject(self, &AssociateKeys.headerOverZero)
            return b as? CGFloat ?? 0.0
        }
        set{
            objc_setAssociatedObject(self, &AssociateKeys.headerOverZero, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
    private var footerViewOverHeightZero:CGFloat{
        get{
            let b = objc_getAssociatedObject(self, &AssociateKeys.footerOverZero)
            return b as? CGFloat ?? 0.0
        }
        set{
            objc_setAssociatedObject(self, &AssociateKeys.footerOverZero, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
    
    
    
    private var headerRefreshView:UIView {
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
    
    
    private var footerRefreshView:UIView {
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
    
    private var defaultHeaderRefreshView:UIView{
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        headerView.backgroundColor = UIColor.redColor()
        return headerView
    }
    private var defaultFooterRefreshView:UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        footerView.backgroundColor = UIColor.brownColor()
        return footerView
    }
    
    
    
    
    //MARK:方法
    private func changeRefreshDataType(refreshDataType:RefreshDataType){
        
        switch refreshDataType {
        case RefreshDataType.RefreshNone:
            print("默认状态")
            if self.refreshType == RefreshType.PullUp || self.refreshType == RefreshType.PullBoth {
                self.footerRefreshView.hidden = self.contentSize.height < self.frame.size.height
            }
        case RefreshDataType.PullDownIng:
            print("下拉中")
        case RefreshDataType.PullDownOverZero:
            print("下拉临界点")
        case RefreshDataType.PullDownRefreshing:
            print("下拉松开手势，刷新中")
            var tmpContentInset = self.contentInset
            tmpContentInset.top += self.headerViewOverHeightZero
            //启动事件
            (self.refreshDelegate as? RefreshProtocol)?.refreshData()
            UIView.animateWithDuration(0.3, animations: {
                self.contentInset = tmpContentInset
            })
            
        case RefreshDataType.PullDownRefreshed:
            var tmpContentInset = self.contentInset
            tmpContentInset.top -= self.headerViewOverHeightZero
            
            UIView.animateWithDuration(0.3, animations: {
                self.contentInset = tmpContentInset
            })
            print("下拉结束")
        case RefreshDataType.PullUpIng:
            print("上拉中")
        case RefreshDataType.PullUpOverZero:
            print("上拉临界点")
        case RefreshDataType.PullUpRefreshing:
            print("上拉松开手势，刷新中")
            
            if self.frame.size.height <= self.contentSize.height{
                var tmpContentInset = self.contentInset
                tmpContentInset.bottom += self.footerViewOverHeightZero
                (self.refreshDelegate as? RefreshProtocol)?.loadMoreData()
                UIView.animateWithDuration(0.3, animations: {
                    self.contentInset = tmpContentInset
                })
            }//这种状况下就只能操作frame,但是操作失败，暂时不支持这种情况下的下拉刷新
            
            
        case RefreshDataType.PullUpRefreshed:
            if self.frame.size.height <= self.contentSize.height{
                var tmpContentInset = self.contentInset
                tmpContentInset.bottom -= self.footerViewOverHeightZero
                
                UIView.animateWithDuration(0.3, animations: {
                    self.contentInset = tmpContentInset
                })
            }
        }
        
    }
    
    
    
    
    private enum CareType:Int {
        case onlyHeader = 0
        case onlyFooter = 1
        case both       = 3
    }
    
    private func addRefreshFooterAndHeaderView(careType:CareType = CareType.onlyHeader){
        switch self.refreshType {
        case RefreshType.PullNone:
            self.removeHeaderFooterView()
        case RefreshType.PullDown:
            if careType == CareType.onlyHeader || careType == CareType.both{
                self.addRefreshHeaderView()
            }
            
        case RefreshType.PullUp:
            if careType == CareType.onlyFooter || careType == CareType.both{
                self.addRefreshFooterView()
            }
        case RefreshType.PullBoth:
            if careType == CareType.onlyHeader || careType == CareType.both{
                self.addRefreshHeaderView()
            }
            if careType == CareType.onlyFooter || careType == CareType.both{
                self.addRefreshFooterView()
            }
            
        }
    }
    private func removeHeaderFooterView(){
        self.viewWithTag(AssociateTag.headerRefreshViewTag)?.removeFromSuperview()
        self.viewWithTag(AssociateTag.footerRefreshViewTag)?.removeFromSuperview()
    }
    
    private func addRefreshHeaderView(){
        let headerView = self.headerRefreshView
        self.viewWithTag(AssociateTag.headerRefreshViewTag)?.removeFromSuperview()
        headerView.translatesAutoresizingMaskIntoConstraints    = false
        self.addSubview(headerView)
        
        //addConstraint
        let width =   NSLayoutConstraint(item: headerView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint(item: headerView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let trainingC =   NSLayoutConstraint(item: headerView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        let heightC =   NSLayoutConstraint(item: headerView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: headerView.frame.size.height)
        self.addConstraints([width,centerX,trainingC,heightC])
    }
    
    private func addRefreshFooterView(){
        let footerView = self.footerRefreshView
        self.viewWithTag(AssociateTag.footerRefreshViewTag)?.removeFromSuperview()
        footerView.translatesAutoresizingMaskIntoConstraints   = false
        self.addSubview(footerView)
        
        let frameHeight         = self.frame.size.height - self.contentInset.top
        let contentSizeHeight   = self.contentSize.height
        
        //addConstraint
        let width =   NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let trainingC =   NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: max(frameHeight, contentSizeHeight))
        let heightC =   NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: footerView.frame.size.height)
        self.addConstraints([width,centerX,trainingC,heightC])
        
    }
    
    
    
    
}

/*
 *完全是出于moudle的保护
 */
private struct RefreshStaticParametter {
    static var  publicObserve       = ObserObject()
}


//warning静止移除(在这里设置状态)
var  isDraging       = false//是否在拖动，默认为否
class ObserObject: NSObject {
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "contentOffset"{
            
            
            if let table = object as? UIScrollView{
                if table.dragging {
                    table.isHaveDrag = 1
                }
                guard table.isHaveDrag == 1 else{return}
                if table.refreshType == RefreshType.PullNone {
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
                if table.headerViewOverHeightZero <= tmpPullDownOffset && !table.dragging{
                    //上啦超过零界点(启动刷新)
                    if table.currentRefreshDataState != RefreshDataType.PullUpRefreshing {
                        table.currentRefreshDataState = RefreshDataType.PullDownRefreshing
                    }
                    
                    //                            print("启动下拉刷新")
                }
                
                if tmpOffset >= table.footerViewOverHeightZero && !table.dragging{
                    //下拉刷新的时候，上啦无效
                    if table.currentRefreshDataState != RefreshDataType.PullDownRefreshing{
                        if table.contentSize.height > table.frame.size.height{
                            table.currentRefreshDataState = RefreshDataType.PullUpRefreshing
                        }
                    }
                    
                    
                    //                            print("启动上拉刷新")
                }
                
                //                    }else{//不拖动到拖动
                if tmpPullDownOffset < table.headerViewOverHeightZero && 0 < tmpPullDownOffset {
                    //下拉中
                    if table.currentRefreshDataState != RefreshDataType.PullDownRefreshing && table.currentRefreshDataState != RefreshDataType.PullUpRefreshing{
                        table.currentRefreshDataState = RefreshDataType.PullDownIng
                    }
                    
                    //                             print("下拉中")
                }
                
                if tmpOffset > 0 && tmpOffset < table.footerViewOverHeightZero{
                    if table.currentRefreshDataState != RefreshDataType.PullDownRefreshing && table.currentRefreshDataState != RefreshDataType.PullUpRefreshing{
                        table.currentRefreshDataState = RefreshDataType.PullUpIng
                    }
                    
                    //                            print("上拉中")
                    
                }
                
                if table.headerViewOverHeightZero <= tmpPullDownOffset {
                    //下拉超过零界点
                    if table.currentRefreshDataState != RefreshDataType.PullDownRefreshing && table.currentRefreshDataState != RefreshDataType.PullUpRefreshing {
                        table.currentRefreshDataState = RefreshDataType.PullDownOverZero
                        //                        print("下拉超过临界点")
                    }
                    
                }
                
                if tmpOffset >= table.footerViewOverHeightZero{
                    if table.currentRefreshDataState != RefreshDataType.PullDownRefreshing && table.currentRefreshDataState != RefreshDataType.PullUpRefreshing {
                        table.currentRefreshDataState = RefreshDataType.PullUpOverZero
                        //                        print("上拉超过临界点:\(tmpOffset),footerViewOverHeightZero:\(table.footerViewOverHeightZero)")
                    }
                }
                
                if 0 == tmpPullDownOffset || abs(tmpOffset) < 0.1 {//0.1是模糊的数据
                    //恢复初始状态
                    if table.currentRefreshDataState != RefreshDataType.PullDownRefreshing && table.currentRefreshDataState != RefreshDataType.PullUpRefreshing{
                        table.currentRefreshDataState = RefreshDataType.RefreshNone
                        //                        print("---------进入默认状态：\(RefreshStaticParametter.isDraging)")
                    }
                    //                    print("恢复初始状态")
                    
                }
                
                
            }
        }
        
        if keyPath == "contentSize"{
            if let table = object as? UITableView{
                if table.refreshType == RefreshType.PullUp || table.refreshType == RefreshType.PullBoth {
                    table.footerRefreshView.hidden = table.contentSize.height < table.frame.size.height
                }
                
            }
        }
        
    }
}




//不包含其中
class HeaderView:UIView,RefreshViewProtocol{
    
    var stateLabel          = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    var pullDownOffsetLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 100, height: 20))
    var pullUpOffsetLabel   = UILabel(frame: CGRect(x: 100, y: 20, width: 100, height: 20))
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stateLabel)
        self.addSubview(pullUpOffsetLabel)
        self.addSubview(pullDownOffsetLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func refreshViewWithState(refreshDataType: RefreshDataType, pullDownOffset: CGFloat, pullUpOffset: CGFloat) {
        stateLabel.text = "\(refreshDataType)"
        pullDownOffsetLabel.text = "\(pullDownOffset)"
        pullUpOffsetLabel.text = "\(pullUpOffset)"
        
    }
    
}

