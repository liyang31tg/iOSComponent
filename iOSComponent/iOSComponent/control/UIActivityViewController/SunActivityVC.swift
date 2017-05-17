//
//  SunActivityVC.swift
//  iOSComponent
//
//  Created by liyang on 16/8/4.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class SunActivityVC: BaseViewController {
    
    
    @IBAction func shareAction(_ sender: UIButton) {
        let items = [UIImage(named:"page4")!,UIImage(named: "page3")!]
        
        
        let ac = [WeChatActivity()]
      let activity =  UIActivityViewController(activityItems: items, applicationActivities: ac)
        
     
        
        activity.excludedActivityTypes = [UIActivityType.mail,UIActivityType.postToWeibo,UIActivityType.airDrop,UIActivityType.airDrop,UIActivityType.print,UIActivityType.copyToPasteboard,UIActivityType.assignToContact,UIActivityType.saveToCameraRoll]
        
        
        self.present(activity, animated: true, completion: nil)
    }
    
    
}

class WeChatActivity: UIActivity {
    override var activityType : String? {
        return "com.fox.shareWechat"
    }
    
    override var activityTitle : String? {
        return "微信"
    }
    
    override var activityImage : UIImage? {
        
        return UIImage(named: "3_5_2_3_weixin")
    }
    
    override class var activityCategory : UIActivityCategory{
    
        return .action
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    

    
    override func perform() {
        
        print("performActivity")
        self.activityDidFinish(true)
        
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        print(activityItems)
    }
    
    
    
}
