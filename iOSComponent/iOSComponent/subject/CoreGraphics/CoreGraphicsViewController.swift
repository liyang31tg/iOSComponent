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
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
       let ctx=UIGraphicsGetCurrentContext();
        ctx?.beginPath();
        ctx?.addEllipse(in: CGRect(x: 100, y: 100, width: 200, height: 100))
        ctx?.clip();//裁减，相对的CGContextClearRect是留下矩形外面的
        ctx?.beginPath();
        ctx?.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height));
        ctx?.setFillColor(UIColor.brown.cgColor)
        ctx?.fillPath();
    }
}
