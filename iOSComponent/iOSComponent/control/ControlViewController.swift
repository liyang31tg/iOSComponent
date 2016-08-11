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
        self.contentTableView.refreshType = RefreshType.PullBoth
        dataArray = [[  CTDomain(sectionTitle: "UILabel"),
                        CTDomain(title: "SUNKit", storyBoard: "control", storyBoardId: "uiLabelExtenssionIdentifer")],
                     [  CTDomain(sectionTitle: "UIScrollView"),
                        CTDomain(title: "上啦下啦－UIScrollView", storyBoard: "control", storyBoardId: "LYRefreshIdentifier")],
                     [  CTDomain(sectionTitle: "UITableView"),
                        CTDomain(title: "优化－ UITableView", storyBoard: "control", storyBoardId: "optimizeTableViewVCStoryBoardId")],
                     [  CTDomain(sectionTitle: "UISearchController"),
                        CTDomain(title: "iOS8以后－ UISearchController", storyBoard: "control", storyBoardId: "UseUISearchControllerStoryboardId")],
                     [  CTDomain(sectionTitle: "UIActivityViewController"),
                        CTDomain(title: "iOS8以后－ UIActivityViewController", storyBoard: "control", storyBoardId: "SunActivityVCStoryboardId")]]
        

        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(self.contentTableView.contentInset)
    }
}
