//
//  AppDelegate.swift
//  iOSComponent
//
//  Created by liyang on 16/4/15.
//  Copyright © 2016年 liyang. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,BMKGeneralDelegate{
    

    var window: UIWindow?
    var mapManager: BMKMapManager?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let FPSLabel = SunFPSLabel(frame: CGRect(x: 0, y: 64, width: 100, height: 44))
        self.window!.addSubview(FPSLabel)
        self.window?.backgroundColor = UIColor.whiteColor()

//        SqliteDB(dbName: "boqiao", dbType: SqliteDB.DBProperty.type_public)
        
        // 要使用百度地图，请先启动BaiduMapManager
        mapManager = BMKMapManager()
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        let ret = mapManager?.start(Application.shareInstance.config.baiduMapKey, generalDelegate: self)
        if ret == false {
            NSLog("manager start failed!")
        }
        
//        let observe = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.BeforeWaiting.rawValue | CFRunLoopActivity.Exit.rawValue , true, 0) { (o: CFRunLoopObserver!, a:CFRunLoopActivity) -> Void in
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
//        
//        // 2.添加监听
//        CFRunLoopAddObserver(CFRunLoopGetMain(), observe, kCFRunLoopDefaultMode);
        

        return true
    }
    
    

    
    
    //MARK: - BMKGeneralDelegate
    func onGetNetworkState(iError: Int32) {
        if (0 == iError) {
            NSLog("联网成功");
        }
        else{
            NSLog("联网失败，错误代码：Error\(iError)");
        }
    }
    
    func onGetPermissionState(iError: Int32) {
        if (0 == iError) {
            NSLog("授权成功");
        }
        else{
            NSLog("授权失败，错误代码：Error\(iError)");
        }
    }


}

