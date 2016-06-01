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
        dataArray = [[CTDomain(sectionTitle: "事件"),CTDomain(title: "传递链与响应链", storyBoard: "subject", storyBoardId: "responderChainStoryboardId")],
        [CTDomain(sectionTitle: "算法"),CTDomain(title: "LRU算法实现", storyBoard: "subject", storyBoardId: "linkedTableImplementsIndentifier")],
        [CTDomain(sectionTitle: "多线程"),CTDomain(title: "GCD的遐想", storyBoard: "subject", storyBoardId: "GCDdayDreamViewControllerStoryboardid")],
        
        [CTDomain(sectionTitle: "性能优化"),CTDomain(title: "cornerRadius正确的姿势", storyBoard: "subject", storyBoardId: "cornerRadiusViewControllerStoryboardid")],
        [CTDomain(sectionTitle: "Core Text"),CTDomain(title: "Core Text初探", storyBoard: "subject", storyBoardId: "CoreTextPlainVCStoryboardId")],
        [CTDomain(sectionTitle: "Core Graphics"),CTDomain(title: "Core Graphics初探", storyBoard: "subject", storyBoardId: "coreGraphicsViewControllerStoryboardid")],
         [CTDomain(sectionTitle: "地图"),CTDomain(title: "百度地图初探", storyBoard: "subject", storyBoardId: "MapListViewControllerIdentifier")],
        [CTDomain(sectionTitle: "photoKitUI"),CTDomain(title: "iOS8以后相册的使用", storyBoard: "subject", storyBoardId: "PhotoKitVCStoryboardId")]]
    }

}