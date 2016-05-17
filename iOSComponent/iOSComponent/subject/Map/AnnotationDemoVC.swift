//
//  AnnotationDemoVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/17.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class AnnotationDemoVC: BaseViewController {
    
    @IBOutlet weak var contentMapView: BMKMapView!
    
    //添加覆盖物的点－－－－－－－－start
    lazy var circle                 = BMKCircle(centerCoordinate: cornerCenter, radius: 200)
    lazy var polygon:BMKPolygon     = {
        var coords: [CLLocationCoordinate2D] = []
        coords.append(CLLocationCoordinate2DMake(30.635208651004127, 104.10196433733876))
        coords.append(CLLocationCoordinate2DMake(30.631330402299856, 104.1010491358968))
        coords.append(CLLocationCoordinate2DMake(30.629731498772841, 104.10395947660402))
        coords.append(CLLocationCoordinate2DMake(30.632312061403987, 104.10597291910474))
        let polygon = BMKPolygon(coordinates: &coords, count: UInt(coords.count))
        return polygon
    }()
    
    lazy var polyLine:BMKPolyline = {
        var coords = [
            CLLocationCoordinate2DMake(30.636665008329476, 104.10379474001704),
            CLLocationCoordinate2DMake(30.633388324713533, 104.10807788251019)
            ]
        let polyline = BMKPolyline(coordinates: &coords, count: UInt(coords.count))
        return polyline
    
    }()
    
    lazy var colorfulPolyline:BMKPolyline = {
        var coords = [
            CLLocationCoordinate2DMake(30.625964320044684, 104.09281232280617),
            CLLocationCoordinate2DMake(30.622148789666749, 104.09197033759459),
            CLLocationCoordinate2DMake(30.620866125925797, 104.09720528918648),
            CLLocationCoordinate2DMake(30.6247444435174, 104.09603383112621),
            CLLocationCoordinate2DMake(30.625947437276281, 104.09583248668078)]
        //构建分段颜色索引数组
        let colorIndex = [2, 0, 1, 2]
        //构建BMKPolyline,使用分段颜色索引，其对应的BMKPolylineView必须设置colors属性
       let  tmpColorfulPolyline = BMKPolyline(coordinates: &coords, count: UInt(coords.count), textureIndex: colorIndex)
        
        return tmpColorfulPolyline
    
    }()
    
    lazy var arcline:BMKArcline = {
        var coords = [
            CLLocationCoordinate2DMake(30.624808583143086, 104.09971294140374),
            CLLocationCoordinate2DMake(30.620518305585229, 104.09931025292414),
            CLLocationCoordinate2DMake(30.624349263484024, 104.10401438894823)]
        let arcline = BMKArcline(coordinates: &coords)
        return arcline
    }()
    
    lazy var bound: BMKGroundOverlay = {
        var tmpBounds = BMKCoordinateBounds()
        tmpBounds.southWest = CLLocationCoordinate2DMake(30.630902770254409, 104.1012321745882)
        tmpBounds.northEast = CLLocationCoordinate2DMake(30.629177817887768, 104.10575327113288)
        return BMKGroundOverlay(bounds: tmpBounds, icon: UIImage(named: "test.png"))
    }()
    //添加覆盖物的点 ------------ end
    
    
    //添加Annotation ----------- start
    lazy var pointAnnotation: BMKPointAnnotation = {
        let pointAnnotation = BMKPointAnnotation()
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.627626486548849, 104.10425234073799)
            pointAnnotation.title = "我是伊藤洋华堂"
            pointAnnotation.subtitle = "可以随便拖拽日本的超市"
        return pointAnnotation
    
    }()
    
    lazy var animatedAnnotation: BMKPointAnnotation = {
        let animatedAnnotation = BMKPointAnnotation()
            animatedAnnotation.coordinate = CLLocationCoordinate2DMake(30.627988342188011, 104.10194829944245)
            animatedAnnotation.title = "我是动画Annotation"
        return animatedAnnotation
        
    }()

    
    
    
    
   
    
    
    
    //添加Annotation ------------ end
    
    

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "覆盖物功能"
        self.addOverlayViews()
        
        contentMapView.centerCoordinate = cornerCenter
        contentMapView.zoomLevel        = 17

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
        contentMapView.removeOverlays(contentMapView.overlays)
        contentMapView.removeAnnotations(contentMapView.annotations)
        switch sender.selectedSegmentIndex {
        case 0://内置覆盖物
            addOverlayViews()
            break;
        case 1://标注
            addPointAnnotation()
            addAnimatedAnnotation()
        case 2://图片图层
            addGroundOverlay()
            break;
        default:
            break
        }

    }
    
    //MARK:添加内置覆盖物
    func addOverlayViews() {
        //一个圆
        contentMapView.addOverlay(circle)
        //添加一个多边形
        contentMapView.addOverlay(polygon)
        
        // 添加折线覆盖物
        contentMapView.addOverlay(polyLine)
        
        //添加折现覆盖物
        contentMapView.addOverlay(colorfulPolyline)
        
        //添加一个圆弧覆盖物
        contentMapView.addOverlay(arcline)
    }
    //MARK:
    func addPointAnnotation(){
        contentMapView.addAnnotation(pointAnnotation)
    
    }
    
    func addAnimatedAnnotation(){
        contentMapView.addAnnotation(animatedAnnotation)
    
    }
    
    //添加图片图层覆盖物
    func addGroundOverlay() {
        contentMapView.addOverlay(bound)
    }


    
}

//MARK:BMKMapViewDelegate
extension AnnotationDemoVC: BMKMapViewDelegate{
    
    func mapView(mapView: BMKMapView!, onClickedMapPoi mapPoi: BMKMapPoi!) {
        print("当前坐标:\(mapPoi.pt)")
        mapView.centerCoordinate = mapPoi.pt//将点击的经纬度设置为中心
    }
    func mapView(mapView: BMKMapView!, onClickedMapBlank coordinate: CLLocationCoordinate2D) {
        print("当前坐标:\(coordinate)")
        mapView.centerCoordinate = coordinate
    }
    
    //MARK:覆盖物的处理
    func mapView(mapView: BMKMapView!, didAddOverlayViews overlayViews: [AnyObject]!) {
        print("didAddOverlayViews:\(overlayViews)")
    }
    //返回覆盖物的view
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView! {
        if overlay is BMKCircle {
            let circleView =   BMKCircleView(circle: overlay as! BMKCircle)
            circleView.fillColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
            circleView.strokeColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
            circleView.lineWidth = 1
            return circleView
        }
        
        if overlay is BMKPolygon{
            let polygonView = BMKPolygonView(polygon: overlay as! BMKPolygon)
            polygonView.fillColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
            polygonView.strokeColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
            polygonView.lineWidth = 1
            return polygonView
        }
        
        if let overlayTemp = overlay as? BMKPolyline {
            let polylineView = BMKPolylineView(overlay: overlay)
            if overlayTemp == polyLine {
                polylineView.strokeColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
                polylineView.lineWidth = 10
                polylineView.loadStrokeTextureImage(UIImage(named: "texture_arrow.png"))
            }else{
                polylineView.lineWidth = 5
                // 使用分段颜色绘制时，必须设置（内容必须为UIColor）
                polylineView.colors = [UIColor(red: 0, green: 1, blue: 0, alpha: 1),
                                       UIColor(red: 1, green: 0, blue: 0, alpha: 1),
                                       UIColor(red: 1, green: 1, blue: 0, alpha: 1)]
            }
            return polylineView
        }
        
        if overlay is BMKArcline {
            let arclineView = BMKArclineView(arcline: overlay as! BMKArcline)
            arclineView.strokeColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
            arclineView.lineDash = true
            arclineView.lineWidth = 5
            return arclineView
        }
        
        
        if overlay is BMKGroundOverlay {
            let groundView = BMKGroundOverlayView(groundOverlay: overlay as! BMKGroundOverlay)
            return groundView
        }
        return nil
        
    }
    //点击覆盖物
    func mapView(mapView: BMKMapView!, onClickedBMKOverlayView overlayView: BMKOverlayView!) {
        print("didAddOverlayViews:\(overlayView)")
        
    }
    
    //标注
    func mapView(mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        print("点击了泡泡:")
    }
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        print("didSelectAnnotationView")
    }
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        // 普通标注
        if (annotation as! BMKPointAnnotation) == pointAnnotation {
            let AnnotationViewID = "renameMark"
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(AnnotationViewID) as! BMKPinAnnotationView?
            if annotationView == nil {
                annotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: AnnotationViewID)
                // 设置颜色
                annotationView!.pinColor = UInt(BMKPinAnnotationColorPurple)
                // 从天上掉下的动画
                annotationView!.animatesDrop = true
                // 设置可拖曳
                annotationView!.draggable = true
            }

            annotationView?.annotation = annotation
            return annotationView
        }
        
        // 动画标注
        if (annotation as! BMKPointAnnotation) == animatedAnnotation {
            let AnnotationViewID = "AnimatedAnnotation"
            
            
            let annotationView = AnimatedAnnotationView(annotation: annotation, reuseIdentifier: AnnotationViewID)
            annotationView.draggable = true
            var images = Array(count: 3, repeatedValue: UIImage())
            for i in 1...3 {
                let image = UIImage(named: "poi_\(i).png")
                images[i-1] = image!
            }
            annotationView.setImages(images)
//            annotationView.paopaoView 自定义泡泡
            return annotationView
        }

        return nil
        
    }
    
    func mapView(mapView: BMKMapView!, annotationView view: BMKAnnotationView!, didChangeDragState newState: UInt, fromOldState oldState: UInt) {
        print("annotation view state change : \(oldState) : \(newState)")
    }
    
    func mapView(mapView: BMKMapView!, didAddAnnotationViews views: [AnyObject]!) {
        print("didAddAnnotationViews")
    }
    
    

}
