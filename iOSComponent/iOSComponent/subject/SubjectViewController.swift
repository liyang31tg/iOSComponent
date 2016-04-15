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
    }
}