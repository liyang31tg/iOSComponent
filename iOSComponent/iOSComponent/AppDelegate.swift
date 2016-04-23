//
//  AppDelegate.swift
//  iOSComponent
//
//  Created by liyang on 16/4/15.
//  Copyright © 2016年 liyang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let FPSLabel = SunFPSLabel(frame: CGRect(x: 0, y: 64, width: 100, height: 44))
        self.window!.addSubview(FPSLabel)

        return true
    }

}

