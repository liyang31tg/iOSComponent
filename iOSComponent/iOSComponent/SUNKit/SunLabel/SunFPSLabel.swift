//
//  SunFPSLabel.swift
//  iOSComponent
//
//  Created by liyang on 16/4/23.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class SunFPSLabel: UILabel {
    
    var ca: CADisplayLink!
    var offsetTime:CFTimeInterval       = 0
    var count                           = 0
    let rM                              = NSRunLoop.mainRunLoop()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    func setup(){
        self.textColor = UIColor.blackColor()
        ca = CADisplayLink(target: self, selector: #selector(SunFPSLabel.heart(_:)))
        ca.addToRunLoop(rM, forMode: NSRunLoopCommonModes)
    }
    
    deinit{
        ca.invalidate()
        ca.removeFromRunLoop(rM, forMode: NSRunLoopCommonModes)
    }
    
    func heart(calink: CADisplayLink){
        count      += 1
        offsetTime += calink.duration
        guard offsetTime > 1 else{
            return
        }
        let fps     = Double(count) / offsetTime
        offsetTime  = 0
        count       = 0

        let attr                =  NSMutableAttributedString(string: "\(Int(round(fps))) FPS")
        self.attributedText     =  attr
    }
}

