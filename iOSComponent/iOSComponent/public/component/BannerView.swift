//
//  BannerView.swift
//  handTreasure
//
//  Created by liyang on 16/4/30.
//  Copyright © 2016年 liyang. All rights reserved.
//
/*
 组建说明，对于循环的都是3个cell在不断更替，对于不循环的，都是创建所有的cell，但是cell的内容填充，需要缓存个数由optional func bannerViewCacheCellCount(bannerView:BannerView) -> Int控制
 */

import Foundation
import UIKit
@objc
protocol BannerViewDelegate{
    func bannerView(bannerView:BannerView,cell:UIView,index:Int)
    func numberOfBannerView(bannerView:BannerView) -> Int
    optional func bannerView(bannerView:BannerView,didIndex:Int)
    //MARK:注册的时候回调
    optional func initBannerCellView(bannerView:BannerView,cellView:UIView)
    //MARK:是否响应轻击事件
    optional func isResponderTapAction(bannerView:BannerView) -> Bool
    //MARK:是否启动定时器
    optional func isResponderTimeAction(bannerView:BannerView) -> Bool
    //MARK:show which index
    optional func bannerView(bannerView:BannerView,showWhichIndex:Int)
    //MARK:是否循环滚动（主要针对新闻列表，手动滑动到最后一个，是否可循环）
    optional func bannerViewIsCycle(bannerView:BannerView) -> Bool
    //MARK:对于不循环的缓存初始化几个cell,默认初始化一个
    optional func bannerViewCacheCellCount(bannerView:BannerView) -> Int
    
}

class BannerView: UIView,UIScrollViewDelegate {
    //config start ----
    var  bannerViewCell:AnyClass?{
        didSet{
            if let _ = self.delegate {
                self.fillContent()
            }
        }
    }
    var delegate:BannerViewDelegate?{
        didSet{
            if let _ =  self.bannerViewCell {
                self.fillContent()
            }
        }
        
    }
    //MARK:类似tableView的reloadData
    func reloadData(){
        if self.numberCount == 0 {
            self.fillContent()
        }
        self.showPage(0)
    }
    //config end  ---
    private lazy var cellViews:[UIView] = {
        return []
    }()
    private var bannerViewSize:CGSize!
    private var imageCount                  = 3 //不可修改
    private var currentPage                 = 0
    private var timer:NSTimer?
    private let repeatTime:NSTimeInterval   = 5
    private var tap:UITapGestureRecognizer!
    private var isCycle                     = true//是否循环（循环滑动）
    private var cacheCount                  = 1   //默认先初始化一个
    private var numberCount                 = 0   //有多少个cell
    private var isFirst                     = true //声明周期只执行一次，来判断
    private lazy  var contentScrollView:UIScrollView = {
        let tmpScrollView = UIScrollView()
        tmpScrollView.delegate = self
        tmpScrollView.translatesAutoresizingMaskIntoConstraints = false
        tmpScrollView.bounces = false
        tmpScrollView.showsHorizontalScrollIndicator = false
        tmpScrollView.showsVerticalScrollIndicator = false
        tmpScrollView.pagingEnabled = true
        return tmpScrollView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(contentScrollView)
        //add Constraints
        let actop       = NSLayoutConstraint(item: contentScrollView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        let acleading   = NSLayoutConstraint(item: contentScrollView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        let actrailing  = NSLayoutConstraint(item: contentScrollView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        let acbottom    = NSLayoutConstraint(item: contentScrollView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        self.addConstraints([actop,acleading,actrailing,acbottom])
        
        self.tap = UITapGestureRecognizer(target: self, action: #selector(BannerView.tapAction))
        self.addGestureRecognizer(self.tap)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //初始化定时器
        if let _ = self.delegate,let _ = self.bannerViewCell {
            if let isCanTime = self.delegate?.isResponderTimeAction?(self) where isCanTime == false {
            } else {
                self.timer = NSTimer.scheduledTimerWithTimeInterval(repeatTime, target: self, selector: #selector(BannerView.repeatAction(_:)), userInfo: nil, repeats: true)
            }
        }
        if let isCanTap = self.delegate?.isResponderTapAction?(self) where isCanTap == false {
            self.tap.enabled = false
        }
        self.bannerViewSize = self.frame.size
        if self.isFirst {
            self.showPage(0, isCycle: self.isCycle)//因为在外面，如果这个控件的尺寸变了会重新渲染这个view，重新调用这个方法会造成数据混乱
            self.isFirst = false
        }
        
    }
    
    
    //MARK:public func 0开始
    func showPage(pageIndex:Int,isCycle:Bool = false,isscrollAnimation:Bool = false){
        if  self.isCycle {
            let tmpAllCount = self.numberCount - 1
            let allCount = tmpAllCount > 0 ? tmpAllCount : 0
            self.currentPage = pageIndex < 0 ? allCount : pageIndex > allCount ? 0 : pageIndex
            for (index,v) in self.cellViews.enumerate() {
                let tmpIndex = self.currentPage + Int(index) - 1
                self.delegate!.bannerView(self, cell: v, index: tmpIndex < 0 ? allCount : tmpIndex > allCount ? 0 : tmpIndex)
            }
            if isCycle {
                contentScrollView.setContentOffset(CGPointMake(bannerViewSize.width, 0), animated: false)
            }
        }else{
            self.currentPage = pageIndex
            for (index,v) in self.cellViews.enumerate() {
                if index >= pageIndex && index < pageIndex + self.cacheCount {
                    self.delegate!.bannerView(self, cell: v, index: index)
                }
            }
            contentScrollView.setContentOffset(CGPointMake(bannerViewSize.width * CGFloat(self.currentPage), 0), animated: isscrollAnimation)
        }
        
        
        self.delegate?.bannerView?(self, showWhichIndex: self.currentPage)
       
    }
    //MARK:获得具体显示的View
    func getShowView(index:Int) -> UIView{
        
        return self.cellViews[(index % imageCount)]
    }
    
    //MARK: ScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        if self.isCycle {
            if offsetX == self.bannerViewSize.width * 2 {
                self.showPage(self.currentPage+1, isCycle: true)
            }
            if offsetX == 0 {
                self.showPage(self.currentPage-1, isCycle: true)
            }
        }else{
         
                let o = offsetX / self.bannerViewSize.width
                let x = offsetX % self.bannerViewSize.width
                if x == 0 {
                    if self.currentPage != Int(o) {
                        self.showPage(Int(o))
                    }
                }
        }
       
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.timer?.invalidate()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let isCanTime = self.delegate?.isResponderTimeAction?(self) where isCanTime == false {
            return
        }
        self.timer = NSTimer.scheduledTimerWithTimeInterval(repeatTime, target: self, selector: #selector(BannerView.repeatAction(_:)), userInfo: nil, repeats: true)
    }
    func tapAction(){
        self.delegate?.bannerView?(self, didIndex: self.currentPage)
    }
    func repeatAction(timer:NSTimer){
        contentScrollView.setContentOffset(CGPointMake(bannerViewSize.width * 2, 0), animated: true)
    }
    private  func fillContent(){
        self.updateContentView()
    }
    
    // 根据各种条件刷新View
  private  func updateContentView(){
        self.contentScrollView.removeConstraints(self.contentScrollView.constraints)
        for subview in self.contentScrollView.subviews{
            subview.removeFromSuperview()
        }
        self.numberCount = self.delegate!.numberOfBannerView(self)
        if self.numberCount == 0{
            return
        }
        if let isCycle = self.delegate?.bannerViewIsCycle?(self) where isCycle == false{
            self.isCycle = false
        }else{
            self.isCycle = true
        }
    
        if let cacheCount = self.delegate?.bannerViewCacheCellCount?(self) {
            self.cacheCount = cacheCount
        }
    
        if !self.isCycle {
            self.imageCount = self.numberCount
        }
        if let cell = self.bannerViewCell{
            var preImageView:UIView!
            for t in 1...imageCount {
                let tmpImageView:UIView!
                if cell is UICollectionView.Type {
                    tmpImageView = (cell as! UICollectionView.Type).init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewLayout())
                    tmpImageView.tag = t //临时客串，暂时在只有不循环的时候才有意义
                }else{
                     tmpImageView    = (cell as! UIView.Type).init() //这里是桥接了一个class
                }
                self.delegate?.initBannerCellView?(self, cellView: tmpImageView)
                self.cellViews.append(tmpImageView)
                tmpImageView.translatesAutoresizingMaskIntoConstraints = false
                self.contentScrollView.addSubview(tmpImageView)
                
                let titop       = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentScrollView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
                let tibottom    = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentScrollView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
                let tiwidth       = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentScrollView, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
                let tiheight    = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: contentScrollView, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
                self.contentScrollView.addConstraints([titop,tibottom,tiwidth,tiheight])
                
                //addConstraint
                if t == 1 {//the first picture
                    let tileading   = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: contentScrollView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
                    self.contentScrollView.addConstraints([tileading])
                    if  self.imageCount == 1{
                        let titrailing  = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: contentScrollView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
                        self.contentScrollView.addConstraints([titrailing])
                    }
                }else if t == imageCount {//the last picture
                    let pretileading   = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: preImageView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
                    let titrailing  = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: contentScrollView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
                    self.contentScrollView.addConstraints([pretileading,titrailing])
                }else{//other
                    let pretileading   = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: preImageView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
                    self.contentScrollView.addConstraint(pretileading)
                }
                preImageView        = tmpImageView
            }
        }
    }
    
    
    
}