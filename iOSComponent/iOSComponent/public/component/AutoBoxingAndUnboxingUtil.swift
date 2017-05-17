//
//  AutoBoxingAndUnboxingUtil.swift
//  iOSComponent
//
//  Created by liyang on 16/5/25.
//  Copyright © 2016年 liyang. All rights reserved.
//  自动拆箱（unboxing）和装箱(boxing) 类似java
//

import Foundation

class Box<T>:NSObject{
    var value: T!
    
}

class AutoBoxingAndUnboxingUtil {
    class func toBoxing<T>(_ v:T) -> Box<T>{
        let b   = Box<T>()
        b.value = v
        return b
    }
    
    class func toUnboxing<T>(_ bv:Box<T>) -> T{
        return bv.value
    }
}
