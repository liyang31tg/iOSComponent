//
//  RouteSearchDemoVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/18.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class RouteSearchDemoVC: BaseViewController {
    
    @IBOutlet weak var fromCityTextField: UITextField!
    
    @IBOutlet weak var fromAddressTextField: UITextField!
    
    @IBOutlet weak var toCityTextField: UITextField!
    
    @IBOutlet weak var toAddressTextField: UITextField!
    
    let routeSearch = BMKRouteSearch()
    
    @IBOutlet weak var contentMapView: BMKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        contentMapView.viewWillAppear()
        contentMapView.delegate = self
        routeSearch.delegate    = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        contentMapView.viewWillDisappear()
        contentMapView.delegate = nil
        routeSearch.delegate    = nil
    }
    
    @IBAction func segementControl(sender: UISegmentedControl) {
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
        switch sender.selectedSegmentIndex {
            case 0://公交
                self.searchTransitRoute()
            case 1://驾乘
                self.searchDrivingRoute()
            case 2://步行
                searchWalkingRoute()
            case 3://骑行
                searchRiding()
            default:
                break
        }
    }
    //MARK:公交
    func searchTransitRoute(){
        let option      = BMKTransitRoutePlanOption()
        let fromNode    = BMKPlanNode()
        fromNode.name   = self.fromAddressTextField.text
        let toNode      = BMKPlanNode()
        toNode.name     = self.toAddressTextField.text
        option.city = self.fromCityTextField.text
        option.from = fromNode
        option.to   = toNode
        routeSearch.transitSearch(option)
    }
    //MARk:驾车信息
    func searchDrivingRoute(){
        let option          = BMKDrivingRoutePlanOption()
        let fromNode        = BMKPlanNode()
        fromNode.cityName   = self.fromCityTextField.text
        fromNode.name       = self.fromAddressTextField.text
        let toNode          = BMKPlanNode()
        toNode.cityName     = self.toCityTextField.text
        toNode.name         = self.toAddressTextField.text
        
        option.from         = fromNode
        option.to           = toNode
        routeSearch.drivingSearch(option)
    }
    
    //MARK:步行信息
    func searchWalkingRoute(){
        let option          = BMKWalkingRoutePlanOption()
        let fromNode        = BMKPlanNode()
        fromNode.cityName   = self.fromCityTextField.text
        fromNode.name       = self.fromAddressTextField.text
        let toNode          = BMKPlanNode()
        toNode.cityName     = self.toCityTextField.text
        toNode.name         = self.toAddressTextField.text
        option.from         = fromNode
        option.to           = toNode
        routeSearch.walkingSearch(option)
    
    }
    //MARK:查询骑行信息
    func searchRiding(){
        let option          = BMKRidingRoutePlanOption()
        let fromNode        = BMKPlanNode()
        fromNode.cityName   = self.fromCityTextField.text
        fromNode.name       = self.fromAddressTextField.text
        let toNode          = BMKPlanNode()
        toNode.cityName     = self.toCityTextField.text
        toNode.name         = self.toAddressTextField.text
        option.from         = fromNode
        option.to           = toNode
        routeSearch.ridingSearch(option)
    
    }
    
}

extension RouteSearchDemoVC : BMKRouteSearchDelegate{
    //公交路线查找（回调）
    func onGetTransitRouteResult(searcher: BMKRouteSearch!, result: BMKTransitRouteResult!, errorCode error: BMKSearchErrorCode) {
        print("公交路线查找")
        contentMapView.removeAnnotations(contentMapView.annotations)
        contentMapView.removeOverlays(contentMapView.overlays)
        if error == BMK_SEARCH_NO_ERROR {
            let plan  = result.routes[0] as! BMKTransitRouteLine
            let sizes = plan.steps.count
            var tmpPoints: [BMKMapPoint] = []
            for i in 0..<sizes{
                let transiteStep = plan.steps[i] as! BMKTransitStep
                if i == 0 {//起点
                    let item = RouteAnnotation()
                    item.coordinate = plan.starting.location
                    item.title      = "起点"
                    item.type       = RouteAnnotation.RouteType.starting.rawValue
                    contentMapView.addAnnotation(item)
                    contentMapView.setCenterCoordinate(item.coordinate, animated: false)
                } else if i == sizes-1 {//终点
                    let item = RouteAnnotation()
                    item.coordinate = plan.terminal.location
                    item.title      = "终点"
                    item.type       = RouteAnnotation.RouteType.ending.rawValue
                    contentMapView.addAnnotation(item)
                }
                //中间的点
                    let item = RouteAnnotation()
                    item.coordinate = transiteStep.entrace.location
                    item.title      = transiteStep.instruction
                    item.type       = RouteAnnotation.RouteType.bus.rawValue
                    contentMapView.addAnnotation(item)
                    
            
                
                for k in 0..<Int(transiteStep.pointsCount) {
                    var tmpBMKMapPoint = BMKMapPoint()
                    tmpBMKMapPoint.x =  transiteStep.points[k].x
                    tmpBMKMapPoint.y =  transiteStep.points[k].y
                    tmpPoints.append(tmpBMKMapPoint)
                }

            }
            
           let polyline = BMKPolyline(points: &tmpPoints, count: UInt(tmpPoints.count))
            contentMapView.addOverlay(polyline)
        }
    }
    
    //驾乘路线（回调）
    func onGetDrivingRouteResult(searcher: BMKRouteSearch!, result: BMKDrivingRouteResult!, errorCode error: BMKSearchErrorCode) {
        contentMapView.removeOverlays(contentMapView.overlays)
        contentMapView.removeAnnotations(contentMapView.annotations)
        if error == BMK_SEARCH_NO_ERROR {
            let plan = result.routes[0] as! BMKDrivingRouteLine
            let stepsCount = plan.steps.count
            var tmpPoints:[BMKMapPoint]      = []
            for (index,step) in plan.steps.enumerate() {
                let driveStep = step as! BMKDrivingStep
                if index == 0 {//起点
                    let item = RouteAnnotation()
                    item.coordinate = plan.starting.location
                    item.title = "起点"
                    item.type = RouteAnnotation.RouteType.starting.rawValue
                    contentMapView.addAnnotation(item)
                    contentMapView.setCenterCoordinate(item.coordinate, animated: false)
                }else if index == stepsCount - 1{//终点
                    let item = RouteAnnotation()
                    item.coordinate = plan.terminal.location
                    item.title = "终点"
                    item.type = RouteAnnotation.RouteType.ending.rawValue
                    contentMapView.addAnnotation(item)
                }
                
                let item = RouteAnnotation()
                item.coordinate = driveStep.entrace.location
                item.type       = RouteAnnotation.RouteType.driving.rawValue
                item.title      = driveStep.instruction
                contentMapView.addAnnotation(item)
                
                for k in 0..<Int(driveStep.pointsCount) {
                    var point = BMKMapPoint()
                    point.x = driveStep.points[k].x
                    point.y = driveStep.points[k].y
                    tmpPoints.append(point)
                }
                
                //途径点
                if let wayPoints = plan.wayPoints as? [BMKPlanNode] {
                    for wayPoint in wayPoints {
                        let item = RouteAnnotation()
                        item.coordinate = wayPoint.pt
                        item.title      = wayPoint.name
                        item.type       = RouteAnnotation.RouteType.approach.rawValue
                        contentMapView.addAnnotation(item)
                    }
                }
                
            }
            let polyLine = BMKPolyline(points: &tmpPoints, count: UInt(tmpPoints.count))
            contentMapView.addOverlay(polyLine)
        }
    }
    
    //步行（回调）
    func onGetWalkingRouteResult(searcher: BMKRouteSearch!, result: BMKWalkingRouteResult!, errorCode error: BMKSearchErrorCode) {
        print("步行路线查找")
        contentMapView.removeOverlays(contentMapView.overlays)
        contentMapView.removeAnnotations(contentMapView.annotations)
        
        if error == BMK_SEARCH_NO_ERROR {
            let plan = result.routes[0] as! BMKWalkingRouteLine
            let stepCounts = plan.steps.count
            var tmpPoint:[BMKMapPoint] = []
            for (index,step) in plan.steps.enumerate() {
                let warkStep = step as! BMKWalkingStep
                if index == 0{
                    let item = RouteAnnotation()
                    item.coordinate = plan.starting.location
                    item.title      = "起点"
                    item.type       = RouteAnnotation.RouteType.starting.rawValue
                    contentMapView.setCenterCoordinate(item.coordinate, animated: false)
                    contentMapView.addAnnotation(item)
                }else if index == stepCounts - 1 {
                    let item = RouteAnnotation()
                    item.coordinate = plan.terminal.location
                    item.title      = "终点"
                    item.type       = RouteAnnotation.RouteType.ending.rawValue
                    contentMapView.addAnnotation(item)
                }
                
                let item = RouteAnnotation()
                item.coordinate = warkStep.entrace.location
                item.title      = warkStep.instruction
                item.type       = RouteAnnotation.RouteType.driving.rawValue
                contentMapView.addAnnotation(item)
                
                for i in 0..<Int(warkStep.pointsCount){
                    var mapPoint = BMKMapPoint()
                    mapPoint.x  = warkStep.points[i].x
                    mapPoint.y  = warkStep.points[i].y
                    tmpPoint.append(mapPoint)
                }
                
                let poly =  BMKPolyline(points: &tmpPoint, count: UInt(tmpPoint.count))
                contentMapView.addOverlay(poly)
                
                
            }
        
        }
        
        
    }
    
    func onGetRidingRouteResult(searcher: BMKRouteSearch!, result: BMKRidingRouteResult!, errorCode error: BMKSearchErrorCode) {
        
        contentMapView.removeOverlays(contentMapView.overlays)
        contentMapView.removeAnnotations(contentMapView.annotations)
        
        if error == BMK_SEARCH_NO_ERROR {
            let plan = result.routes[0] as! BMKRidingRouteLine
            let stepCounts = plan.steps.count
            var tmpPoint:[BMKMapPoint] = []
            for (index,step) in plan.steps.enumerate() {
                let rideStep = step as! BMKRidingStep
                if index == 0{
                    let item = RouteAnnotation()
                    item.coordinate = plan.starting.location
                    item.title      = "起点"
                    item.type       = RouteAnnotation.RouteType.starting.rawValue
                    contentMapView.setCenterCoordinate(item.coordinate, animated: false)
                    contentMapView.addAnnotation(item)
                }else if index == stepCounts - 1 {
                    let item = RouteAnnotation()
                    item.coordinate = plan.terminal.location
                    item.title      = "终点"
                    item.type       = RouteAnnotation.RouteType.ending.rawValue
                    contentMapView.addAnnotation(item)
                }
                
                let item = RouteAnnotation()
                item.coordinate = rideStep.entrace.location
                item.title      = rideStep.instruction
                item.type       = RouteAnnotation.RouteType.driving.rawValue
                contentMapView.addAnnotation(item)
                
                for i in 0..<Int(rideStep.pointsCount){
                    var mapPoint = BMKMapPoint()
                    mapPoint.x  = rideStep.points[i].x
                    mapPoint.y  = rideStep.points[i].y
                    tmpPoint.append(mapPoint)
                }
                
                let poly =  BMKPolyline(points: &tmpPoint, count: UInt(tmpPoint.count))
                contentMapView.addOverlay(poly)
                
                
            }
            
        }

        
    }
}

extension RouteSearchDemoVC: BMKMapViewDelegate{
    
    
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView! {
        if let  layline = overlay as? BMKPolyline {
           let polylineView = BMKPolylineView(polyline: layline)
            polylineView.strokeColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.7)
            polylineView.lineWidth = 3
            return polylineView
        }
        return nil
    }
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if annotation is RouteAnnotation {
            return getViewForRouteAnnotation(annotation as! RouteAnnotation)
        }
        
        return nil
    }
    
    func getViewForRouteAnnotation(routeAnnotation: RouteAnnotation!) -> BMKAnnotationView? {
        var view: BMKAnnotationView?
        
        var imageName: String?
        switch routeAnnotation.type {
        case 0:
            imageName = "nav_start"
        case 1:
            imageName = "nav_end"
        case 2:
            imageName = "nav_bus"
        case 3:
            imageName = "nav_rail"
        case 4:
            imageName = "direction"
        case 5:
            imageName = "nav_waypoint"
        default:
            return nil
        }
        let identifier = "\(imageName)_annotation"
        view = contentMapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        if view == nil {
            view = BMKAnnotationView(annotation: routeAnnotation, reuseIdentifier: identifier)
            view?.centerOffset = CGPointMake(0, -(view!.frame.size.height * 0.5))
            view?.canShowCallout = true
        }
        view?.annotation = routeAnnotation
        let bundlePath = NSBundle.mainBundle().resourcePath?.stringByAppendingString("/mapapi.bundle/")
        let bundle = NSBundle(path: bundlePath!)
        if let imagePath = bundle?.resourcePath?.stringByAppendingString("/images/icon_\(imageName!).png") {
            let image = UIImage(contentsOfFile: imagePath)
            if image != nil {
                view?.image = image
            }
        }
        return view
    }


}
