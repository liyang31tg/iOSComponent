//
//  GCDdayDreamViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/4/19.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class GCDdayDreamViewController: BaseViewController{
    let queue = dispatch_queue_create("com.boqiao919.chuanxing", nil)//串行队列
    let cqueue = dispatch_queue_create("com.boqiao919.bingxing", DISPATCH_QUEUE_CONCURRENT)//迸发队列
    var a = 3000
    let tt = dispatch_semaphore_create(1)
    let queueGroup = dispatch_group_create()
    override func viewDidLoad() {
        super.viewDidLoad()
        //死锁
      let t =  dispatch_time(DISPATCH_TIME_NOW, Int64(10 * NSEC_PER_SEC))
//        dispatch_async(cqueue) { () -> Void in
//            
//           print("current thread:\(NSThread.currentThread())")
//            
//        }
        
//        dispatch_after(t, self.queue, { () -> Void in
//            print("延迟执行:\(NSThread.currentThread())")
//        })
//        for i in 0...100 {
//            dispatch_async(self.queue) { () -> Void in
//                sleep(1)
//                print("\(i)后面执行:\(NSThread.currentThread())")
//            }
//        }
//        
//        print("1永远执行不到")

        print("nsrunllog:\(NSRunLoop.currentRunLoop())")
    }
    
    
    func test1(){
        dispatch_async(self.cqueue) { () -> Void in
            print("启动定时器:\(NSRunLoop.currentRunLoop())")
         
        }
       
            
        }
    
    func timeAction(){
        print("定时器")
    }
    
    
    @IBAction func doAction(sender: AnyObject) {
        
        
          mythread(target: self, selector: Selector("doAction"), object: nil).start()
        
    }
    
    func doAction(){
        print("doAction")
        let t =   NSTimer(timeInterval: 5, target: self, selector: Selector("timeAction"), userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(t, forMode: NSDefaultRunLoopMode)
        NSRunLoop.currentRunLoop().run()
    }
    
    
    
    
    
}

class mythread:NSThread{


    deinit{
        print("mythread is die")
    }
}