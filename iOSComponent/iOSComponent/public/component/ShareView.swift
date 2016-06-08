//
//  ShareView.swift
//  iOSComponent
//
//  Created by liyang on 16/6/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class ShareView: UIView {
    
    static var shareViewHeight:CGFloat  = 160
    var bottomViewBottom:NSLayoutConstraint!
    let collectionViewCellIndentifier   = "collectionViewCellIndentifier"
    var OffsetX:CGFloat             = 10
    let itemSize                        = CGSizeMake(60, 75)
    
    lazy var dataArray:[ShareViewCollectionCellDomain]               = {()->[ShareViewCollectionCellDomain] in
        var tmpDataArray :[ShareViewCollectionCellDomain]           = []
        
        let m = ShareViewCollectionCellDomain(imageName: "tabbar_mainframeHL", name: "朋友圈")
        
        for _ in 0..<2 {
            tmpDataArray.append(m)
        }
        
        return tmpDataArray
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints  = false
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ShareView.dismiss))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        
    }
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superView = self.superview {
            let left    =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: superView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
            let top     =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: superView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
            let right   =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: superView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant:  0)
            let bottom =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: superView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant:  0)
            superview?.addConstraints([top,left,right,bottom])
        }
    }
    
    func presentWithContainerView(containerView:UIView?){
        containerView?.addSubview(self)
        self.addContentView()
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(500*NSEC_PER_USEC))
        //添加动画
        weak var weakSelf = self
        dispatch_after(time, dispatch_get_main_queue()) {
            UIView.animateWithDuration(0.3) {
                weakSelf!.bottomViewBottom.constant = 0
                weakSelf!.layoutIfNeeded()
            }
        }
       
       
    }
    
    deinit{
        print("\(self) id die")
    }
    
    
    private func addContentView(){
        let bottomView  = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        let bottomViewleft      =   NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        bottomViewBottom        =   NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: ShareView.shareViewHeight)
        let bottomViewright     =   NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant:  0)
        let bottomViewHeight    = NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: ShareView.shareViewHeight)
        self.addConstraints([bottomViewBottom,bottomViewleft,bottomViewright,bottomViewHeight])
        
        
        
        //add cancel Btn 
        
        let cancelBtn = UIButton()
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.setTitle("取消", forState: UIControlState.Normal)
        cancelBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        cancelBtn.backgroundColor = UIColor.whiteColor()
        bottomView.addSubview(cancelBtn)
        
        cancelBtn .addTarget(self, action: #selector(ShareView.cancelAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        //add cancel Btn constraint
        let cancelBtnleft      =   NSLayoutConstraint(item: cancelBtn, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: bottomView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        let cancelBtnBottom    =   NSLayoutConstraint(item: cancelBtn, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: bottomView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        let cancelBtnright     =   NSLayoutConstraint(item: cancelBtn, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: bottomView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant:  0)
        let cancelBtnHeight    = NSLayoutConstraint(item: cancelBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40)
        bottomView.addConstraints([cancelBtnleft,cancelBtnBottom,cancelBtnright,cancelBtnHeight])
        
        
        //add collectionView
        let flowLayout                                  = UICollectionViewFlowLayout()
        flowLayout.scrollDirection                      = UICollectionViewScrollDirection.Horizontal
        let showCount                                   = CGFloat(min(self.dataArray.count, 4))
        self.OffsetX                                    = (ScreenWidth - itemSize.width * showCount) / (showCount + 1)
        flowLayout.minimumLineSpacing                   = self.OffsetX
        let collectionView                              = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor                  = UIColor.whiteColor()
        collectionView.registerClass(ShareViewCollectionCell.self, forCellWithReuseIdentifier: collectionViewCellIndentifier)
        collectionView.delegate                         = self
        collectionView.dataSource                       = self
        collectionView.showsVerticalScrollIndicator     = false
        collectionView.showsHorizontalScrollIndicator   = false
        bottomView.addSubview(collectionView)
        
        //add collectionView constraint
        
        let collectionViewleft      =   NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: bottomView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        let collectionViewBottom    =   NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: cancelBtn, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        let collectionViewright     =   NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: bottomView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant:  0)
        let collectionViewTop    = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: bottomView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        bottomView.addConstraints([collectionViewleft,collectionViewBottom,collectionViewright,collectionViewTop])
        
        
        
    
    }
    
    func cancelAction(){
        UIView.animateWithDuration(0.3, animations: {
            self.bottomViewBottom.constant = ShareView.shareViewHeight
            self.layoutIfNeeded()
        }) { (finish:Bool) in
            if finish {
                self.dismiss()
            }
        }
    }
    
    
    
    func dismiss(){
        self.removeFromSuperview()
    }
    
}

extension ShareView:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionViewCellIndentifier, forIndexPath: indexPath) as! ShareViewCollectionCell
        cell.cellDomain = self.dataArray[indexPath.row]
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
    
        return UIEdgeInsetsMake(22.5, self.OffsetX, 22.5, self.OffsetX)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
    
        return itemSize
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        print("asdf:\(self.dataArray[indexPath.row])")
    }
    

    
}

extension ShareView:UIGestureRecognizerDelegate{
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.delegate as? UIView
    }

}


class ShareViewCollectionCell: UICollectionViewCell {
    
    lazy var imageView = {()->UIImageView in
        let tmpImageView = UIImageView()
        tmpImageView.translatesAutoresizingMaskIntoConstraints = false
        tmpImageView.backgroundColor = UIColor.redColor()
        return tmpImageView
    }()
    
    lazy var nameLabel = {() -> UILabel in
        let tmpNameLable = UILabel()
        tmpNameLable.translatesAutoresizingMaskIntoConstraints = false
        tmpNameLable.textAlignment  = NSTextAlignment.Center
        tmpNameLable.font           = UIFont.systemFontOfSize(13)
        return tmpNameLable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(nameLabel)
        
        //add constraint
        
        let imageViewleft      =   NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        let imageViewTop    =   NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        let imageViewright     =   NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant:  0)
        let imageViewHeight    = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 60)
        self.contentView.addConstraints([imageViewleft,imageViewTop,imageViewright,imageViewHeight])
        
        
        let nameLabelleft      =   NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        let nameLabelTop    =   NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: imageView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        let nameLabelright     =   NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant:  0)
        let nameLabelBottom    = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        self.contentView.addConstraints([nameLabelleft,nameLabelTop,nameLabelright,nameLabelBottom])
    }
    
    var cellDomain:ShareViewCollectionCellDomain{
        get{
            return ShareViewCollectionCellDomain()
        }
        
        set{
            self.imageView.image = UIImage(named: newValue.imageName)
            
            self.nameLabel.text = newValue.name
        
        
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct ShareViewCollectionCellDomain {
    var imageName   = ""
    var name        = ""
}