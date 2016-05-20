//
//  DistrictSearchDemoVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/19.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class DistrictSearchDemoVC: BaseViewController {
    
    @IBOutlet weak var contentMapView: BMKMapView!
    let districtSearch = BMKDistrictSearch()
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var districtTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "行政区域检索"
        
    }
    
    @IBAction func searchAction(sender: AnyObject) {
        let option = BMKDistrictSearchOption()
        option.city     = self.cityTextField.text
        option.district = self.districtTextField.text
        districtSearch.districtSearch(option)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        contentMapView.viewWillAppear()
        contentMapView.delegate = self
        districtSearch.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        contentMapView.viewWillDisappear()
        contentMapView.delegate = nil
        districtSearch.delegate = nil
    }
}

extension DistrictSearchDemoVC: BMKDistrictSearchDelegate{
    func onGetDistrictResult(searcher: BMKDistrictSearch!, result: BMKDistrictResult!, errorCode error: BMKSearchErrorCode) {
        if error == BMK_SEARCH_NO_ERROR {
            contentMapView.setCenterCoordinate(result.center, animated: true)
            for path in result.paths {
                let polygon = transferPathStringToPolygon(path as! String)
                if (polygon != nil) {
                    contentMapView.addOverlay(polygon) // 添加overlay
                }
            }
        }

    }
    
    //根据path string 生成 BMKPolygon
    func transferPathStringToPolygon(path: String) -> BMKPolygon? {
        let pts = path.componentsSeparatedByString(";")
        if  pts.count < 1 {
            return nil
        }
        
        var points = Array(count: pts.count, repeatedValue: BMKMapPoint(x: 0, y: 0))
        var index = 0
        for ptStr in pts {
            let range = ptStr.rangeOfString(",")
            let xStr = ptStr.substringToIndex((range?.startIndex)!)
            let yStr = ptStr.substringFromIndex((range?.endIndex)!)
            if xStr.characters.count > 0 && yStr.characters.count > 0  {
                points[index] = BMKMapPointMake(Double(xStr)!, Double(yStr)!)
                index += 1
            }
        }
        var polygon: BMKPolygon? = nil
        if index > 0 {
            polygon = BMKPolygon(points: &points, count: UInt(index))
        }
        return polygon
    }


}

extension DistrictSearchDemoVC: BMKMapViewDelegate{
    
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView! {
        if (overlay as? BMKPolygon) != nil {
            let polygonView = BMKPolygonView(overlay: overlay)
            polygonView.strokeColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.6)
            polygonView.fillColor = UIColor(red: 1, green: 1, blue: 0, alpha: 0.4)
            polygonView.lineWidth = 1
            polygonView.lineDash = true
            return polygonView
        }
        return nil
    }


}
