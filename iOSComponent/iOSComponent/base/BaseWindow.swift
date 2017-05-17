//
//  BaseWindow.swift
//  iOSComponent
//
//  Created by liyang on 16/5/30.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class BaseWindow: UIWindow {
    init(){
        super.init(frame: ScreenBounds)
        let rootVC                  = UIViewController()
        rootVC.view.backgroundColor = UIColor.clear
        self.rootViewController     = rootVC
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("\(self) is die")
    }
    
}
