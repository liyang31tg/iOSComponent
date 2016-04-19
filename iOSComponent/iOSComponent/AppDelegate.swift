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
    
    var db1: COpaquePointer = nil
    let lock = dispatch_semaphore_create(1)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        var account = 3000
       
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            sleep(2)
            self.deleteMoney(&account)
            print("aaaa:\(account)")
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            self.deleteM(&account)
            print("aaaa:\(account)")
        }

        return true
    }
    
    func deleteMoney(inout account:Int){
        dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER)
        if account > 2000{
            let tmp = account
            account = tmp - 2000
        }else{
            print("deleteMoney钱不够偶")
        }
        dispatch_semaphore_signal(lock)
    }
    
    func deleteM(inout account:Int){
        dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER)
        if account > 2000{
            let tmp = account
            account = tmp - 2000
        }else{
            print("deleteM钱不够偶")
        }
        dispatch_semaphore_signal(lock)
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    


}

