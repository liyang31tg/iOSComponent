//
//  URLUtil.swift
//  iOSComponent
//
//  Created by liyang on 16/5/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class URLUtil{

    class func appendPath(_ preUrl:String,path:String) -> String{
        if  preUrl.hasSuffix("/") {
            return preUrl + path
        }else{
            return preUrl + "/" + path
        }
    
    }
}
