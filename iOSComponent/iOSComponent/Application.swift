//
//  Application.swift
//  iOSComponent
//
//  Created by liyang on 16/5/17.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class Application: NSObject {
    private static var __once: () = {
            Static.s = Application()
        }()
    class var shareInstance:Application{
        struct Static{
            static var once:Int = 0
            static var s:Application!
        }
        _ = Application.__once
        
        return Static.s
    }
    lazy var config = Config()
}
