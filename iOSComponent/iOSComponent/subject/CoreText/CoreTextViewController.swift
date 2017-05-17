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
        tmpSubView.backgroundColor = UIColor.white
        return tmpSubView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.subview)
        self.subview.center = self.view.center
        
        //
        // 4.创建需要绘制的文字
        let attributed =  NSMutableAttributedString(string: "估后共和国开不开vbdkaph估后共和国开不开vbdkaph😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️这是我的第一个coreText demo，我是要给兵来自老白干I型那个饿哦个呢给个I类回滚igkhpwfh 评估后共和国开不开vbdkaphphohghg 的分工额好几个辽宁省更怕hi维护你不看hi好人佛【井柏然把饿哦个😢😊😊😢⬇️");
        
        attributed.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(0, 5));
        
        attributed.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(3, 10));
        
        attributed.addAttribute(NSForegroundColorAttributeName, value: UIColor.orange, range: NSMakeRange(0, 2));
        
        //创建段落属性
        let paraStyle = NSMutableParagraphStyle()
        
        attributed.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSMakeRange(0, attributed.length))
        ///
        self.subview.contentAttribute = attributed
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


class CoreTextView: UIView {
    var contentAttribute:NSAttributedString = NSAttributedString(string: ""){
        didSet{
            (self.layer as! CoreTextLayer).contentAttribute = self.contentAttribute
        }
    }
    override class var layerClass : AnyClass{
        return CoreTextLayer.self
    }
}


class CoreTextLayer: CALayer {
    var contentAttribute:NSAttributedString = NSAttributedString(string: "")
    override init() {
        super.init()
        self.drawsAsynchronously = true
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
        
       
        
        //创建CTFramesetter
       let ctFrameSetter = CTFramesetterCreateWithAttributedString(self.contentAttribute)
        
        //创建CTFrame
       let ctFrame = CTFramesetterCreateFrame(ctFrameSetter, CFRangeMake(0, self.contentAttribute.length),path , nil)
        
        //根据CTFrame绘制
        CTFrameDraw(ctFrame, ctx)
    }
}
