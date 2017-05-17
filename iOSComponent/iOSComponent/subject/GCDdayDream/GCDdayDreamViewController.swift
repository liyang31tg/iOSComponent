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
    let queue = DispatchQueue(label: "com.boqiao919.chuanxing", attributes: [])//串行队列
    let cqueue = DispatchQueue(label: "com.boqiao919.bingxing", attributes: DispatchQueue.Attributes.concurrent)//迸发队列
    var a = 3000
    let tt = DispatchSemaphore(value: 1)
    let queueGroup = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()
        //死锁
      _ =  DispatchTime.now() + Double(Int64(10 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
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

        print("nsrunllog:\(RunLoop.current)")
    }
    
    
    func test1(){
        self.cqueue.async { () -> Void in
            print("启动定时器:\(RunLoop.current)")
         
        }
       
            
        }
    
    func timeAction(){
        print("定时器")
    }
    
    
    @IBAction func doAction(_ sender: AnyObject) {
        
        
          mythread(target: self, selector: #selector(GCDdayDreamViewController.doAction as (GCDdayDreamViewController) -> () -> ()), object: nil).start()
        
    }
    
    func doAction(){
        print("doAction")
        let t =   Timer(timeInterval: 5, target: self, selector: #selector(GCDdayDreamViewController.timeAction), userInfo: nil, repeats: false)
        RunLoop.current.add(t, forMode: RunLoopMode.defaultRunLoopMode)
        RunLoop.current.run()
    }
    
    
    
    
    
}

class mythread:Thread{


    deinit{
        print("mythread is die")
    }
}
