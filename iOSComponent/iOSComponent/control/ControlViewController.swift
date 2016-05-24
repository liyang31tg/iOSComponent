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
    
    @IBOutlet weak var contentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = [[  CTDomain(sectionTitle: "UILabel"),
                        CTDomain(title: "SUNKit", storyBoard: "control", storyBoardId: "uiLabelExtenssionIdentifer")],
                     [  CTDomain(sectionTitle: "UIScrollView"),
                        CTDomain(title: "上啦下啦－UIScrollView", storyBoard: "control", storyBoardId: "LYRefreshIdentifier")],
                     [  CTDomain(sectionTitle: "UITableView"),
                        CTDomain(title: "优化－ UITableView", storyBoard: "control", storyBoardId: "optimizeTableViewVCStoryBoardId")]]
        
//
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print("asfs:\(self.contentTableView.contentInset)")
        
    }
}
