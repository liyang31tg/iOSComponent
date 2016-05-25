//
//  EventBox.swift
//  iOSComponent
//
//  Created by liyang on 16/5/25.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation

class EventBox {
    
    struct Static {
        static let instance = EventBox()
        static let queue    = dispatch_queue_create("com.jjb.removeObserqueue", DISPATCH_QUEUE_SERIAL)
    }
    
    struct NamedObserver {
        let observer :NSObjectProtocol
        let name     :String
    }
    
    var cache: [UInt:[NamedObserver]] = [:]
    
    //MARK:addObserverForName
    class func on(target: AnyObject, name: String, queue: NSOperationQueue?, handler: ((NSNotification!) -> Void)) -> NSObjectProtocol {
        let id = ObjectIdentifier(target).uintValue
        let observer = NSNotificationCenter.defaultCenter().addObserverForName(name, object: nil, queue: queue, usingBlock: handler)
        let namedObserver = NamedObserver(observer: observer, name: name)
        dispatch_sync(Static.queue) {
            if let namedObservers = Static.instance.cache[id] {
                Static.instance.cache[id] = namedObservers + [namedObserver]
            } else {
                Static.instance.cache[id] = [namedObserver]
            }
        }
        return observer
    }
    
    class func onMainThread(target: AnyObject, name: String, handler: ((NSNotification!) -> Void)) -> NSObjectProtocol {
        return EventBox.on(target, name: name, queue: NSOperationQueue.mainQueue(), handler: handler)
    }
    class func onBackgroundThread(target: AnyObject, name: String, handler: ((NSNotification!) -> Void)) -> NSObjectProtocol {
        return EventBox.on(target, name: name, queue: NSOperationQueue(), handler: handler)
    }
    
    //MARK:removeObserver
     class func off(target: AnyObject) {
        let id = ObjectIdentifier(target).uintValue
        let center = NSNotificationCenter.defaultCenter()
        dispatch_sync(Static.queue) {
            if let namedObservers = Static.instance.cache.removeValueForKey(id) {
                for namedObserver in namedObservers {
                    center.removeObserver(namedObserver.observer)
                }
            }
        }
    }
    
     class func off(target: AnyObject, name: String) {
        let id = ObjectIdentifier(target).uintValue
        let center = NSNotificationCenter.defaultCenter()
        dispatch_sync(Static.queue) {
            if let namedObservers = Static.instance.cache[id] {
                Static.instance.cache[id] = namedObservers.filter({ (namedObserver: NamedObserver) -> Bool in
                    if namedObserver.name == name {
                        center.removeObserver(namedObserver.observer)
                        return false
                    } else {
                        return true
                    }
                })
            }
        }
    }
    
    // MARK:postNotificationName
    
    class func post(name: String) {
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: nil)
    }
    
    class func post(name: String, object: AnyObject?) {
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: object)
    }
    
    class func post(name: String, userInfo: [NSObject : AnyObject]?) {
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: nil, userInfo: userInfo)
    }
    
    class func post(name: String, object: AnyObject?, userInfo: [NSObject : AnyObject]?) {
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: object, userInfo: userInfo)
    }  
}
