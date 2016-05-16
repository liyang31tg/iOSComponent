//
//  MapListViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/5/16.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class MapListViewController: BaseGroupTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = [[CTDomain(sectionTitle: "百度地图"),CTDomain(title: "传递链与响应链", storyBoard: "subject", storyBoardId: "responderChainStoryboardId")]]
    }

    
}
