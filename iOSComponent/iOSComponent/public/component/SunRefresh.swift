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


/*
 *因为iOS7后的UITableViewwrapView的存在，所以要分开在UIScrollView的子类实现其方法
 */
//MARK:UITableView extension
extension UITableView{
    public override func willMoveToSuperview(newSuperview: UIView?) {
        let obserKeys = ["contentOffset","contentSize"]
        for key in obserKeys {
            self.addObserver(RefreshStaticParametter.publicObserve, forKeyPath: key, options: NSKeyValueObservingOptions.New, context: nil)

        }
    }
    public override func removeFromSuperview() {
        let obserKeys = ["contentOffset","contentSize"]
        for key in obserKeys {
            self.removeObserver(RefreshStaticParametter.publicObserve, forKeyPath: key)

        }
    }
    public override func didChangeValueForKey(key: String) {
        super.didChangeValueForKey(key)
        
        if key == "contentSize"{
            self.addRefreshFooterAndHeaderView(CareType.onlyFooter)
        }
    }
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
        
    }
    
    struct AssociateTag {
        static var headerRefreshViewTag = Int.max
        static var footerRefreshViewTag = Int.max - 1
    }
    /*
     *RefreshType,这个是参数
     */
    //MARK:属性
    var refreshType: Int{
        get{
            let b = objc_getAssociatedObject(self, &AssociateKeys.refreshType)
            return b as? Int ?? 0
        }
        set{
            objc_setAssociatedObject(self, &AssociateKeys.refreshType, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            self.addRefreshFooterAndHeaderView()
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
            objc_setAssociatedObject(self, &AssociateKeys.refreshDelegate, newValue , objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
         
        }
    
    }
    /*
     *设置当前状态
     */
    
    var currentRefreshDataState:Int{
        get{
            return objc_getAssociatedObject(self, &AssociateKeys.currentRefreshDataState) as? Int ?? 0
        }
        
        set{
            if newValue != self.currentRefreshDataState {
                objc_setAssociatedObject(self, &AssociateKeys.currentRefreshDataState, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
                //这里来设置状态,根据不同的状态惊醒切换
                self.changeRefreshDataType(newValue)
            }
        }
    
    }
    
    
    
    
    private var headerViewOverHeightZero:CGFloat{
        get{
            let b = objc_getAssociatedObject(self, &AssociateKeys.headerOverZero)
            return b as? CGFloat ?? 0.0
        }
        set{
            objc_setAssociatedObject(self, &AssociateKeys.headerOverZero, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    
    }
    
    private var footerViewOverHeightZero:CGFloat{
        get{
            let b = objc_getAssociatedObject(self, &AssociateKeys.footerOverZero)
            return b as? CGFloat ?? 0.0
        }
        set{
            objc_setAssociatedObject(self, &AssociateKeys.footerOverZero, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
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
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        headerView.backgroundColor = UIColor.redColor()
        return headerView
    }
   private var defaultFooterRefreshView:UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        footerView.backgroundColor = UIColor.brownColor()
        return footerView
    }
    
    
    
    
    //MARK:方法
    private func changeRefreshDataType(refreshDataType:Int){
        switch refreshDataType {
        case RefreshDataType.RefreshNone.rawValue:
            print("默认状态:\(self.footerRefreshView)")
            if self.refreshType == RefreshType.PullUp.rawValue || self.refreshType == RefreshType.PullBoth.rawValue {
                self.footerRefreshView.hidden = self.contentSize.height < self.frame.size.height
            }
        case RefreshDataType.PullDownIng.rawValue:
            print("下拉中")
        case RefreshDataType.PullDownOverZero.rawValue:
            print("下拉临界点")
        case RefreshDataType.PullDownRefreshing.rawValue:
            print("下拉松开手势，刷新中")
            var tmpContentInset = self.contentInset
            tmpContentInset.top += self.headerViewOverHeightZero
            //启动事件
            (self.refreshDelegate as? RefreshProtocol)?.refreshData()
            UIView.animateWithDuration(0.3, animations: {
                self.contentInset = tmpContentInset
            })
            
        case RefreshDataType.PullDownRefreshed.rawValue:
            var tmpContentInset = self.contentInset
            tmpContentInset.top -= self.headerViewOverHeightZero
            
            UIView.animateWithDuration(0.3, animations: {
                self.contentInset = tmpContentInset
            })
            print("下拉结束")
        case RefreshDataType.PullUpIng.rawValue:
            print("上拉中")
        case RefreshDataType.PullUpOverZero.rawValue:
            print("上拉临界点")
        case RefreshDataType.PullUpRefreshing.rawValue:
            print("上拉松开手势，刷新中")
            
            if self.frame.size.height <= self.contentSize.height{
                var tmpContentInset = self.contentInset
                tmpContentInset.bottom += self.footerViewOverHeightZero
                 (self.refreshDelegate as? RefreshProtocol)?.loadMoreData()
                UIView.animateWithDuration(0.3, animations: {
                    self.contentInset = tmpContentInset
                })
            }//这种状况下就只能操作frame,但是操作失败，暂时不支持这种情况下的下拉刷新

            
        case RefreshDataType.PullUpRefreshed.rawValue:
            if self.frame.size.height <= self.contentSize.height{
                var tmpContentInset = self.contentInset
                tmpContentInset.bottom -= self.footerViewOverHeightZero
                
                UIView.animateWithDuration(0.3, animations: {
                    self.contentInset = tmpContentInset
                })
            }
        default:
            break;
        }
    
    }
    
    

    
    private enum CareType:Int {
        case onlyHeader = 0
        case onlyFooter = 1
        case both       = 3
    }
    
    private func addRefreshFooterAndHeaderView(careType:CareType = CareType.onlyHeader){
        switch self.refreshType {
        case RefreshType.PullNone.rawValue:
            self.removeHeaderFooterView()
        case RefreshType.PullDown.rawValue:
            if careType == CareType.onlyHeader || careType == CareType.both{
                self.addRefreshHeaderView()
            }
            
        case RefreshType.PullUp.rawValue:
            if careType == CareType.onlyFooter || careType == CareType.both{
                self.addRefreshFooterView()
            }
        case RefreshType.PullBoth.rawValue:
            if careType == CareType.onlyHeader || careType == CareType.both{
                self.addRefreshHeaderView()
            }
            if careType == CareType.onlyFooter || careType == CareType.both{
                self.addRefreshFooterView()
            }
            
        default:
            break;
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
    static var  isDraging       = false//是否在拖动，默认为否
    static var  publicObserve   = ObserObject()
}


//warning静止移除(在这里设置状态)
var  isDraging       = false//是否在拖动，默认为否
class ObserObject: NSObject {
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "contentOffset"{
            if let table = object as? UITableView{
                if table.refreshType == RefreshType.PullNone.rawValue {
                    return
                }
                let contentOffset       = table.contentOffset
                let contentSize         = table.contentSize
                let contentInset        = table.contentInset
                let tmpPullDownOffset   = -contentInset.top - contentOffset.y
                let tmpOffset           = contentOffset.y + contentInset.top + table.frame.size.height  - max(contentSize.height + contentInset.top, table.frame.size.height)
                if RefreshStaticParametter.isDraging != table.dragging {
                    if RefreshStaticParametter.isDraging {//拖动到不拖动
                        if table.headerViewOverHeightZero <= tmpPullDownOffset {
                            //上啦超过零界点(启动刷新)
                            if table.currentRefreshDataState != RefreshDataType.PullUpRefreshing.rawValue {
                                table.currentRefreshDataState = RefreshDataType.PullDownRefreshing.rawValue
                            }

//                            print("启动下拉刷新")
                        }
                        
                        if tmpOffset >= table.footerViewOverHeightZero{
                            //下拉刷新的时候，上啦无效
                            if table.currentRefreshDataState != RefreshDataType.PullDownRefreshing.rawValue{
                                if table.contentSize.height > table.frame.size.height{
                                    table.currentRefreshDataState = RefreshDataType.PullUpRefreshing.rawValue
                                }
                            }

                            
//                            print("启动上拉刷新")
                        }
                        
                    }else{//不拖动到拖动
                        if tmpPullDownOffset < table.headerViewOverHeightZero && 0 < tmpPullDownOffset {
                            //下拉中
                            if table.currentRefreshDataState != RefreshDataType.PullDownRefreshing.rawValue && table.currentRefreshDataState != RefreshDataType.PullUpRefreshing.rawValue{
                                 table.currentRefreshDataState = RefreshDataType.PullDownIng.rawValue
                            }
                           
//                             print("下拉中")
                        }
                        
                        if tmpOffset >= 0 && tmpOffset < table.footerViewOverHeightZero{
                            if table.currentRefreshDataState != RefreshDataType.PullDownRefreshing.rawValue && table.currentRefreshDataState != RefreshDataType.PullUpRefreshing.rawValue{
                                 table.currentRefreshDataState = RefreshDataType.PullUpIng.rawValue
                            }
                           
//                            print("上拉中")
                        
                        }
                    }
                    RefreshStaticParametter.isDraging = table.dragging
                }
                
                if table.headerViewOverHeightZero <= tmpPullDownOffset {
                    //下拉超过零界点
                    if table.currentRefreshDataState != RefreshDataType.PullDownRefreshing.rawValue && table.currentRefreshDataState != RefreshDataType.PullUpRefreshing.rawValue {
                        table.currentRefreshDataState = RefreshDataType.PullDownOverZero.rawValue
//                        print("下拉超过临界点")
                    }
                    
                }
                
                if tmpOffset >= table.footerViewOverHeightZero{
                    if table.currentRefreshDataState != RefreshDataType.PullDownRefreshing.rawValue && table.currentRefreshDataState != RefreshDataType.PullUpRefreshing.rawValue {
                        table.currentRefreshDataState = RefreshDataType.PullUpOverZero.rawValue
//                        print("上拉超过临界点:\(tmpOffset),footerViewOverHeightZero:\(table.footerViewOverHeightZero)")
                    }
                }
                
                if 0 == tmpPullDownOffset || abs(tmpOffset) < 0.1 {//0.1是模糊的数据
                    //恢复初始状态
                    if table.currentRefreshDataState != RefreshDataType.PullDownRefreshing.rawValue && table.currentRefreshDataState != RefreshDataType.PullUpRefreshing.rawValue{
                        table.currentRefreshDataState = RefreshDataType.RefreshNone.rawValue
                    }
//                    print("恢复初始状态")
                
                }
                
                
            }
        }
        
        if keyPath == "contentSize"{
            if let table = object as? UITableView{
                if table.refreshType == RefreshType.PullUp.rawValue || table.refreshType == RefreshType.PullBoth.rawValue {
                    table.footerRefreshView.hidden = table.contentSize.height < table.frame.size.height
                }
            
            }
        }
        
    }
}



