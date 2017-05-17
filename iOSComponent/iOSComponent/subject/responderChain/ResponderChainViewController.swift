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
        self.view.backgroundColor = UIColor.white
        
    }
}



class UIViewA: UIView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch begin A")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            var tmpView:UIView?     = self
            let subviews = self.subviews
            let reverseView = subviews
            for subview in reverseView {
               let tmpPoint = subview.convert(point, from: self)
                if subview.point(inside: tmpPoint, with: event){
                    let view = subview.hitTest(tmpPoint, with: event)
                    if let sv = view {
                        tmpView     = sv
                        break
                    }
                }
            }
            return tmpView
        
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        if self.alpha <= 0.01 || !self.isUserInteractionEnabled || self.isHidden {
        
            return false
        }
        return self.bounds.contains(point)
    }
    
}


class UIViewB: UIView {
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch           = touches.first
        
        if let t = touch {
            //当前坐标点
            let point           =   t.location(in: self)
            //上一个坐标点
            let precisePoint    =   t.previousLocation(in: self)
            
            let offsetX = point.x - precisePoint.x
            let offsetY = point.y - precisePoint.y
            
            self.transform = self.transform.translatedBy(x: offsetX, y: offsetY)
            
        }
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var tmpView:UIView?     = self
        let subviews = self.subviews
        let reverseView = subviews.reversed()
        for subview in reverseView {
            let tmpPoint = subview.convert(point, from: self)
            if subview.point(inside: tmpPoint, with: event){
                let view = subview.hitTest(tmpPoint, with: event)
                if let sv = view {
                    tmpView     = sv
                    break
                }
            }
        }
        return tmpView
        
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        if self.alpha <= 0.01 || !self.isUserInteractionEnabled || self.isHidden {
            
            return false
        }
        return self.bounds.contains(point)
    }

    
}

class UIViewC: UIView {
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch           = touches.first
        
        if let t = touch {
            //当前坐标点
            let point           =   t.location(in: self)
            //上一个坐标点
            let precisePoint    =   t.previousLocation(in: self)
            
            let offsetX = point.x - precisePoint.x
            let offsetY = point.y - precisePoint.y
            
            self.transform = self.transform.translatedBy(x: offsetX, y: offsetY)
            
        }
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var tmpView:UIView?     = self
        let subviews = self.subviews
        let reverseView = subviews.reversed()
        for subview in reverseView {
            let tmpPoint = subview.convert(point, from: self)
            if subview.point(inside: tmpPoint, with: event){
                let view = subview.hitTest(tmpPoint, with: event)
                if let sv = view {
                    tmpView     = sv
                    break
                }
            }
        }
        return tmpView
        
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        if self.alpha <= 0.01 || !self.isUserInteractionEnabled || self.isHidden {
            
            return false
        }
        return self.bounds.contains(point)
    }


}


class UIViewD: UIView {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch           = touches.first
        
        if let t = touch {
            //当前坐标点
            let point           =   t.location(in: self)
            //上一个坐标点
            let precisePoint    =   t.previousLocation(in: self)
            
            let offsetX = point.x - precisePoint.x
            let offsetY = point.y - precisePoint.y
            
            self.transform = self.transform.translatedBy(x: offsetX, y: offsetY)
            
        }
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var tmpView:UIView?     = self
        let subviews = self.subviews
        let reverseView = subviews.reversed()
        for subview in reverseView {
            let tmpPoint = subview.convert(point, from: self)
            if subview.point(inside: tmpPoint, with: event){
                let view = subview.hitTest(tmpPoint, with: event)
                if let sv = view {
                    tmpView     = sv
                    break
                }
            }
        }
        return tmpView
        
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        if self.alpha <= 0.01 || !self.isUserInteractionEnabled || self.isHidden {
            
            return false
        }
        return self.bounds.contains(point)
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch begin D")
    }
    
}




