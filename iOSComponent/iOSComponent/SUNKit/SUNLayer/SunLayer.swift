//
//  SunLayer.swift
//  iOSComponent
//
//  Created by liyang on 16/5/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class CornerRadiusLayer:CALayer  {
    
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
        CGContextSaveGState(ctx)
        CGContextBeginPath(ctx)
        CGContextAddPath(ctx, pp.CGPath)
        CGContextClip(ctx)
        
        
        
        //绘制内容
        super.drawInContext(ctx)
        
        //绘制边框
        CGContextSetStrokeColorWithColor(ctx, tborderColor.CGColor)
        
        CGContextAddPath(ctx, pp.CGPath)
        
        CGContextSetLineWidth(ctx, tborderWidth)
        
        CGContextStrokePath(ctx)

    }
}

