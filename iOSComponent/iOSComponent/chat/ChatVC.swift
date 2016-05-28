//
//  ChatVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/28.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class ChatVC: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChatVC.touchAction)))
    }
    
    func touchAction(){
    
        print("tochAA")
        
        Transaction(target: self, selector: #selector(ChatVC.todo)).commit()
    }
    
    func todo(){
    
        print("todo")
    }
    
    
    
}
