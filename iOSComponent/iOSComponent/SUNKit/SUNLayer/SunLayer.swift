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
        self.contentsScale = UIScreen.main.scale
        super.display()
    }
    
    var sborderWidth: CGFloat?
    
    var scornerRadius: CGFloat?
    
    var sborderColor:UIColor?
    
    override func draw(in ctx: CGContext) {
        
        
        //将背景色填充为父视图的颜色
        ctx.saveGState()
        ctx.addRect(self.bounds)
        let fillBackGroundColor = (self.delegate as! UIView).superview?.backgroundColor ?? UIColor.white
        ctx.setFillColor(fillBackGroundColor.cgColor)
        ctx.fillPath()
        ctx.restoreGState()
        
        //从运行时取出参数变量
        let tcornerRadius:CGFloat   = self.scornerRadius ?? 0
        let tborderWidth:CGFloat    = self.sborderWidth ?? 0
        let tborderColor:UIColor    = self.sborderColor ?? UIColor.white
        
        //设置圆角的Bezier曲线
        let pp = UIBezierPath(roundedRect: self.bounds, cornerRadius: tcornerRadius + tborderWidth)
        
        //填充背景色
        ctx.saveGState()
        ctx.beginPath()
        ctx.addPath(pp.cgPath)
        ctx.setFillColor(((self.delegate as! UIView).backgroundColor?.cgColor)!)
        ctx.fillPath()
        ctx.restoreGState()
        
        //切掉外围
        ctx.saveGState()
        ctx.beginPath()
        ctx.addPath(pp.cgPath)
        ctx.clip()
        
        
        
        //如果是图片还得绘制图片
        if let image = (self.delegate as? UIImageView)?.image{
            ctx.draw(image.cgImage!, in: self.bounds)
        }else{
            //绘制内容
            super.draw(in: ctx)
        }
        
        //绘制边框
        ctx.setStrokeColor(tborderColor.cgColor)
        
        ctx.addPath(pp.cgPath)
        
        ctx.setLineWidth(tborderWidth)
        
        ctx.strokePath()

    }
}

