//
//  ProgressView.swift
//  iOSComponent
//
//  Created by liyang on 16/6/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation


class ProgressView: UIView {
    //属性配置
    var offsetX: CGFloat{                                   //距离2边的距离（默认两边相等）
        
        get{
            return (self.layer as! ProgressViewLayer).offsetX
        }
        set{
            (self.layer as! ProgressViewLayer).offsetX      = newValue
        }
    }
    var imageSize :CGSize {                                 //显示图片的size
        get{
            return (self.layer as! ProgressViewLayer).imageSize
        }
        set{
            (self.layer as! ProgressViewLayer).imageSize    = newValue
        }
    }
    var top2image: CGFloat {                                //头部距离图片顶部的距离
        get{
            return (self.layer as! ProgressViewLayer).top2image
        }
        set{
            (self.layer as! ProgressViewLayer).top2image    = newValue
        }
    }
    var image2title: CGFloat{                               //图片距离文本的距离
        get{
            return (self.layer as! ProgressViewLayer).image2title
        }
        set{
            (self.layer as! ProgressViewLayer).image2title  = newValue
        }
    }
    
    //数据配置
    var nodes:[ProgressNode] {
        get{
        
            return (self.layer as! ProgressViewLayer).nodes
        }
        set{
        
            (self.layer as! ProgressViewLayer).nodes = newValue
        
        }
    
    }
    
    
    
    
    fileprivate var selectIndex:Int8                            = 0
    //设置选中
    func setSelectIndex1(_ selectIndex:Int8){
        guard self.selectIndex != selectIndex else {return}
        self.selectIndex                                = selectIndex
        (self.layer as! ProgressViewLayer).selectIndex  = self.selectIndex
        self.layer.setNeedsDisplay()
    }
    
    
    override class var layerClass : AnyClass{
        return ProgressViewLayer.self
    }
    
    
}


class ProgressViewLayer: CALayer {
    var offsetX: CGFloat                            = 30            //距离2边的距离（默认两边相等）
    var imageSize                                   = CGSize.zero    //显示图片的size
    var top2image: CGFloat                          = 5             //头部距离图片顶部的距离
    var image2title: CGFloat                        = 2             //图片距离文本的距离
    var nodes:[ProgressNode]                        = []
    var selectIndex:Int8                            = 0
    
    override func display() {
        self.contentsScale = UIScreen.main.scale
        super.display()
    }
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        //坐标系转换
        ctx.textMatrix = CGAffineTransform.identity
        ctx.translateBy(x: 0, y: self.bounds.size.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        
        let nodeCount = CGFloat(self.nodes.count)
        
        let item2item = (ScreenWidth - 2*offsetX - nodeCount*imageSize.width) / (nodeCount - 1)
        
        var prePoint  = CGPoint.zero //记录上一个终点
        
        for (index,n) in nodes.enumerated(){
            let isSelect = self.selectIndex > Int8(index)
            
            let imageRect = CGRect(x: offsetX + (imageSize.width + item2item)*CGFloat(index), y: self.bounds.size.height - top2image - imageSize.height, width: imageSize.width, height: imageSize.width)
            
            let currentPoint = CGPoint(x: imageRect.midX, y: imageRect.midY)
        
            if index > 0 {//这个时候可以画线了
                ctx.saveGState()
                
                let strokePath = CGMutablePath()
                
                CGPathMoveToPoint(strokePath, nil, prePoint.x, prePoint.y)
                
                CGPathAddLineToPoint(strokePath, nil, currentPoint.x, currentPoint.y)
                
                ctx.setStrokeColor((isSelect ? n.titleSelectColor : n.titleNormalColor).cgColor)
                
                ctx.addPath(strokePath)
                
                ctx.setLineWidth(2)
                
                ctx.strokePath()
                
                ctx.restoreGState()
            }
            prePoint = currentPoint
        }
        
        
        
        
        for (index,n) in nodes.enumerated() {
            
            let isSelect = self.selectIndex > Int8(index)
            
            let imageRect = CGRect(x: offsetX + (imageSize.width + item2item)*CGFloat(index), y: self.bounds.size.height - top2image - imageSize.height, width: imageSize.width, height: imageSize.width)
            
            
            ctx.draw(UIImage(named: isSelect ? n.selectImageName : n.normalImageName)?.cgImage, in: imageRect)
            
            
            let ntitle =  NSMutableAttributedString(string: n.title)
            
            
            ntitle.addAttributes([NSForegroundColorAttributeName:isSelect ? n.titleSelectColor : n.titleNormalColor], range: NSMakeRange(0, ntitle.length))
            
            
            let titleSize       = ConvertUtil.getDisplayHeight(ntitle, width: ScreenWidth)
            
            let titleTopCenter  = CGPoint(x: imageRect.midX, y: imageRect.minY - image2title - titleSize.height)
            
            let titleRect       = CGRect(x: titleTopCenter.x - (titleSize.width / 2), y: titleTopCenter.y, width: titleSize.width, height: titleSize.height)
           
            //创建绘制的区域
            let path = CGMutablePath()
            
            CGPathAddRect(path, nil, titleRect)
            
            ctx.saveGState()
            
            ctx.setFillColor(UIColor.white.cgColor)
            ctx.addPath(path)
            
            ctx.fillPath()
            
            
            ctx.restoreGState()
            
           
            
            //创建CTFramesetter
            let ctFrameSetter = CTFramesetterCreateWithAttributedString(ntitle)
            
            //创建CTFrame
            let ctFrame = CTFramesetterCreateFrame(ctFrameSetter, CFRangeMake(0, ntitle.length),path , nil)
            
            //根据CTFrame绘制
            CTFrameDraw(ctFrame, ctx)
        }
        
        
    }
}

struct ProgressNode{
    var selectImageName     = ""
    var normalImageName     = ""
    var title               = ""
    var titleSelectColor    = UIColor.clear
    var titleNormalColor    = UIColor.clear
}
