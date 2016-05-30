//
//  PopView.swift
//  iOSComponent
//
//  Created by liyang on 16/5/30.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
protocol PopViewDelegate {
    //获得可视View的宽高
    func popViewWH() -> (width:CGFloat,height:CGFloat)
}

enum PopViewPosition:String {
    case Top            = "正上"
    case Left           = "正左"
    case Rigth          = "正右"
    case Bottom         = "正下"
    
    case TopLeft        = "上左"
    case TopRight       = "上右"
    
    case LeftTop        = "左上"
    case LeftBottom     = "左下"
    
    case BottomLeft     = "下左" //only support
    case BottomRight    = "下右"
    
    case RightTop       = "右上"
    case RightBottom    = "右下"
}


class PopView: UIView {
    
    //module 的作用
    private struct PopViewProperty{
      static  let imageName                 = "pop_background"
      static  let view2ViewOffset:CGFloat   =  10 //子视图和弹出视图之前的距离
      static  let triangleHeight:CGFloat    =  7 //根据图片来的，三角高度
    }
    
    private static var popViewWindow:BaseWindow?
    
    
    private var contentImageView = UIImageView()
    private var popViewFrame     = CGRectZero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints                  = false
        self.contentImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentImageView)
        
        //addConstrant
        let left = NSLayoutConstraint(item: contentImageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: contentImageView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
        
        let top = NSLayoutConstraint(item: contentImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: contentImageView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        
        self.addConstraints([left,right,top,bottom])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
   

    /*
     *subframe //映射到window上的frame
     *
     *subBoundsDelegate 获得可视View的宽高
     *
     *contentView 内容显示的View，内部约束自己控制didMoveToSuperview这里面设置约束
     */
    class func popViewShowInWindow(subframe:CGRect,subBoundsDelegate:PopViewDelegate,contentView:UIView,autoPosition:PopViewPosition? = nil){
        let popViewWH           = subBoundsDelegate.popViewWH()
        let originalImage       = UIImage(named: PopViewProperty.imageName)!
        //估算视图是该放在左上还是左下，除非固定死
        let result                      = getFrameByPosition(subframe, popViewWH: popViewWH, originalImage: originalImage, autoPosition: PopViewPosition.BottomLeft)
        let popView                     = PopView(frame: CGRectZero)
        popView.popViewFrame            = result.0
        popView.contentImageView.image  = result.1
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        popView.addSubview(contentView)
        
        self.popViewWindow              = BaseWindow()
        let tap = UITapGestureRecognizer(target: self, action: #selector(PopView.HiddlenPopView))
        self.popViewWindow?.rootViewController?.view.addGestureRecognizer(tap)
        self.popViewWindow!.rootViewController?.view.addSubview(popView)
        self.popViewWindow!.windowLevel           = UIWindowLevelAlert
        self.popViewWindow!.backgroundColor       = UIColor.blackColor().colorWithAlphaComponent(0.1)
        self.popViewWindow!.makeKeyAndVisible()
    
    }
    
    class func HiddlenPopView(){
        self.popViewWindow?.resignFirstResponder()
        self.popViewWindow?.resignKeyWindow()
        self.popViewWindow?.windowLevel = UIWindowLevelNormal
        ((UIApplication.sharedApplication().delegate) as! AppDelegate).window?.makeKeyAndVisible()
        self.popViewWindow  = nil
    
    
    }
    /*
     *暂时不支持，有时间再扩展，这个方法就是，动态计算出最合理的PopViewPosition
     *
     *
     */
    
    class private func calulateFrame(){
    
    
    }
    /*subFrame 触发View的frame
     *
     *popViewWH 弹出视图的Size
     *
     *originalImage 拉伸之前的背景图片，用于得到尺寸和拉伸
     *
     ＊autoPosition 这个就不说了，枚举值很好的说明
     */
    
    class private func getFrameByPosition(subFrame:CGRect,popViewWH:(width:CGFloat,height:CGFloat),originalImage:UIImage,autoPosition:PopViewPosition) -> (CGRect,UIImage) {
        let subFrameW_2         = subFrame.size.width / 2.0

        let imageOriginSize     = originalImage.size
        let imageOriginSizeW_2  = imageOriginSize.width / 2.0
        switch autoPosition {
            case .Top:
                break
            case .Left:
                break
            case .Rigth:
                break
            case .Bottom:
                break
            case .TopLeft:
                break
            case .TopRight:
                break
            case .LeftTop:
                break
            case .LeftBottom:
                break
            case .BottomLeft:
                let originX = (subFrame.origin.x + subFrameW_2) - (popViewWH.width - imageOriginSizeW_2)
                let newImage = originalImage.resizableImageWithCapInsets(UIEdgeInsetsMake(imageOriginSize.height - 2, 1, 1, imageOriginSize.width - 2), resizingMode: UIImageResizingMode.Stretch)
                return (CGRect(x: originX, y: subFrame.origin.y + subFrame.size.height + PopViewProperty.view2ViewOffset, width: popViewWH.width, height: popViewWH.height) ,newImage)
            case .BottomRight:
                break
            case .RightTop:
                break
            case .RightBottom:
                break
        }
        return (CGRectZero,UIImage())
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superView = self.superview {
            let left    =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: superView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: self.popViewFrame.origin.x)
            let top     =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: superView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: self.popViewFrame.origin.y)
            let width   =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant:  self.popViewFrame.size.width)
            let height =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant:  self.popViewFrame.size.height)
            superview?.addConstraints([top,left,width,height])
        }
    }
    

}


class PopContentView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PopContentView.tapAction)))
    }
    
    func tapAction(){
    
        print("tapAction")
        PopView.HiddlenPopView()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superView = self.superview {
            let left    =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: superView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
            let right     =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: superView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
            let bottom   =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: superView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant:  0)
            let top =   NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: superView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant:7)
            superview?.addConstraints([left,right,bottom,top])
        }
    }
    
    
}
