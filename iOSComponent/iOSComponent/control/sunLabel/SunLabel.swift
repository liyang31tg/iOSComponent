//
//  SunLabel.swift
//  iOSComponent
//
//  Created by liyang on 16/4/22.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class SunLabel: UIView {
    
    var text: String?
    var attributedText: NSAttributedString? {
    
        didSet{
            self.layer.setNeedsDisplay()
        }
    }
    
    override class func layerClass() -> AnyClass{
    
        return SunAsynsLayer.self
    }
    
//    override func drawRect(rect: CGRect) {
//        super.drawRect(rect)
//        
//    }
    
   
    
}




class SunAsynsLayer: CALayer {
    
    deinit{
    
        print("sunLayer is die\(self.delegate)")
    }
    
    override func display() {
         ("Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫" as NSString).drawInRect(CGRect(x: 0, y: 0, width: 375, height: 60), withAttributes: nil)
    }
    
    
    override func drawInContext(ctx: CGContext) {
        super.drawInContext(ctx)
        
        
    
//        dispatch_async(dispatch_get_main_queue()) {
//            UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, self.contentsScale)
        
            
        
//            let image =  UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            dispatch_async(dispatch_get_main_queue(), {
//                self.contents = image.CGImage
//            })
//        }
       
        
        
        
    }

    
    
}
