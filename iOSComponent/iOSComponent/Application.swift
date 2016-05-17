//
//  Application.swift
//  iOSComponent
//
//  Created by liyang on 16/5/17.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class Application: NSObject {
    class var shareInstance:Application{
        struct Static{
            static var once:dispatch_once_t = 0
            static var s:Application!
        }
        dispatch_once(&Static.once) {
            Static.s = Application()
        }
        
        return Static.s
    }
    lazy var config = Config()
}
