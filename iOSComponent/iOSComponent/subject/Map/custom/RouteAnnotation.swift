//
//  RouteAnnotation.swift
//  iOSComponent
//
//  Created by liyang on 16/5/19.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class RouteAnnotation: BMKPointAnnotation {
    enum RouteType:Int {
        case starting   = 0
        case ending     = 1
        case bus        = 2
        case tubes      = 3
        case driving    = 4
        case approach   = 5
    }
    var type = RouteType.starting.rawValue //<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
}
