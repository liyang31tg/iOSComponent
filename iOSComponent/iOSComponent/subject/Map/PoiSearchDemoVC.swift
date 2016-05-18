//
//  PoiSearchDemoVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/18.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class PoiSearchDemoVC: BaseViewController {
    
    @IBOutlet weak var contentMapView: BMKMapView!
    let poiSearch                       = BMKPoiSearch()
    lazy var locationService            = BMKLocationService()
    var currentUserLocation: BMKUserLocation?
    
    lazy var bound: BMKGroundOverlay = {
        var tmpBounds = BMKCoordinateBounds()
        tmpBounds.southWest = CLLocationCoordinate2DMake(30.626389963074498, 104.09079143912265)
        tmpBounds.northEast = CLLocationCoordinate2DMake(30.632052091088806, 104.0972592920464)
        return BMKGroundOverlay(bounds: tmpBounds, icon: UIImage(named: "test.png"))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title                  = "poi 关键字搜索／区域搜索/周边搜索"
        poiSearch.delegate          = self
        locationService.delegate    = self
        locationService.startUserLocationService()
        
        contentMapView.showsUserLocation    = true
        contentMapView.userTrackingMode     = BMKUserTrackingModeFollow
        searchInCity()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        contentMapView.viewWillAppear()
        contentMapView.delegate = self
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        contentMapView.viewWillDisappear()
        contentMapView.delegate = nil
    }
    @IBAction func segementAction(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            case 0://城市搜索
                searchInCity()
            case 1://区域搜索
                searchInSection()
            case 2://周边搜索
                searchArround()
            case 3:
                searchDetail()
            default:
                break
        }
        
    }
    
    func searchInCity(){
        
        let option          = BMKCitySearchOption()
        option.city         = "成都"
        option.keyword      = "公交站"
        option.pageIndex    = 0
        option.pageCapacity = 10
        poiSearch.poiSearchInCity(option)
    
    }
    
    func searchInSection(){
        //这里有个情况，就是筛选出来的区域，不限于这个区域，优先满足条件是 pageCapacity ，如果这个区域的结果不满足于 pageCapacity，就会从外面的区域外筛选出满足的个数，，，，，，，一句话，先满足分页
        let option          = BMKBoundSearchOption()
        option.keyword      = "美食"
        option.leftBottom   = CLLocationCoordinate2D(latitude: 30.626389963074498, longitude: 104.09079143912265)
        
        option.rightTop     = CLLocationCoordinate2D(latitude: 30.632052091088806, longitude: 104.0972592920464)
        
        poiSearch.poiSearchInbounds(option)
        
        contentMapView.addOverlay(bound)
    
    }
    
    func searchArround(){
        if let userLocation = self.currentUserLocation {
            
            let option = BMKNearbySearchOption()
            
            option.location = userLocation.location.coordinate
            option.radius   = 1000
            
            option.keyword = "美食"
            
            poiSearch.poiSearchNearBy(option)
            
            contentMapView.zoomLevel = 17
        }
    }
    
    func searchDetail(uid:String = "a11c840af07354a3246e98ab"){
        let detailSearch = BMKPoiDetailSearchOption()
        detailSearch.poiUid = uid
        poiSearch.poiDetailSearch(detailSearch)
    }
    
}

//MARK:BMKMapViewDelegate
extension PoiSearchDemoVC: BMKMapViewDelegate{
    
    
    func mapView(mapView: BMKMapView!, onClickedMapPoi mapPoi: BMKMapPoi!) {
        print("当前坐标:\(mapPoi.pt)")
    }
    func mapView(mapView: BMKMapView!, onClickedMapBlank coordinate: CLLocationCoordinate2D) {
        print("当前坐标:\(coordinate)")
    }
    
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        let annotationViewIndentifier = "annotationViewIndentifier"
        var bmkPAView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationViewIndentifier) as? BMKPinAnnotationView
        if bmkPAView == nil {
           bmkPAView  =  BMKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationViewIndentifier)
        }
        bmkPAView?.annotation = annotation
        return bmkPAView
    }
    
    //返回覆盖物的view
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView! {
        if overlay is BMKGroundOverlay {
            let groundView = BMKGroundOverlayView(groundOverlay: overlay as! BMKGroundOverlay)
            return groundView
        }
        return nil
    }
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        
        let a = view.annotation as! CustomUidBMKPointAnnotation
        self.searchDetail(a.uid)
        print("didSelectAnnotationView:\(a.uid),epoitype:\(a.epoitype)")
    }
    
    func mapView(mapView: BMKMapView!, didDeselectAnnotationView view: BMKAnnotationView!) {
        print("didDeselectAnnotationView")
    }
    
    func mapView(mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        print("annotationViewForBubble")
        
        
    }
    
}
//MARK:BMKPoiSearchDelegate
extension PoiSearchDemoVC: BMKPoiSearchDelegate{
 

    func onGetPoiResult(searcher: BMKPoiSearch!, result poiResult: BMKPoiResult!, errorCode: BMKSearchErrorCode) {
        contentMapView.removeAnnotations(contentMapView.annotations)//每次检索都先清楚屏幕上个所有的标注
        var anotations: [BMKPointAnnotation] = []
        if errorCode == BMK_SEARCH_NO_ERROR{
            for poi in poiResult.poiInfoList {
                let p = poi as! BMKPoiInfo
                let item        = CustomUidBMKPointAnnotation()
                item.uid        = p.uid
                item.epoitype   = p.epoitype
                item.coordinate = p.pt
                item.title      = p.name
                anotations.append(item)
            }
            contentMapView.addAnnotations(anotations)
//            contentMapView.showAnnotations(anotations, animated: true)
        }
        
    }
    
    func onGetPoiDetailResult(searcher: BMKPoiSearch!, result poiDetailResult: BMKPoiDetailResult!, errorCode: BMKSearchErrorCode) {
        if errorCode == BMK_SEARCH_NO_ERROR {
            print(poiDetailResult.address)
        }
    }

}
//MARK:BMKLocationServiceDelegate
extension PoiSearchDemoVC: BMKLocationServiceDelegate {
    
    //定位代理方法
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        contentMapView.updateLocationData(userLocation)
        self.currentUserLocation = userLocation
    }
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        contentMapView.updateLocationData(userLocation)
        self.currentUserLocation = userLocation
    }



}

class CustomUidBMKPointAnnotation: BMKPointAnnotation {
    var uid                 = ""
    //POI类型，0:普通点 1:公交站 2:公交线路 3:地铁站 4:地铁线路
    var epoitype:Int32      = 0
}
