//
//  Transaction.swift
//  iOSComponent
//
//  Created by liyang on 16/5/28.
//  Copyright © 2016年 liyang. All rights reserved.
//  线程安全的随便使用

import Foundation

private struct TransactionSetUp {
    static var transactionset:Set<Transaction>              = []
    static var onceTocken:Int                   = 0
    static var observer:CFRunLoopObserver?
    static let runloop                                      = CFRunLoopGetMain()
    static let dispath_one_thread                           = DispatchSemaphore(value: 1)
    static func setUp(){
        dispath_one_thread.wait(timeout: DispatchTime.distantFuture)
            if self.observer == nil{
                self.observer =  CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault,CFRunLoopActivity.beforeWaiting.rawValue | CFRunLoopActivity.exit.rawValue , true, 0xFFFFFF) { (b:CFRunLoopObserver!, a:CFRunLoopActivity) in
                    let tmpActionSet    = self.transactionset
                    self.transactionset = []
                    for action in tmpActionSet{
                        action.target.perform(action.selector)
                    }
                    CFRunLoopRemoveObserver(self.runloop, self.observer, CFRunLoopMode.commonModes)
                    self.observer    = nil
                    
                }
                CFRunLoopAddObserver(self.runloop, self.observer, CFRunLoopMode.commonModes)
            }
        dispath_one_thread.signal()
    }
}


class Transaction:Hashable {
    var target  :AnyObject!
    var selector:Selector!
    init(target:AnyObject,selector:Selector) {
        self.target     = target
        self.selector   = selector
    }
    func commit(){
        if let _ = target , let _ = selector {
            TransactionSetUp.setUp()
            TransactionSetUp.transactionset.insert(self)
        }
    }
     var hashValue: Int{
        return self.target.hashValue ^ self.selector.hashValue
    }
}
func ==(t1: Transaction, t2: Transaction) -> Bool{
    if t1 === t2 {
        return true
    }
     return t1.selector == t2.selector && t1.target === t2.target
}


