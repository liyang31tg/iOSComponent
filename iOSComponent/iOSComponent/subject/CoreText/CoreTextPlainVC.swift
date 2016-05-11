//
//  CoreTextPlainVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/11.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class CoreTextPlainVC: BasePlainTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Core Text Detail"
        dataArray = [CTDomain(title: "Core Text 初试", performIdentifier: "coreTextForeViewController")]
    }
    
}
