//
//  MapViewBaseDemoVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/17.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class MapViewBaseDemoVC: BaseViewController,BMKMapViewDelegate {
    
    @IBOutlet weak var changeSegeMent: UISegmentedControl!
    @IBOutlet weak var mapView: BMKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "基本地图功能"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mapView.viewWillAppear()
        mapView.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.viewWillDisappear()
        mapView.delegate = nil
    }
    
    @IBAction func segementAction(sender: AnyObject) {
        let a = sender as! UISegmentedControl
        switch a.tag {
        case 0:
            switch a.selectedSegmentIndex {
            case 0:
                mapView.mapType = UInt(BMKMapTypeStandard)  //普通地图
            case 1:
                mapView.mapType = UInt(BMKMapTypeSatellite) //卫星地图
            case 2:
                mapView.trafficEnabled  = true              //开启实时交通图
            case 3:
                mapView.trafficEnabled  = false             //关闭实时交通图
                
            default:
                break
            }
        case 1:
            switch a.selectedSegmentIndex {
            case 0:
                mapView.baiduHeatMapEnabled = true          //开启百度热力图
            case 1:
                mapView.baiduHeatMapEnabled = false         //关闭百度热力图
            default:
                break
            }

            
        default:
            break
        }
        
        
    }
    
}
