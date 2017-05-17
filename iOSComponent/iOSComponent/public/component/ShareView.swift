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
    let itemSize                        = CGSize(width: 60, height: 75)
    
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
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        
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
            let left    =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
            let top     =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
            let right   =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.right, multiplier: 1, constant:  0)
            let bottom =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant:  0)
            superview?.addConstraints([top,left,right,bottom])
        }
    }
    
    func presentWithContainerView(_ containerView:UIView?){
        containerView?.addSubview(self)
        self.addContentView()
        
        let time = DispatchTime.now() + Double(Int64(500*NSEC_PER_USEC)) / Double(NSEC_PER_SEC)
        //添加动画
        weak var weakSelf = self
        DispatchQueue.main.asyncAfter(deadline: time) {
            UIView.animate(withDuration: 0.3, animations: {
                weakSelf!.bottomViewBottom.constant = 0
                weakSelf!.layoutIfNeeded()
            }) 
        }
       
       
    }
    
    deinit{
        print("\(self) id die")
    }
    
    
    fileprivate func addContentView(){
        let bottomView  = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        let bottomViewleft      =   NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        bottomViewBottom        =   NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: ShareView.shareViewHeight)
        let bottomViewright     =   NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1, constant:  0)
        let bottomViewHeight    = NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: ShareView.shareViewHeight)
        self.addConstraints([bottomViewBottom,bottomViewleft,bottomViewright,bottomViewHeight])
        
        
        
        //add cancel Btn 
        
        let cancelBtn = UIButton()
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.setTitle("取消", for: UIControlState())
        cancelBtn.setTitleColor(UIColor.blue, for: UIControlState())
        cancelBtn.backgroundColor = UIColor.white
        bottomView.addSubview(cancelBtn)
        
        cancelBtn .addTarget(self, action: #selector(ShareView.cancelAction), for: UIControlEvents.touchUpInside)
        
        //add cancel Btn constraint
        let cancelBtnleft      =   NSLayoutConstraint(item: cancelBtn, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: bottomView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        let cancelBtnBottom    =   NSLayoutConstraint(item: cancelBtn, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: bottomView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let cancelBtnright     =   NSLayoutConstraint(item: cancelBtn, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: bottomView, attribute: NSLayoutAttribute.right, multiplier: 1, constant:  0)
        let cancelBtnHeight    = NSLayoutConstraint(item: cancelBtn, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 40)
        bottomView.addConstraints([cancelBtnleft,cancelBtnBottom,cancelBtnright,cancelBtnHeight])
        
        
        //add collectionView
        let flowLayout                                  = UICollectionViewFlowLayout()
        flowLayout.scrollDirection                      = UICollectionViewScrollDirection.horizontal
        let showCount                                   = CGFloat(min(self.dataArray.count, 4))
        self.OffsetX                                    = (ScreenWidth - itemSize.width * showCount) / (showCount + 1)
        flowLayout.minimumLineSpacing                   = self.OffsetX
        let collectionView                              = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor                  = UIColor.white
        collectionView.register(ShareViewCollectionCell.self, forCellWithReuseIdentifier: collectionViewCellIndentifier)
        collectionView.delegate                         = self
        collectionView.dataSource                       = self
        collectionView.showsVerticalScrollIndicator     = false
        collectionView.showsHorizontalScrollIndicator   = false
        bottomView.addSubview(collectionView)
        
        //add collectionView constraint
        
        let collectionViewleft      =   NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: bottomView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        let collectionViewBottom    =   NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: cancelBtn, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let collectionViewright     =   NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: bottomView, attribute: NSLayoutAttribute.right, multiplier: 1, constant:  0)
        let collectionViewTop    = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: bottomView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        bottomView.addConstraints([collectionViewleft,collectionViewBottom,collectionViewright,collectionViewTop])
        
        
        
    
    }
    
    func cancelAction(){
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomViewBottom.constant = ShareView.shareViewHeight
            self.layoutIfNeeded()
        }, completion: { (finish:Bool) in
            if finish {
                self.dismiss()
            }
        }) 
    }
    
    
    
    func dismiss(){
        self.removeFromSuperview()
    }
    
}

extension ShareView:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIndentifier, for: indexPath) as! ShareViewCollectionCell
        cell.cellDomain = self.dataArray[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
    
        return UIEdgeInsetsMake(22.5, self.OffsetX, 22.5, self.OffsetX)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("asdf:\(self.dataArray[indexPath.row])")
    }
    

    
}

extension ShareView:UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.delegate as? UIView
    }

}


class ShareViewCollectionCell: UICollectionViewCell {
    
    lazy var imageView = {()->UIImageView in
        let tmpImageView = UIImageView()
        tmpImageView.translatesAutoresizingMaskIntoConstraints = false
        tmpImageView.backgroundColor = UIColor.red
        return tmpImageView
    }()
    
    lazy var nameLabel = {() -> UILabel in
        let tmpNameLable = UILabel()
        tmpNameLable.translatesAutoresizingMaskIntoConstraints = false
        tmpNameLable.textAlignment  = NSTextAlignment.center
        tmpNameLable.font           = UIFont.systemFont(ofSize: 13)
        return tmpNameLable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(nameLabel)
        
        //add constraint
        
        let imageViewleft      =   NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        let imageViewTop    =   NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let imageViewright     =   NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.right, multiplier: 1, constant:  0)
        let imageViewHeight    = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 60)
        self.contentView.addConstraints([imageViewleft,imageViewTop,imageViewright,imageViewHeight])
        
        
        let nameLabelleft      =   NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        let nameLabelTop    =   NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: imageView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let nameLabelright     =   NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.right, multiplier: 1, constant:  0)
        let nameLabelBottom    = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
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
