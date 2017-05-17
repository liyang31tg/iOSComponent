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
        static let queue    = DispatchQueue(label: "com.jjb.removeObserqueue", attributes: [])
    }
    
    struct NamedObserver {
        let observer :NSObjectProtocol
        let name     :String
    }
    
    var cache: [UInt:[NamedObserver]] = [:]
    
    //MARK:addObserverForName
    class func on(_ target: AnyObject, name: String, queue: OperationQueue?, handler: @escaping ((Notification!) -> Void)) -> NSObjectProtocol {
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: name), object: nil, queue: queue, using: handler)
        let namedObserver = NamedObserver(observer: observer, name: name)
        Static.queue.sync {
            if let namedObservers = Static.instance.cache[id] {
                Static.instance.cache[id] = namedObservers + [namedObserver]
            } else {
                Static.instance.cache[id] = [namedObserver]
            }
        }
        return observer
    }
    
    class func onMainThread(_ target: AnyObject, name: String, handler: @escaping ((Notification!) -> Void)) -> NSObjectProtocol {
        return EventBox.on(target, name: name, queue: OperationQueue.main, handler: handler)
    }
    class func onBackgroundThread(_ target: AnyObject, name: String, handler: @escaping ((Notification!) -> Void)) -> NSObjectProtocol {
        return EventBox.on(target, name: name, queue: OperationQueue(), handler: handler)
    }
    
    //MARK:removeObserver
     class func off(_ target: AnyObject) {
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let center = NotificationCenter.default
        Static.queue.sync {
            if let namedObservers = Static.instance.cache.removeValue(forKey: id) {
                for namedObserver in namedObservers {
                    center.removeObserver(namedObserver.observer)
                }
            }
        }
    }
    
     class func off(_ target: AnyObject, name: String) {
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let center = NotificationCenter.default
        Static.queue.sync {
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
    
    class func post(_ name: String) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: nil)
    }
    
    class func post(_ name: String, object: AnyObject?) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object)
    }
    
    class func post(_ name: String, userInfo: [AnyHashable: Any]?) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: nil, userInfo: userInfo)
    }
    
    class func post(_ name: String, object: AnyObject?, userInfo: [AnyHashable: Any]?) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object, userInfo: userInfo)
    }  
}
