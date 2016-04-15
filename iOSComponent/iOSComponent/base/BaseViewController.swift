//
//  BaseViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/4/15.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.navigationController?.viewControllers.first == self {
            self.navigationItem.leftBarButtonItem = nil
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "fts_search_backicon_ios7"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backAction"))
        }
        
    }
    
    func backAction(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    //MARK 解决假卡死
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if self.navigationController?.viewControllers.first == self {
            self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        }else{
            self.navigationController?.interactivePopGestureRecognizer?.enabled = true
        }
    }
}