//
//  PanCakeView.swift
//  iOSComponent
//
//  Created by liyang on 16/5/31.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class PanCakeView: UIView {
    var dataArray:[PanCakeDomain]!{
    
        didSet{
            self.reloadData()
        }
    }
    private   var startAngleDataArray:[Double]                = []
    private   var endAngleDataArray:[Double]                  = []
    private   var percentDataArray:[Double]                   = []
    private   var radius:CGFloat                              = 0
    private   var layerCenter:CGPoint                         = CGPointZero
    private   var subLayer:[CAShapeLayer]                     = []
    private   var descriptionLable:[UILabel]                  = []

    func setDataAarray(dataArray:[PanCakeDomain]){
        
        self.dataArray = dataArray
        self.reloadData()
    }
    func reloadData(){
        self.setUp()
        self.createSubLayers()
        self.createDescriptionLable()
    }
    private func setUp(){
        self.radius         = min(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2
        self.layerCenter    = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds)/2)
        self.startAngleDataArray.removeAll()
        self.endAngleDataArray.removeAll()
        self.percentDataArray.removeAll()
        var totalValue      = 0.0
        for d in self.dataArray{
            totalValue += d.value
        }
        var tmpValue        = 0.0
        for d in self.dataArray {
            let startAngle = (tmpValue / totalValue) * 2 * M_PI - 0.5 * M_PI
            self.startAngleDataArray.append(startAngle)
            tmpValue += d.value
            let endAngle = (tmpValue / totalValue) * 2 * M_PI - 0.5 * M_PI
            self.endAngleDataArray.append(endAngle)
            self.percentDataArray.append(d.value / totalValue)
        }
    
    }
    
    
    private func createSubLayers(){
        self.subLayer.removeAll()
        for (index,_) in self.dataArray.enumerate(){
            let s = self.subLayerWithIndex(index)
            self.layer.addSublayer(s)
            self.subLayer.append(s)
        
        }
    
    
    }
    
    private func subLayerWithIndex(index:Int) -> CAShapeLayer{
        let startAngle  = self.startAngleDataArray[index]
        let endAngle    = self.endAngleDataArray[index]
        let m           = self.dataArray[index]
        let s           = CAShapeLayer()
        s.frame         = self.bounds
        s.lineWidth     = 0
        s.strokeColor   = UIColor.clearColor().CGColor
        s.fillColor     = m.color.CGColor
        let path        = UIBezierPath()
        
        path.moveToPoint(self.layerCenter)
        
        path.addArcWithCenter(self.layerCenter, radius: self.radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        
        path.addLineToPoint(self.layerCenter)
        
        s.path          = path.CGPath
        
        return s
    }
    
    private func createDescriptionLable(){
        self.descriptionLable.removeAll()
        for (index,_) in self.dataArray.enumerate() {
            let label =  self.descriptionLableWithIndex(index)
            self.addSubview(label)
            self.descriptionLable.append(label)
        }
    
    
    }
    
    
   private func descriptionLableWithIndex(index:Int) -> UILabel{
        let startAngle  = self.startAngleDataArray[index]
        let endAngle    = self.endAngleDataArray[index]
        let centerAngle = (startAngle + endAngle) / 2
        let centerX     = Double(self.radius) + cos(centerAngle) * Double(self.radius) / 2
        let centerY     = Double(self.radius) + sin(centerAngle) * Double(self.radius) / 2
        let lable = UILabel(frame: CGRectZero)
        lable.text = String(format: "%.2f%%", self.percentDataArray[index])
        lable.font  = UIFont.systemFontOfSize(12)
        lable.textAlignment = NSTextAlignment.Center
        lable.sizeToFit()
        lable.center = CGPointMake(CGFloat(centerX), CGFloat(centerY))
        return lable
    }
    
}

struct PanCakeDomain {
    var color                   = UIColor.clearColor()
    var value                   = 0.0
}
