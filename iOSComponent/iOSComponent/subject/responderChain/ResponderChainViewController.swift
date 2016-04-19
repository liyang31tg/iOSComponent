//
//  ResponderChainViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/4/15.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class ResponderChainViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
    }
}



class UIViewA: UIView {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touch begin A")
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        var tmpView:UIView?     = self
        if self.pointInside(point, withEvent: event){
            let subviews = self.subviews
            let reverseView = subviews.reverse()
            for subview in reverseView {
               let tmpPoint = subview.convertPoint(point, fromView: self)
               let view = subview.hitTest(tmpPoint, withEvent: event)
                if let sv = view {
                    tmpView     = sv
                    break
                }
            }
        }
        return tmpView
        
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        
        if self.alpha <= 0.01 || !self.userInteractionEnabled || self.hidden {
        
            return false
        }
        return CGRectContainsPoint(self.bounds, point)
    }
    
}


class UIViewB: UIView {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touch begin B")
        
        var firstReponder:UIResponder? = self
        
        while(firstReponder != nil)
        {
            print(firstReponder!.description)
            firstReponder = firstReponder?.nextResponder()
        
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch           = touches.first
        
        if let t = touch {
            //当前坐标点
            let point           =   t.locationInView(self)
            //上一个坐标点
            let precisePoint    =   t.previousLocationInView(self)
            
            let offsetX = point.x - precisePoint.x
            let offsetY = point.y - precisePoint.y
            
            self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY)
            
        }
        
    }
    
    
//    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
//        print("hitViewTest  B")
//        return self
//    }
    
//    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
//        return false
//    }
    
}

class UIViewC: UIView {
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        print("touch begin C")
//    }
//    
//    
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let touch           = touches.first
//        
//        if let t = touch {
//            //当前坐标点
//            let point           =   t.locationInView(self)
//            //上一个坐标点
//            let precisePoint    =   t.previousLocationInView(self)
//            
//            let offsetX = point.x - precisePoint.x
//            let offsetY = point.y - precisePoint.y
//            
//            self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY)
//
//        }
//        
//    }
    
//    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
//        print("hitTest    C")
//        return self
//    }
}


class UIViewD: UIView {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touch begin D")
    }
    
}

class ii: UIApplication {
    
}


