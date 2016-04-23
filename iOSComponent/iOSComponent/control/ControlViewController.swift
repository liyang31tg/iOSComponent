//
//  ControlViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/4/22.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class ControlViewController: BaseGroupTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = [[CTDomain(sectionTitle: "UILabel"),CTDomain(title: "SunLabel", storyBoard: "control", storyBoardId: "uiLabelExtenssionIdentifer")]]
    }
}
