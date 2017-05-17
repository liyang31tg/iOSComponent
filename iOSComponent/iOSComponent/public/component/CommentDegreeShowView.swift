//
//  CommentDegreeShowView.swift
//  iOSComponent
//
//  Created by liyang on 16/5/24.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class CommentDegreeShowView: UIView {
    var degree      = 0{
        didSet{
            self.layer.contents = UIImage(named: "EvaluationStar\(self.degree)")?.cgImage
        }
    }
    var allCount    = 5//更新这个，记得更新subFrames
    var tap:UITapGestureRecognizer!
    lazy fileprivate var subFrames: [CGRect] = {
        var tmpArray:[CGRect] = []
        let tmpWidth = self.frame.size.width / 5
        let tmpHeight = self.frame.size.height
        for i in 0..<5{
            let tmpRect = CGRect(x: tmpWidth * CGFloat(i), y: 0, width: tmpWidth, height: tmpHeight)
            tmpArray.append(tmpRect)
        }
        return tmpArray
    }()
    
    override func awakeFromNib() {
        tap = UITapGestureRecognizer(target: self, action: #selector(CommentDegreeShowView.caculateInRect(_:)))
        self.addGestureRecognizer(tap)
        
    }
    
    func caculateInRect(_ currenttap:UITapGestureRecognizer){
       let touchPoint =   currenttap.location(in: self)
        for (index,rect) in subFrames.enumerated(){
            if rect.contains(touchPoint) {
               degree = index + 1
                break;
            }
        }
    }
    
    
}
