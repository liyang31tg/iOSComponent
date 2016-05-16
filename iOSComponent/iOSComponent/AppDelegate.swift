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
        self.window?.backgroundColor = UIColor.whiteColor()
        
        
        let a:Float     = 0.01
        let b:Int       = 99999999
        var c:Double    = 0.0
        
        c = Double(a)*Double(b);
        print(Float(a))
        print(Float(b))
        print(String(format: "%f,,,,,%.2f", c,c))
        
//        let observe = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.AllActivities.rawValue, true, 0) { (o: CFRunLoopObserver!, a:CFRunLoopActivity) -> Void in
//            switch a {
//            case CFRunLoopActivity.Entry:
//                print("RunLoop Entry")
//            case CFRunLoopActivity.BeforeTimers:
//                print("RunLoop BeforeTimers")
//            case CFRunLoopActivity.BeforeSources:
//                print("RunLoop BeforeSources")
//            case CFRunLoopActivity.BeforeWaiting:
//                print("RunLoop BeforeWaiting")
//            case CFRunLoopActivity.AfterWaiting:
//                print("RunLoop 等待后")
//            case CFRunLoopActivity.Exit:
//                print("RunLoop 退出")//切换model的时候会退出，再进入
//            default:
//                print("---------------------:\(a)")
//                break;
//            }
//        }
//        // 2.添加监听
//        CFRunLoopAddObserver(CFRunLoopGetMain(), observe, kCFRunLoopDefaultMode);
        
        return true
    }

}

