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
    
    @IBAction func searchAction(_ sender: AnyObject) {
        let option = BMKDistrictSearchOption()
        option.city     = self.cityTextField.text
        option.district = self.districtTextField.text
        districtSearch.districtSearch(option)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentMapView.viewWillAppear()
        contentMapView.delegate = self
        districtSearch.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        contentMapView.viewWillDisappear()
        contentMapView.delegate = nil
        districtSearch.delegate = nil
    }
}

extension DistrictSearchDemoVC: BMKDistrictSearchDelegate{
    func onGetDistrictResult(_ searcher: BMKDistrictSearch!, result: BMKDistrictResult!, errorCode error: BMKSearchErrorCode) {
        if error == BMK_SEARCH_NO_ERROR {
            contentMapView.setCenter(result.center, animated: true)
            for path in result.paths {
                let polygon = transferPathStringToPolygon(path as! String)
                if (polygon != nil) {
                    contentMapView.add(polygon) // 添加overlay
                }
            }
        }

    }
    
    //根据path string 生成 BMKPolygon
    func transferPathStringToPolygon(_ path: String) -> BMKPolygon? {
        let pts = path.components(separatedBy: ";")
        if  pts.count < 1 {
            return nil
        }
        
        var points = Array(repeating: BMKMapPoint(x: 0, y: 0), count: pts.count)
        var index = 0
        for ptStr in pts {
            let range = ptStr.range(of: ",")
            let xStr = ptStr.substring(to: (range?.lowerBound)!)
            let yStr = ptStr.substring(from: (range?.upperBound)!)
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
    
    func mapView(_ mapView: BMKMapView!, viewFor overlay: BMKOverlay!) -> BMKOverlayView! {
        if (overlay as? BMKPolygon) != nil {
            let polygonView = BMKPolygonView(overlay: overlay)
            polygonView?.strokeColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.6)
            polygonView?.fillColor = UIColor(red: 1, green: 1, blue: 0, alpha: 0.4)
            polygonView?.lineWidth = 1
            polygonView?.lineDash = true
            return polygonView
        }
        return nil
    }


}
