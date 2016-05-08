//
//  CoreTextViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/4/25.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class CoreTextViewController: BaseViewController {
    
    
    lazy var subview: CoreTextView = {
        let tmpSubView = CoreTextView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        tmpSubView.backgroundColor = UIColor.whiteColor()
        return tmpSubView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.subview)
        self.subview.center = self.view.center
        self.subview.layer.setNeedsDisplay()
        
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
   
    
    
}


class CoreTextView: UIView {
    
    override class func layerClass() -> AnyClass{
    
        return CoreTextLayer.self
    }
    
//    override func drawRect(rect: CGRect) {
//        super.drawRect(rect)
//        let ctx = UIGraphicsGetCurrentContext()!
//        // 步骤 2
//        
//        
//        CGContextSetTextMatrix(ctx, CGAffineTransformIdentity)
//        CGContextTranslateCTM(ctx, 0, self.bounds.size.height)
//        CGContextScaleCTM(ctx, 1.0, -1.0)
//        
//        // 步骤 3
//        let path = CGPathCreateMutable()
//        CGPathAddEllipseInRect(path, nil, self.bounds)
//        
//        // 步骤 4
//        let str = "Lay out text and perform font handling with the Core Text framework. The text layout API provides high-quality typesetting, including character-to-glyph conversion and positioning of glyphs in lines and paragraphs. The complementary font technology provides features such as automatic font substitution (cascading), font descriptors and collections, and easy access to font metrics and glyph data."
//        let attString   = NSMutableAttributedString(string: str)
//        
//        let fontRef = CTFontCreateWithName("ArialMT", 30, nil)
//        attString.addAttribute(kCTFontAttributeName as String, value: fontRef, range:NSMakeRange(0, 7))
//        
//        let restrictSize = CGSizeMake(200, 1000)
//        let framesetter = CTFramesetterCreateWithAttributedString(attString)
//        let coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), nil, restrictSize, nil)
//        let frame       = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, (str as NSString).length), path, nil)
//        
//        // 步骤 5
//        
//        CTFrameDraw(frame, ctx)
//    }
    
    
}


class CoreTextLayer: CALayer {
    let queue11 = dispatch_queue_create("asdfasd", nil)
    override func display() {
        super.contents = super.contents
        let size = self.bounds.size
        let opaque = self.opaque
        let scale = UIScreen.mainScreen().scale
        
        dispatch_async(queue11) {
            UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
            let ctx = UIGraphicsGetCurrentContext()!
            CGContextSetTextMatrix(ctx, CGAffineTransformIdentity)
            CGContextTranslateCTM(ctx, 0, self.bounds.size.height)
            CGContextScaleCTM(ctx, 1.0, -1.0)
            
            CGContextSaveGState(ctx)
            
            CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
            CGContextAddRect(ctx, CGRectMake(0, 0, size.width * scale, size.height * scale))
            CGContextFillPath(ctx)
            
            CGContextRestoreGState(ctx)
            
            CGContextSetAllowsAntialiasing(ctx, true)
            
            // 步骤 3
            let path = CGPathCreateMutable()
            CGPathAddEllipseInRect(path, nil, self.bounds)
            
            // 步骤 4
            let str = "Lay out text and perform font handling with the Core Text framework. The text layout API provides high-quality typesetting, including character-to-glyph conversion and positioning of glyphs in lines and paragraphs. The complementary font technology provides features such as automatic font substitution (cascading), font descriptors and collections, and easy access to font metrics and glyph data."
            let attString   = NSMutableAttributedString(string: str)
            
            
            
            let restrictSize = CGSizeMake(200, 1000)
            let framesetter = CTFramesetterCreateWithAttributedString(attString)
            let frame       = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, (str as NSString).length), path, nil)
            
            // 步骤 5
            
            CTFrameDraw(frame, ctx)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            dispatch_async(dispatch_get_main_queue(), {
                self.contents = image.CGImage
            })
            

        }
        
        
        
    }
    
   }
