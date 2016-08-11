//
//  SunActivityVC.swift
//  iOSComponent
//
//  Created by liyang on 16/8/4.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class SunActivityVC: BaseViewController {
    
    
    @IBAction func shareAction(sender: UIButton) {
        let items = [UIImage(named:"page4")!,UIImage(named: "page3")!]
        
        
        let ac = [WeChatActivity()]
      let activity =  UIActivityViewController(activityItems: items, applicationActivities: ac)
        
     
        
        activity.excludedActivityTypes = [UIActivityTypeMail,UIActivityTypePostToWeibo,UIActivityTypeAirDrop,UIActivityTypeAirDrop,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll]
        
        
        self.presentViewController(activity, animated: true, completion: nil)
    }
    
    
}

class WeChatActivity: UIActivity {
    override func activityType() -> String? {
        return "com.fox.shareWechat"
    }
    
    override func activityTitle() -> String? {
        return "微信"
    }
    
    override func activityImage() -> UIImage? {
        
        return UIImage(named: "3_5_2_3_weixin")
    }
    
    override class func activityCategory() -> UIActivityCategory{
    
        return .Action
    }
    
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        return true
    }
    

    
    override func performActivity() {
        
        print("performActivity")
        self.activityDidFinish(true)
        
    }
    
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        print(activityItems)
    }
    
    
    
}
