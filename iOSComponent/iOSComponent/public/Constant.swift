//
//  Constant.swift
//  iOSComponent
//
//  Created by liyang on 16/4/23.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

let ScreenFrame     = UIScreen.mainScreen().applicationFrame
let ScreenBounds    = UIScreen.mainScreen().bounds
let ScreenSize      = ScreenBounds.size
let ScreenWidth     = ScreenBounds.width
let ScreenHeight    = ScreenBounds.height


let cornerCenter    = CLLocationCoordinate2D(latitude: Application.shareInstance.config.latitude, longitude: Application.shareInstance.config.longitude)
