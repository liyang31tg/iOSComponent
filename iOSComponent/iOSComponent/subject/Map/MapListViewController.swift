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
        self.title = "百度地图"
        dataArray = [[
            CTDomain(sectionTitle: "百度地图"),CTDomain(title: "基本地图功能-MapViewBaseDemo", storyBoard: "subject", storyBoardId: "MapViewBaseDemoViewControllerStoryboardId"),
            CTDomain(title: "多地图使用功能-MultiMapViewDemo", storyBoard: "subject", storyBoardId: "MultiMapViewDemoVCStoryboardId"),
            CTDomain(title: "覆盖物功能-AnnotationDemoVC", storyBoard: "subject", storyBoardId: "AnnotationDemoVCStoryboardId"),
            CTDomain(title: "POI搜索-PoiSearchDemoVC", storyBoard: "subject", storyBoardId: "PoiSearchDemoVCStoryboardId"),
            CTDomain(title: "地理编码功能-GeocodeDemoVC", storyBoard: "subject", storyBoardId: "GeocodeDemoVCStoryboardId"),
            CTDomain(title: "路径规划-RouteSearchDemoVC", storyBoard: "subject", storyBoardId: "RouteSearchDemoVCStoryboard"),
            CTDomain(title: "公交路线查询-RouteSearchDemoVC", storyBoard: "subject", storyBoardId: "BusLineSearchVCStoryBoardiD"),
            CTDomain(title: "行政区域检索-DistrictSearchDemoVC", storyBoard: "subject", storyBoardId: "DistrictSearchDemoVCStoryBoardiD"),
            CTDomain(title: "在线建议查询-SuggestionSearchDemoVC", storyBoard: "subject", storyBoardId: "SuggestionSearchDemoVCStoryBoardiD")
            ]]
    }
}
