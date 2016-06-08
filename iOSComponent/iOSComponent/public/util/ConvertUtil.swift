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
    
    /*
     根据属性字符串计算绘制所需要的高度
     思路就是 lineAscent＋lineDescent ＋lineLeading代表一行的高度，分别对每一行进行高度累加
     */
   class func getDisplayHeight(attributeStr: NSAttributedString,width:CGFloat) -> CGSize{
        
        let ctFrameSetter = CTFramesetterCreateWithAttributedString(attributeStr)
        
        //建议的宽高
        let suggestSize   =  CTFramesetterSuggestFrameSizeWithConstraints(ctFrameSetter, CFRangeMake(0, attributeStr.length), nil, CGSize(width: width, height: CGFloat.max), nil)
        
        let path =  CGPathCreateMutable()
        
        CGPathAddRect(path, nil, CGRect(x: 0, y: 0, width: width, height: suggestSize.height*2))//2是假的，只是防止画布不够大，计算有误，下面才开始精确计算高度
        
        
        
        let ctFrame = CTFramesetterCreateFrame(ctFrameSetter, CFRangeMake(0, 0), path, nil)
        
        let lines =  CTFrameGetLines(ctFrame) as Array
        
        var lineOrigins = Array<CGPoint>(count: lines.count, repeatedValue: CGPointZero)//获取每一个行的坐标
        
        CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), &lineOrigins)
        var lineAscent:CGFloat      = 0
        var lineDescent:CGFloat     = 0
        var lineLeading:CGFloat     = 0
        var lineTotalHeight:CGFloat = 0
        
        for (_,line) in lines.enumerate() {
            CTLineGetTypographicBounds(line as! CTLine, &lineAscent, &lineDescent, &lineLeading)
            let oneLineHeight = lineAscent+lineDescent + lineLeading//这里可以接上细节微调，来返回高度
            lineTotalHeight += oneLineHeight
        }
        //高度就这么计算好了
        return CGSizeMake(suggestSize.width, lineTotalHeight + 0.5)
        
    }
    
    
}
