//
//  ShareViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/6/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation

class ShareViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func shareAction(_ sender: AnyObject) {
        print("shareAction")
        let shareV = ShareView()
        shareV.presentWithContainerView(self.navigationController?.view)
    }
}
