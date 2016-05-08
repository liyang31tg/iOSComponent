//
//  CoreGraphicsViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/5/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class CoreGraphicsViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Core Graphics 初探"
    }
    
    override func loadView() {
        
        self.view = CoreGraphicsView()
    }
}


class CoreGraphicsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
       let ctx=UIGraphicsGetCurrentContext();
        CGContextBeginPath(ctx);
        CGContextAddEllipseInRect(ctx, CGRect(x: 100, y: 100, width: 200, height: 100))
        CGContextClip(ctx);//裁减，相对的CGContextClearRect是留下矩形外面的
        CGContextBeginPath(ctx);
        CGContextAddRect(ctx, CGRectMake(0, 0, rect.size.width, rect.size.height));
        CGContextSetFillColorWithColor(ctx, UIColor.brownColor().CGColor)
        CGContextFillPath(ctx);
    }
}
