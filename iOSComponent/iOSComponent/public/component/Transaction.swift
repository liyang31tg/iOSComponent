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
    static var onceTocken:dispatch_once_t                   = 0
    static var observer:CFRunLoopObserver?
    static let runloop                                      = CFRunLoopGetMain()
    static let dispath_one_thread                           = dispatch_semaphore_create(1)
    static func setUp(){
        dispatch_semaphore_wait(dispath_one_thread, DISPATCH_TIME_FOREVER)
            if self.observer == nil{
                self.observer =  CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault,CFRunLoopActivity.BeforeWaiting.rawValue | CFRunLoopActivity.Exit.rawValue , true, 0xFFFFFF) { (b:CFRunLoopObserver!, a:CFRunLoopActivity) in
                    let tmpActionSet    = self.transactionset
                    self.transactionset = []
                    for action in tmpActionSet{
                        action.target.performSelector(action.selector)
                    }
                    CFRunLoopRemoveObserver(self.runloop, self.observer, kCFRunLoopCommonModes)
                    self.observer    = nil
                    
                }
                CFRunLoopAddObserver(self.runloop, self.observer, kCFRunLoopCommonModes)
            }
        dispatch_semaphore_signal(dispath_one_thread)
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


