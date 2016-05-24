//
//  ConvertUtil.swift
//  handTreasure
//
//  Created by liyang on 16/5/19.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class ConvertUtil: NSObject {
    
   class func toString(s:Any?) -> String {
        if let str = s {
            if str is NSNumber {
                return String(str)
            }
            if str is String {
                return str as! String
            }
        }
        return ""
    }
    
    class func toFloat(s:Any?) -> Float{
        let tmp:Float = 0.0
        if let str = s {
            if str is NSNumber {
                return Float(str as! NSNumber)
            }
            if str is String {
                return (str as! NSString).floatValue
            }
        }
        return tmp
    
    }
    
    class func toInt(s:Any?) -> Int{
        
        if let str = s {
            if str is NSNumber {
                return Int(str as! NSNumber)
            }
            if str is String {
                if (str as! String).isEmpty {
                    return 0
                }
                return Int(str as! NSString as String) ?? 0
            }
        }
    
        return 0
    }
    
    class func toJSONString(dic: NSDictionary) -> NSString{
        guard NSJSONSerialization.isValidJSONObject(dic) else {
            return ""
        }
        let data = try! NSJSONSerialization.dataWithJSONObject(dic, options: NSJSONWritingOptions.PrettyPrinted)
        
        let commitStr = NSString(data: data, encoding: NSUTF8StringEncoding)
        var responseString:NSString = ""
        if let completeStr = commitStr{
            responseString = completeStr
            responseString = CommonUtil.handdleJsonStr(responseString)
        }
        return responseString
    }
    
    class func toDicObject(data:NSData?) -> NSDictionary? {
    
        if let d = data {
            let commitStr =  NSString(data: d, encoding: NSUTF8StringEncoding)
            var responseString:NSString = ""
            if let completeStr = commitStr{
                responseString = completeStr
                responseString = CommonUtil.handdleJsonStr(responseString)
            }
            let handleData:NSData = responseString.dataUsingEncoding(NSUTF8StringEncoding) ?? NSData()
            let jj = try! NSJSONSerialization.JSONObjectWithData(handleData, options: NSJSONReadingOptions.MutableLeaves)
            return jj as? NSDictionary
        }
        return nil
     
    }
    
    
}
