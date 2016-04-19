//
//  SubjectViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/4/15.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class SubjectViewController: BaseGroupTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = [[CTDomain(sectionTitle: "事件"),CTDomain(title: "传递链与响应链", storyBoard: "subject", storyBoardId: "responderChainStoryboardId")]]
        
        
//        let timer = NSTimer(timeInterval: 3, target: self, selector: Selector("doAction"), userInfo: nil, repeats: true)
//        
//        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
//        
//        let timer1 = NSTimer(timeInterval: 2, target: self, selector: Selector("doAction1"), userInfo: nil, repeats: true)
//        
//        NSRunLoop.currentRunLoop().addTimer(timer1, forMode: UITrackingRunLoopMode)
        
        
        
    }
    
    func doAction(){
        print("doAction-=============A")
    }
    
    func doAction1(){
        print("doAction1=============B")
    }
}