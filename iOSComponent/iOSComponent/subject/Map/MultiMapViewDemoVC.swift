//
//  MultiMapViewDemoVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/17.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class MultiMapViewDemoVC: BaseViewController,BMKMapViewDelegate,BMKLocationServiceDelegate {
    
    lazy var locationService = BMKLocationService()
    @IBOutlet weak var mapViewB: BMKMapView!
    @IBOutlet weak var mapViewA: BMKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "多地图使用功能"
        mapViewA.mapType            = UInt(BMKMapTypeStandard)  //普通地图
        mapViewA.logoPosition       = BMKLogoPositionLeftTop
        //定位条件
        mapViewA.showsUserLocation  = true
        mapViewA.userTrackingMode   = BMKUserTrackingModeFollow
        mapViewA.zoomLevel          = 12
        //定位条件
        
        mapViewB.mapType        = UInt(BMKMapTypeSatellite) //卫星地图
        mapViewB.logoPosition   = BMKLogoPositionRightBottom
        
        
        //定位服务
        locationService.delegate = self
        locationService.startUserLocationService()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mapViewA.viewWillAppear()
        mapViewA.delegate = self
        mapViewB.viewWillAppear()
        mapViewB.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mapViewA.viewWillDisappear()
        mapViewA.delegate = nil
        mapViewB.viewWillDisappear()
        mapViewB.delegate = nil
    }
    
    //定位代理方法
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
       
        mapViewA.updateLocationData(userLocation)
    }
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        mapViewA.updateLocationData(userLocation)
    }
}