//
//  CoreTextCTLineDraw.swift
//  iOSComponent
//
//  Created by liyang on 16/5/12.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class CoreTextCTLineDraw: BaseViewController {
    
    lazy var subview: CoreTextCTLineView = {
        let tmpSubView = CoreTextCTLineView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        tmpSubView.backgroundColor = UIColor.white
        return tmpSubView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Core text CTLineDraw"
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


class CoreTextCTLineView: UIView {
    override class var layerClass : AnyClass{
        return CoreTextCTLineLayer.self
    }
}


class CoreTextCTLineLayer: CALayer {
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
    
    /*
     根据属性字符串计算绘制所需要的高度
     思路就是 lineAscent＋lineDescent ＋lineLeading代表一行的高度，分别对每一行进行高度累加
     */
    func getDisplayHeight(_ attributeStr: NSAttributedString,width:CGFloat) -> CGFloat{
    
     let ctFrameSetter = CTFramesetterCreateWithAttributedString(attributeStr)
        
     //建议的宽高
     let suggestSize   =  CTFramesetterSuggestFrameSizeWithConstraints(ctFrameSetter, CFRangeMake(0, attributeStr.length), nil, CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), nil)
        
    let path =  CGMutablePath()
        
    CGPathAddRect(path, nil, CGRect(x: 0, y: 0, width: width, height: suggestSize.height*2))//2是假的，只是防止画布不够大，计算有误，下面才开始精确计算高度
        
        
        
     let ctFrame = CTFramesetterCreateFrame(ctFrameSetter, CFRangeMake(0, 0), path, nil)
        
      let lines =  CTFrameGetLines(ctFrame) as Array
        
      var lineOrigins = Array<CGPoint>(repeating: CGPoint.zero, count: lines.count)//获取每一个行的坐标
        
      CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), &lineOrigins)
        var lineAscent:CGFloat      = 0
        var lineDescent:CGFloat     = 0
        var lineLeading:CGFloat     = 0
        var lineTotalHeight:CGFloat = 0
        
        for (_,line) in lines.enumerated() {
            CTLineGetTypographicBounds(line as! CTLine, &lineAscent, &lineDescent, &lineLeading)
            let oneLineHeight = lineAscent+lineDescent + lineLeading//这里可以接上细节微调，来返回高度
            lineTotalHeight += oneLineHeight
        }
        //高度就这么计算好了
        return lineTotalHeight
    
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
        attributed.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSMakeRange(0, attributed.length))
        
        //根据计算的高度画一个比边框 start
        let strockeHegith = self.getDisplayHeight(attributed, width: ScreenWidth)
        
        ctx.saveGState()
        
        ctx.textMatrix = CGAffineTransform.identity
        ctx.translateBy(x: 0, y: self.bounds.size.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        
        let strokePath = CGMutablePath()
        
        CGPathAddRect(strokePath, nil, CGRect(x: 1, y: 1, width: ScreenWidth-2, height: strockeHegith))
        
        ctx.addPath(strokePath)
        
        ctx.setStrokeColor(UIColor.purple.cgColor)
        
        ctx.strokePath()
        
        ctx.restoreGState()
        //根据计算的高度画一个比边框 end
        
        let ctFrameSetter = CTFramesetterCreateWithAttributedString(attributed)
        
        let ctFrame = CTFramesetterCreateFrame(ctFrameSetter, CFRangeMake(0, attributed.length), path, nil)
        
        
        let lines = CTFrameGetLines(ctFrame) as NSArray
        var originsArray = Array<CGPoint>(repeating: CGPoint.zero, count: lines.count)//用于存储每一行的坐标
        
        CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), &originsArray)
        
        var frameY:CGFloat              = 0
        let kGlobalLineLeading:CGFloat  = 0
        
        for (i,line) in lines.enumerated() {
            var lineAscent:CGFloat      = 0
            var lineDescent:CGFloat     = 0
            var lineLeading:CGFloat     = 0
            CTLineGetTypographicBounds(line as! CTLine, &lineAscent, &lineDescent, &lineLeading)
            
            let  range =  CTLineGetStringRange(line as! CTLine)
            
            print("rangeLocation:\(range.location),rangelength:\(range.length),attributeLength:\(attributed.length)")

            var   lineOrigin = originsArray[i];

            if (i > 0)
            {
            
                frameY = frameY - kGlobalLineLeading - lineAscent;//减去一个行间距，再减去第二行，字形的上部分 （循环）
                
                lineOrigin.y = frameY;
                
            } else
            {
               
                frameY = lineOrigin.y;
            }
            
            // 调整成所需要的坐标
            CGContextSetTextPosition(ctx, lineOrigin.x, lineOrigin.y);
            
            //处理最后一行，将最后一个字符干掉，并且加上省略号
            let lCharacter = "……"
            if i == lines.count - 1 {
                let lastLineRange           = CTLineGetStringRange(line as! CTLine)
                let lastCharAttribute       =   attributed.attributes(at: attributed.length - 1, effectiveRange: nil)
                let lastAppentAttributeStr  = NSAttributedString(string: lCharacter, attributes: lastCharAttribute)
                let foreAttributeStr        =  attributed.attributedSubstring(from: NSMakeRange(lastLineRange.location, lastLineRange.length - 2)) as! NSMutableAttributedString//这里减去2是因为后面有个结尾的符号，c语言里面的“/n”
                let afterAttributeStr        =  attributed.attributedSubstring(from: NSMakeRange(lastLineRange.location + lastLineRange.length - 1, 1)) as! NSMutableAttributedString
                print("after:\(afterAttributeStr.string)测试")
                foreAttributeStr.append(lastAppentAttributeStr)
                let createLastline = CTLineCreateWithAttributedString(foreAttributeStr)
                CTLineDraw(createLastline, ctx)
            
            }else{
                CTLineDraw(line as! CTLine, ctx)
            }

            frameY = frameY - lineDescent//说明下这里，就是减去字形下面部分
            
        }
    }
}

