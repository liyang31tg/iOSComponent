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
}


class CoreTextLayer: CALayer {
    override init() {
        super.init()
        self.drawsAsynchronously = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func display() {
        self.contentsScale = UIScreen.mainScreen().scale
        super.display()
    }
    override func drawInContext(ctx: CGContext) {
        super.drawInContext(ctx)
       
        //坐标系转换
        CGContextSetTextMatrix(ctx, CGAffineTransformIdentity)
        CGContextTranslateCTM(ctx, 0, self.bounds.size.height)
        CGContextScaleCTM(ctx, 1.0, -1.0)
        
        //创建绘制的区域
        let path = CGPathCreateMutable()
        CGPathAddRect(path, nil, self.bounds)
        
        // 4.创建需要绘制的文字
        let attributed =  NSMutableAttributedString(string: "估后共和国开不开vbdkaph估后共和国开不开vbdkaph😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️这是我的第一个coreText demo，我是要给兵来自老白干I型那个饿哦个呢给个I类回滚igkhpwfh 评估后共和国开不开vbdkaphphohghg 的分工额好几个辽宁省更怕hi维护你不看hi好人佛【井柏然把饿哦个😢😊😊😢⬇️");
        
        attributed.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(20), range: NSMakeRange(0, 5));
        
        attributed.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(3, 10));
        
        attributed.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: NSMakeRange(0, 2));
        
        //创建段落属性
       let paraStyle = NSMutableParagraphStyle()
        
        attributed.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSMakeRange(0, attributed.length))
        
        //创建CTFramesetter
       let ctFrameSetter = CTFramesetterCreateWithAttributedString(attributed)
        
        //创建CTFrame
       let ctFrame = CTFramesetterCreateFrame(ctFrameSetter, CFRangeMake(0, attributed.length),path , nil)
        
        //根据CTFrame绘制
        CTFrameDraw(ctFrame, ctx)
        /*
        let imageName = "page1.jpg"
        
        var imageDelegateCallBack = CTRunDelegateCallbacks(version: kCTRunDelegateVersion1, dealloc: { (r) in
            print("run delegate is die");
            }, getAscent: { (r) -> CGFloat in
                return 100
            }, getDescent: { (r) -> CGFloat in
                return -20
            }) { (r) -> CGFloat in
                return 50
        }
        
        var asfd = "asdf"
        let   rundelegate = CTRunDelegateCreate(&imageDelegateCallBack, &asfd);
        
        let  imageAttributedString = NSMutableAttributedString(string: " ");
        
        imageAttributedString.addAttribute((kCTRunDelegateAttributeName as String), value: rundelegate!, range: NSMakeRange(0, 1))
        
        imageAttributedString.addAttribute("imageName", value: imageName, range: NSMakeRange(0, 1))//添加属性，在CTRun中可以识别出这个字符是图片
        attributed.insertAttributedString(imageAttributedString, atIndex: 60)
      
        
        
        
        
        
        // 5.根据NSAttributedString生成CTFramesetterRef
        let framesetter = CTFramesetterCreateWithAttributedString(attributed)
        
        let ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributed.length), path, nil);
        
        // 6.绘制除图片以外的部分
        CTFrameDraw(ctFrame, ctx);
        //7.3处理绘制图片逻辑
        let lines = CTFrameGetLines(ctFrame) as NSArray //存取frame中的ctlines
        
        let nsLinesArray: NSArray = CTFrameGetLines(ctFrame) // Use NSArray to bridge to Array
        let ctLinesArray = nsLinesArray as Array
        var originsArray = [CGPoint](count:ctLinesArray.count, repeatedValue: CGPointZero)
        let range: CFRange = CFRangeMake(0, 0)
        CTFrameGetLineOrigins(ctFrame, range,&originsArray)
        
        //7.2把ctFrame里每一行的初始坐标写到数组里
        //        CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), &origunsArray);
        
        // 7.3遍历CTRun找出图片所在的CTRun并进行绘制,每一行可能有多个
        for i in 0..<lines.count{
            //遍历每一行CTLine
            let line = lines[i]
            var lineAscent = CGFloat()
            var lineDescent = CGFloat()
            var lineLeading = CGFloat()
            CTLineGetTypographicBounds(line as! CTLineRef, &lineAscent, &lineDescent, &lineLeading)
            
            
            let runs = CTLineGetGlyphRuns(line as! CTLine) as NSArray
            for j in 0 ..< runs.count{
                // 遍历每一个CTRun
                var  runAscent = CGFloat()
                var  runDescent = CGFloat()
                let  lineOrigin = originsArray[i]// 获取该行的初始坐标
                
                let run = runs[j] // 获取当前的CTRun
                let attributes = CTRunGetAttributes(run as! CTRun) as NSDictionary
                let width =  CGFloat( CTRunGetTypographicBounds(run as! CTRun, CFRangeMake(0,0), &runAscent, &runDescent, nil))
                //                runRect.size.width = CGFloat( CTRunGetTypographicBounds(run as! CTRun, CFRangeMake(0,0), &runAscent, &runDescent, nil))
                // 这一段可参考Nimbus的NIAttributedLabel
                let  runRect = CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line as! CTLine, CTRunGetStringRange(run as! CTRun).location, nil), lineOrigin.y - runDescent, width, runAscent + runDescent)
                let  imageNames = attributes.objectForKey("imageName")
                print(imageNames)
                if imageNames is NSString {
                    let image = UIImage(named: imageName as String)
                    let  imageDrawRect = CGRectMake(runRect.origin.x, lineOrigin.y, runRect.width, runRect.height)
                    print("runRect:\(runRect),imageDrawRect:\(imageDrawRect)")
                    CGContextDrawImage(ctx, imageDrawRect, image!.CGImage)
                }
            }
        }*/
    }
}
