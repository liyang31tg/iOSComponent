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
    
    override class var layerClass : AnyClass{
    
        return SunAsynsLayer.self
    }
    

    
   
    
}




class SunAsynsLayer: CALayer {
    
    deinit{
    
        print("sunLayer is die\(self.delegate)")
    }
    
    override init() {
        super.init()
        self.drawsAsynchronously = true
        print(self.contentsScale)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func display() {
        let scale = UIScreen.main.scale
        self.contentsScale = scale
        super.display()
    }
    
    
    override func draw(in ctx: CGContext) {
        
        super.draw(in: ctx)
        
//        CGContextScaleCTM(ctx, scale, scale)
        ctx.textMatrix = CGAffineTransform.identity;
        
        // 这两种转换坐标的方式效果一样
        // 2.1
        // CGContextTranslateCTM(contextRef, 0, self.bounds.size.height);
        // CGContextScaleCTM(contextRef, 1.0, -1.0);
        
        // 2.2
        ctx.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: self.bounds.size.height));
        
        

        
        
        
    
    
        // 3.创建绘制区域，可以对path进行个性化裁剪以改变显示区域
        let path = CGMutablePath();
        CGPathAddRect(path, nil, self.bounds);
        // CGPathAddEllipseInRect(path, NULL, self.bounds);
        
        // 4.创建需要绘制的文字
      let attributed =  NSMutableAttributedString(string: "估后共和国开不开vbdkaph估后共和国开不开vbdkaph😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️这是我的第一个coreText demo，我是要给兵来自老白干I型那个饿哦个呢给个I类回滚igkhpwfh 评估后共和国开不开vbdkaphphohghg 的分工额好几个辽宁省更怕hi维护你不看hi好人佛【井柏然把饿哦个😢😊😊😢⬇️");
      
        attributed.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(0, 5));
        
        attributed.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(3, 10));

        attributed.addAttribute(NSForegroundColorAttributeName, value: UIColor.orange, range: NSMakeRange(0, 2));

       
        
        
        
        
        // 5.根据NSAttributedString生成CTFramesetterRef
        let framesetter = CTFramesetterCreateWithAttributedString(attributed)
        
        let ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributed.length), path, nil);
        
        // 6.绘制除图片以外的部分
        CTFrameDraw(ctFrame, ctx);
        
        
      
        

        
        
        
        
    
//        dispatch_async(dispatch_get_main_queue()) {
//            UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, UIScreen.mainScreen().scale)
//        
        
//             ("Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫" as NSString).drawInRect(CGRect(x: 0, y: 0, width: 375, height: 60), withAttributes: nil)
        
//            let image =  UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            dispatch_async(dispatch_get_main_queue(), {
//                self.contents = image.CGImage
//            })
//        }
    
        
        
        
    }

    
    
}
