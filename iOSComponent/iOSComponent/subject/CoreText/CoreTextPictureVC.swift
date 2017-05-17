//
//  CoreTextPictureVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/11.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class CoreTextPicture: BaseViewController {
    
    lazy var subview: CoreTextPicView = {
        let tmpSubView = CoreTextPicView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        tmpSubView.backgroundColor = UIColor.white
        return tmpSubView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Core text 图片"
        self.view.addSubview(self.subview)
        self.subview.center = self.view.center
        self.subview.layer.setNeedsDisplay()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}


class CoreTextPicView: UIView {
    override class var layerClass : AnyClass{
        return CoreTextPicLayer.self
    }
}


class CoreTextPicLayer: CALayer {
    var pic:UIImage?
    override init() {
        super.init()
        self.drawsAsynchronously = true
        
        let time = DispatchTime.now() + Double(3 * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
        //模拟网络图片
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.pic = UIImage(named: "page2.jpg")
            self.setNeedsDisplay()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func display() {
        self.contentsScale = UIScreen.main.scale
        super.display()
    }
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        //坐标系转换
        ctx.textMatrix = CGAffineTransform.identity
        ctx.translateBy(x: 0, y: self.bounds.size.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        
        //创建绘制的区域
        let path = CGMutablePath()
        CGPathAddRect(path, nil, self.bounds)
        
        // 4.创建需要绘制的文字
        let attributed =  NSMutableAttributedString(string: "估后共和国开不开vbdkaph估后共和国开不开vbdkaph😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️这是我的第一个coreText demo，我是要给兵来自老白干I型那个饿哦个呢给个I类回滚igkhpwfh 评估后共和国开不开vbdkaphphohghg 的分工额好几个辽宁省更怕hi维护你不看hi好人佛【井柏然把饿哦个😢😊😊😢⬇️");
        
        attributed.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(0, 5));
        
        attributed.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(3, 10));
        
        attributed.addAttribute(NSForegroundColorAttributeName, value: UIColor.orange, range: NSMakeRange(0, 2));
        
        //创建段落属性
        let paraStyle = NSMutableParagraphStyle()
        
        paraStyle.minimumLineHeight = 30
        
        attributed.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSMakeRange(0, attributed.length))
        
        
        //添加图片的逻辑 start
        let drawImageName = "page1.jpg"
       
        var runCallBack = CTRunDelegateCallbacks(version: kCTRunDelegateVersion1, dealloc: { (r) in
            print("ctRunDelegate is die")
            }, getAscent: { (r) -> CGFloat in
                return 100
            }, getDescent: { (r) -> CGFloat in
                return 0
            }) { (width) -> CGFloat in
                return 50
        }
        
    
        var runDelegateFlag = "runDelegateDlag"
        let ctRunDelegate =  CTRunDelegateCreate(&runCallBack, &runDelegateFlag)
        
        let picAttribute  = NSMutableAttributedString(string: " ")
        
        picAttribute.addAttribute((kCTRunDelegateAttributeName as String), value: ctRunDelegate!, range: NSMakeRange(0, 1))
        picAttribute.addAttribute("imageName", value: drawImageName, range: NSMakeRange(0, 1))
        
        attributed.insert(picAttribute, at: 60)
        //添加图片的逻辑end
        
       let ctFrameSetter = CTFramesetterCreateWithAttributedString(attributed)
        
        let ctFrame = CTFramesetterCreateFrame(ctFrameSetter, CFRangeMake(0, attributed.length), path, nil)
        
        CTFrameDraw(ctFrame, ctx)
        
        let lines = CTFrameGetLines(ctFrame) as NSArray
        var originsArray = Array<CGPoint>(repeating: CGPoint.zero, count: lines.count)//用于存储每一行的坐标
        
        CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), &originsArray)
    
        
        for line in lines {
            var lineAscent:CGFloat      = 0
            var lineDescent:CGFloat     = 0
            var lineLeading:CGFloat     = 0
            CTLineGetTypographicBounds(line as! CTLine, &lineAscent, &lineDescent, &lineLeading)
            
            
           let runs = CTLineGetGlyphRuns(line as! CTLine) as NSArray
            
            for (index,run) in runs.enumerated() {
                var runAscent:CGFloat      = 0
                var runDescent:CGFloat     = 0
                var runLeading:CGFloat     = 0
                let lineOrigin             = originsArray[index]
                
               let width =  CTRunGetTypographicBounds(run as! CTRun, CFRangeMake(0, 0), &runAscent, &runDescent, &runLeading)
                /*
                 下面这个计算runRect的记住就行
                 */
                let runX = lineOrigin.x + CTLineGetOffsetForStringIndex(line as! CTLine, CTRunGetStringRange(run as! CTRun).location, nil)
                let runY = lineOrigin.y - runDescent
                let runRect = CGRect(x: runX, y: runY, width: CGFloat(width), height: runDescent+runAscent)
                
                let runAttributes = CTRunGetAttributes(run as! CTRun) as NSDictionary
                
                let imagename = runAttributes.object(forKey: "imageName")
                
                if let imageN = imagename {
                    let image:UIImage?
                    if let p = self.pic{
                        image = p
                    }else{
                        image = UIImage(named: imageN as! String)
                    }
                    let imagebouns = CGRect(x: runRect.origin.x, y: runRect.origin.y, width: runRect.size.width, height: runRect.size.height)
                    ctx.draw((image?.cgImage)!, in: imagebouns)
                    
                    let p = CGMutablePath()
                    CGPathAddRect(p, nil, imagebouns)
                    
                  let pp =  NSMutableAttributedString(string: "wolail")
                    
                   let tp = CTFramesetterCreateWithAttributedString(pp)
                    
                   let ctframe =  CTFramesetterCreateFrame(tp, CFRangeMake(0, pp.length), p, nil)
                    
                    CTFrameDraw(ctframe, ctx)
                    
                }
                
                
            }
        }
    }
}
