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
        dataArray = [[CTDomain(sectionTitle: "百度地图"),CTDomain(title: "基本地图功能-MapViewBaseDemo", storyBoard: "subject", storyBoardId: "MapViewBaseDemoViewControllerStoryboardId")
            ,CTDomain(title: "多地图使用功能-MultiMapViewDemo", storyBoard: "subject", storyBoardId: "MultiMapViewDemoVCStoryboardId"),
            CTDomain(title: "覆盖物功能-AnnotationDemoVC", storyBoard: "subject", storyBoardId: "AnnotationDemoVCStoryboardId"),
            CTDomain(title: "POI搜索-AnnotationDemoVC", storyBoard: "subject", storyBoardId: "PoiSearchDemoVCStoryboardId")]]
    }
    
}
