//
//  PanCakeView.swift
//  iOSComponent
//
//  Created by liyang on 16/5/31.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class PanCakeView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let shapLayer = CAShapeLayer()
        shapLayer.frame = self.bounds
        let arcCenter = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height/2.0)
        let radius    = min(self.frame.size.width, self.frame.size.height) / 2.0
        
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(3/2 * M_PI), endAngle: CGFloat(0), clockwise: true)
        
        
        shapLayer.path          = path.CGPath
        shapLayer.fillColor     = UIColor.blueColor().CGColor
        


        self.layer .addSublayer(shapLayer)
    }
    
    
}

struct PanCakeDomain {
    var fillColor               = UIColor.redColor()
    var showStr                 = ""
    var takeUpPercent:CGFloat   = 0.0//占比
    
    
}
