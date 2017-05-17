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
    var count                           = 0
    let rM                              = RunLoop.main
    
    var lastTime:CFTimeInterval         = 0
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
        self.textColor = UIColor.black
        ca = CADisplayLink(target: self, selector: #selector(SunFPSLabel.heart(_:)))
        ca.add(to: rM, forMode: RunLoopMode.commonModes)
    }
    
    deinit{
        ca.invalidate()
        ca.remove(from: rM, forMode: RunLoopMode.commonModes)
    }
    
    func heart(_ calink: CADisplayLink){
        guard (lastTime != 0) else {
            lastTime = calink.timestamp
            return
        }

        count      += 1
        let  offsetTime = calink.timestamp - lastTime;
        guard offsetTime > 1 else{
            return
        }
        let fps     = Double(count) / offsetTime
        lastTime    = calink.timestamp
        count       = 0

        let attr                =  NSMutableAttributedString(string: "\(Int(round(fps))) FPS")
        self.attributedText     =  attr
    }
}

