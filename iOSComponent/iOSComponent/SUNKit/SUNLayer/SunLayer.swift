//
//  SunLayer.swift
//  iOSComponent
//
//  Created by liyang on 16/5/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
class CornerRadiusLayer:CALayer  {
    
    
    override func display() {
        self.contentsScale = UIScreen.mainScreen().scale
        super.display()
    }
    
    var sborderWidth: CGFloat?
    
    var scornerRadius: CGFloat?
    
    var sborderColor:UIColor?
    
    override func drawInContext(ctx: CGContext) {
        
        
        //将背景色填充为父视图的颜色
        CGContextSaveGState(ctx)
        CGContextAddRect(ctx, self.bounds)
        let fillBackGroundColor = (self.delegate as! UIView).superview?.backgroundColor ?? UIColor.whiteColor()
        CGContextSetFillColorWithColor(ctx,fillBackGroundColor.CGColor)
        CGContextFillPath(ctx)
        CGContextRestoreGState(ctx)
        
        //从运行时取出参数变量
        let tcornerRadius:CGFloat   = self.scornerRadius ?? 0
        let tborderWidth:CGFloat    = self.sborderWidth ?? 0
        let tborderColor:UIColor    = self.sborderColor ?? UIColor.whiteColor()
        
        //设置圆角的Bezier曲线
        let pp = UIBezierPath(roundedRect: self.bounds, cornerRadius: tcornerRadius + tborderWidth)
        
        //填充背景色
        CGContextSaveGState(ctx)
        CGContextBeginPath(ctx)
        CGContextAddPath(ctx, pp.CGPath)
        CGContextSetFillColorWithColor(ctx, (self.delegate as! UIView).backgroundColor?.CGColor)
        CGContextFillPath(ctx)
        CGContextRestoreGState(ctx)
        
        //切掉外围
        CGContextSaveGState(ctx)
        CGContextBeginPath(ctx)
        CGContextAddPath(ctx, pp.CGPath)
        CGContextClip(ctx)
        
        
        
        //如果是图片还得绘制图片
        if let image = (self.delegate as? UIImageView)?.image{
            CGContextDrawImage(ctx, self.bounds, image.CGImage)
        }else{
            //绘制内容
            super.drawInContext(ctx)
        }
        
        //绘制边框
        CGContextSetStrokeColorWithColor(ctx, tborderColor.CGColor)
        
        CGContextAddPath(ctx, pp.CGPath)
        
        CGContextSetLineWidth(ctx, tborderWidth)
        
        CGContextStrokePath(ctx)

    }
}

