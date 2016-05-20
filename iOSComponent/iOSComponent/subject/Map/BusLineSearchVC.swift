//
//  BusLineSearchVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/19.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class BusLineSearchVC: BaseViewController {
    
    @IBOutlet weak var keyWordTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var contentMapView: BMKMapView!
    var isClockWise = true
    let poiSearch   = BMKPoiSearch()
    let busSearch   = BMKBusLineSearch()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        contentMapView.viewWillAppear()
        contentMapView.delegate = self
        poiSearch.delegate      = self
        busSearch.delegate      = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        contentMapView.viewWillDisappear()
        contentMapView.delegate = nil
        poiSearch.delegate      = nil
        busSearch.delegate      = nil
    }
    
    @IBAction func searchAction(sender: UIButton) {
        if sender.tag == 1{//上行
            searchPoi()
        }else{//下行
            searchPoi(false)
        }
    }
    //poi查询
    func searchPoi(isClockWise:Bool = true){
        self.isClockWise = isClockWise
       let option       = BMKCitySearchOption()
        option.city     = self.cityTextField.text
        option.keyword  = self.keyWordTextField.text
        poiSearch.poiSearchInCity(option)
    }
    
    func bslSearch(busUid:String){
        let option          = BMKBusLineSearchOption()
        option.city         = self.cityTextField.text
        option.busLineUid   = busUid
        busSearch.busLineSearch(option)
    }
    
    
}

extension BusLineSearchVC:BMKMapViewDelegate{
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

extension BusLineSearchVC:BMKBusLineSearchDelegate{
    func onGetBusDetailResult(searcher: BMKBusLineSearch!, result busLineResult: BMKBusLineResult!, errorCode error: BMKSearchErrorCode) {
        contentMapView.removeOverlays(contentMapView.overlays)
        contentMapView.removeAnnotations(contentMapView.annotations)
        if error == BMK_SEARCH_NO_ERROR {
            let busStations = busLineResult.busStations as! [BMKBusStation]
            for busStation in busStations {
                let item            = RouteAnnotation()
                item.type           = RouteAnnotation.RouteType.bus.rawValue
                item.coordinate     = busStation.location
                item.title          =   busStation.title
                contentMapView.addAnnotation(item)
            }
            
            contentMapView.setCenterCoordinate((busLineResult.busStations[0] as! BMKBusStation).location, animated: false)
            var tmpMapPoints:[BMKMapPoint]  = []
            let busSteps    = busLineResult.busSteps as! [BMKBusStep]
    
            for busStep in busSteps {
                for i in 0..<Int(busStep.pointsCount) {
                    var tmpMapPoint = BMKMapPoint()
                    tmpMapPoint.x = busStep.points[i].x
                    tmpMapPoint.y = busStep.points[i].y
                    tmpMapPoints.append(tmpMapPoint)
                }
            }
            
           let polyLine = BMKPolyline(points: &tmpMapPoints, count: UInt(tmpMapPoints.count))
            contentMapView.addOverlay(polyLine)
        
        }
    }

}

extension BusLineSearchVC:BMKPoiSearchDelegate{
    
    func onGetPoiResult(searcher: BMKPoiSearch!, result poiResult: BMKPoiResult!, errorCode: BMKSearchErrorCode) {
      let infolist =   poiResult.poiInfoList as! [BMKPoiInfo]
        var busUid:[String]     = []
        for poiInfo in infolist {
            if poiInfo.epoitype == 1 || poiInfo.epoitype == 2  {
                busUid.append(poiInfo.uid)
                print(poiInfo.name)
            }
        }
        if busUid.count > 0 {
        //公交路线查询
            if self.isClockWise {
              busUid =  busUid.reverse()
            }
            self.bslSearch(busUid[0])
        }
    }


}
