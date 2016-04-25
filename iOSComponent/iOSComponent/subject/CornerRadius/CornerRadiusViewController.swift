//
//  CornerRadiusViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/4/24.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class CornerRadiusViewController: BaseViewController {
    
    @IBOutlet weak var contentTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension CornerRadiusViewController:UITableViewDelegate,UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 300
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CornerCellidentifier", forIndexPath: indexPath) as! CornerCell
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}


class CornerCell: UITableViewCell {
    
    @IBOutlet weak var C1: UILabel!
    
    @IBOutlet weak var C2: UILabel!
    
    @IBOutlet weak var C3: UILabel!
    
    @IBOutlet weak var C4: UILabel!
    
    @IBOutlet weak var C5: UILabel!
    
    @IBOutlet weak var testView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        testView.layer.cornerRadius = 8
//        
//        testView.layer.borderColor = UIColor.redColor().CGColor
//        testView.layer.borderWidth = 0.5
//        
//        testView.layer.shadowColor = UIColor.blackColor().CGColor
//        testView.layer.shadowOffset = CGSize(width: 10, height: 10)
//        testView.clipsToBounds = true
//        
//        testView.layer.masksToBounds = true
        
//        C1.layer.cornerRadius = 8
//        C1.layer.masksToBounds = true
        
//        C2.layer.cornerRadius = 8
//        C2.layer.masksToBounds = true
//        
//        C3.layer.cornerRadius = 8
//        C3.clipsToBounds = true
        
        
        testView.layer.cornerRadius = 8

        testView.layer.masksToBounds = true
        
       
        

    }
    
}

class testlabel: UILabel {
    override class func layerClass()-> AnyClass{
        
        return testLayer.self
    }
}


class testView: UIView {
    override class func layerClass()-> AnyClass{
    
    return testLayer.self
    }
}

class testLayer: CALayer {
    
//    override func display() {
//        super.display()
//        print("test display")
//        
//        
//        
//    }
//    
//    override func drawInContext(ctx: CGContext) {
//        super.drawInContext(ctx)
////        let ctx = UIGraphicsGetCurrentContext()
//        
//        CGContextMoveToPoint(ctx, 0, 0)
//        
//        CGContextAddLineToPoint(ctx, 100, 100)
//        
//        CGContextSetStrokeColorWithColor(ctx, UIColor.blueColor().CGColor)
//        
//        CGContextStrokePath(ctx)
//        
//        print("test drawinContext")
//    }
    
}




