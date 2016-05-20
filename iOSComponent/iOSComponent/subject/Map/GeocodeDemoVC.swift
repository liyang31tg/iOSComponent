//
//  GeocodeDemoVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/18.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class GeocodeDemoVC: BaseViewController {
    
    @IBOutlet weak var contentMapView: BMKMapView!
    let mapCodeSearch = BMKGeoCodeSearch()
    var tmpCoord        = CLLocationCoordinate2D()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "地理编码功能"
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        contentMapView.viewWillAppear()
        contentMapView.delegate = self
        mapCodeSearch.delegate  = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        contentMapView.viewWillDisappear()
        contentMapView.delegate = nil
        mapCodeSearch.delegate  = nil
        
    }
    @IBAction func segementControl(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0://地理编码
                let option = BMKGeoCodeSearchOption()
                option.city     = "成都"
                option.address  = "二环路东五段附10号院"
                mapCodeSearch.geoCode(option)
            case 1://逆向地理编码
                let option = BMKReverseGeoCodeOption()
                option.reverseGeoPoint = self.tmpCoord
                mapCodeSearch.reverseGeoCode(option)
            default:
                break
        }
    }
}


extension GeocodeDemoVC: BMKMapViewDelegate{}

extension GeocodeDemoVC: BMKGeoCodeSearchDelegate{

    func onGetGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        self.tmpCoord = result.location
        let alertVC =   UIAlertController(title: result.address, message: "latitude:\(result.location.latitude),longitude:\(result.location.longitude)", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel) { (UIAlertAction) in
        alertVC.dismissViewControllerAnimated(true, completion: nil)
        }
        alertVC.addAction(cancelAction)
        self.presentViewController(alertVC, animated: true, completion: nil)
        
        print(result.location)
        print(result.address)
    }
    
    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        let alertVC =   UIAlertController(title: nil, message: result.d, preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel) { (UIAlertAction) in
            alertVC.dismissViewControllerAnimated(true, completion: nil)
        }
        alertVC.addAction(cancelAction)
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
}


extension BMKReverseGeoCodeResult{
    /*
     /// 街道号码
     @property (nonatomic, strong) NSString* streetNumber;
     /// 街道名称
     @property (nonatomic, strong) NSString* streetName;
     /// 区县名称
     @property (nonatomic, strong) NSString* district;
     /// 城市名称
     @property (nonatomic, strong) NSString* city;
     /// 省份名称
     @property (nonatomic, strong) NSString* province;
     */
    
    var d: String{
        get{
            var r = "streetNumber:\(self.addressDetail.streetNumber),streetName:\(self.addressDetail.streetName),district:\(self.addressDetail.district),city:\(self.addressDetail.city),province:\(self.addressDetail.province)"
            
            r += "address:\(self.address)"
            
            r += "businessCircle:\(self.businessCircle)"
            
            for poi in self.poiList {
                let p = poi as! BMKPoiInfo
                r += "BMKPoiInfo poi name:\(p.name)"
            }
            return r
        }
        
    }

}