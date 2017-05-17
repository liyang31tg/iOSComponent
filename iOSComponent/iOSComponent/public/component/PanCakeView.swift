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
    fileprivate   var startAngleDataArray:[Double]                = []
    fileprivate   var endAngleDataArray:[Double]                  = []
    fileprivate   var percentDataArray:[Double]                   = []
    fileprivate   var radius:CGFloat                              = 0
    fileprivate   var layerCenter:CGPoint                         = CGPoint.zero
    fileprivate   var subLayer:[CAShapeLayer]                     = []
    fileprivate   var descriptionLable:[UILabel]                  = []

    func setDataAarray(_ dataArray:[PanCakeDomain]){
        
        self.dataArray = dataArray
        self.reloadData()
    }
    func reloadData(){
        self.setUp()
        self.createSubLayers()
        self.createDescriptionLable()
    }
    fileprivate func setUp(){
        self.radius         = min(self.bounds.width, self.bounds.height) / 2
        self.layerCenter    = CGPoint(x: self.bounds.width / 2, y: self.bounds.height/2)
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
    
    
    fileprivate func createSubLayers(){
        self.subLayer.removeAll()
        for (index,_) in self.dataArray.enumerated(){
            let s = self.subLayerWithIndex(index)
            self.layer.addSublayer(s)
            self.subLayer.append(s)
        
        }
    
    
    }
    
    fileprivate func subLayerWithIndex(_ index:Int) -> CAShapeLayer{
        let startAngle  = self.startAngleDataArray[index]
        let endAngle    = self.endAngleDataArray[index]
        let m           = self.dataArray[index]
        let s           = CAShapeLayer()
        s.frame         = self.bounds
        s.lineWidth     = 0
        s.strokeColor   = UIColor.clear.cgColor
        s.fillColor     = m.color.cgColor
        let path        = UIBezierPath()
        
        path.move(to: self.layerCenter)
        
        path.addArc(withCenter: self.layerCenter, radius: self.radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        
        path.addLine(to: self.layerCenter)
        
        s.path          = path.cgPath
        
        return s
    }
    
    fileprivate func createDescriptionLable(){
        self.descriptionLable.removeAll()
        for (index,_) in self.dataArray.enumerated() {
            let label =  self.descriptionLableWithIndex(index)
            self.addSubview(label)
            self.descriptionLable.append(label)
        }
    
    
    }
    
    
   fileprivate func descriptionLableWithIndex(_ index:Int) -> UILabel{
        let startAngle  = self.startAngleDataArray[index]
        let endAngle    = self.endAngleDataArray[index]
        let centerAngle = (startAngle + endAngle) / 2
        let centerX     = Double(self.radius) + cos(centerAngle) * Double(self.radius) / 2
        let centerY     = Double(self.radius) + sin(centerAngle) * Double(self.radius) / 2
        let lable = UILabel(frame: CGRect.zero)
        lable.text = String(format: "%.2f%%", self.percentDataArray[index])
        lable.font  = UIFont.systemFont(ofSize: 12)
        lable.textAlignment = NSTextAlignment.center
        lable.sizeToFit()
        lable.center = CGPoint(x: CGFloat(centerX), y: CGFloat(centerY))
        return lable
    }
    
}

struct PanCakeDomain {
    var color                   = UIColor.clear
    var value                   = 0.0
}
