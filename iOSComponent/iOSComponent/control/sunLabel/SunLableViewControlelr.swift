//
//  SunLableViewControlelr.swift
//  iOSComponent
//
//  Created by liyang on 16/4/22.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class SunlableViewController: BaseViewController {
     let sunLabel = SunLabel(frame: CGRect(x: 0, y: 100, width: 375, height: 300))
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        
//        //沙盒路径（也就是我们应用程序文件运行的路径）
//        let paths = NSHomeDirectory()
//        
//        let path = (paths as NSString).stringByAppendingPathComponent("test.pdf")
//        NSFileManager.defaultManager().createFileAtPath(path, contents: nil, attributes: nil)
//        
//        //启用pdf图形上下文
//        /**
//         path:保存路径
//         bounds:pdf文档大小，如果设置为CGRectZero则使用默认值：612*792
//         pageInfo:页面设置,为nil则不设置任何信息
//         */
//        UIGraphicsBeginPDFContextToFile(path, CGRectZero, nil)
//        //        [kCGPDFContextAuthor:"ZUBER"]
//        //由于pdf文档是分页的，所以首先要创建一页画布供我们绘制
//        UIGraphicsBeginPDFPage()
//        
//        let title = "开心的学习 CoreGraphics 开心的学习Swift"
//        let style = NSMutableParagraphStyle()
//        style.alignment = NSTextAlignment.Center
//        (title as NSString).drawInRect(CGRectMake(26, 20, 300, 50) , withAttributes: [NSFontAttributeName:UIFont.boldSystemFontOfSize(18),NSParagraphStyleAttributeName:style])
//        
//        let content = "Learn about Apple products, view online manuals, get the latest downloads, and more. Connect with other Apple users, or get service, support, and professional advice from Apple."
//        let style2 = NSMutableParagraphStyle()
//        style2.alignment = NSTextAlignment.Left
//        (content as NSString).drawInRect(CGRectMake(26, 56, 300, 255) , withAttributes: [NSFontAttributeName:UIFont.systemFontOfSize(15),NSParagraphStyleAttributeName:style2,NSForegroundColorAttributeName:UIColor.grayColor()])
//        
//        let img = UIImage(named: "page1.jpg")
//        img?.drawInRect(CGRectMake(316, 20, 290, 305))
//        
//        let img2 = UIImage(named: "page2.jpg")
//        img2?.drawInRect(CGRectMake(6, 320, 600, 281))
//        
//        //创建新的一页继续绘制
//        UIGraphicsBeginPDFPage()
//        let img3 = UIImage(named: "page3.jpg")
//        img3?.drawInRect(CGRectMake(6, 20, 600, 629))
//        
//        //结束pdf上下文
//        UIGraphicsEndPDFContext()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        
//        sunLabel.translatesAutoresizingMaskIntoConstraints = false
//        sunLabel.backgroundColor = UIColor.redColor()
//        self.view.addSubview(sunLabel)
//        
//        
//        
//        
//        let top = NSLayoutConstraint(item: sunLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 64)
//        
//        let leading = NSLayoutConstraint(item: sunLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
//        
//        let training = NSLayoutConstraint(item: sunLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
//        
//        let height = NSLayoutConstraint(item: sunLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 400)
//        
//        self.view.addConstraints([top,leading,training,height])
    }
    
    @IBAction func tapAction(sender: AnyObject) {
        sunLabel.layer.setNeedsDisplay()
    }
}
