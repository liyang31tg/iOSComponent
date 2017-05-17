//
//  ConvertUtil.swift
//  handTreasure
//
//  Created by liyang on 16/5/19.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class ConvertUtil: NSObject {
    
   class func toString(_ s:Any?) -> String {
        if let str = s {
            if str is NSNumber {
                return String(describing: str)
            }
            if str is String {
                return str as! String
            }
        }
        return ""
    }
    
    class func toFloat(_ s:Any?) -> Float{
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
    
    class func toInt(_ s:Any?) -> Int{
        
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
    
    class func toJSONString(_ dic: NSDictionary) -> NSString{
        guard JSONSerialization.isValidJSONObject(dic) else {
            return ""
        }
        let data = try! JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let commitStr = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        var responseString:NSString = ""
        if let completeStr = commitStr{
            responseString = completeStr
            responseString = CommonUtil.handdleJsonStr(responseString)
        }
        return responseString
    }
    
    class func toDicObject(_ data:Data?) -> NSDictionary? {
    
        if let d = data {
            let commitStr =  NSString(data: d, encoding: String.Encoding.utf8.rawValue)
            var responseString:NSString = ""
            if let completeStr = commitStr{
                responseString = completeStr
                responseString = CommonUtil.handdleJsonStr(responseString)
            }
            let handleData:Data = responseString.data(using: String.Encoding.utf8.rawValue) ?? Data()
            let jj = try! JSONSerialization.jsonObject(with: handleData, options: JSONSerialization.ReadingOptions.mutableLeaves)
            return jj as? NSDictionary
        }
        return nil
     
    }
    
    /*
     根据属性字符串计算绘制所需要的高度
     思路就是 lineAscent＋lineDescent ＋lineLeading代表一行的高度，分别对每一行进行高度累加
     */
   class func getDisplayHeight(_ attributeStr: NSAttributedString,width:CGFloat) -> CGSize{
        
        let ctFrameSetter = CTFramesetterCreateWithAttributedString(attributeStr)
        
        //建议的宽高
        let suggestSize   =  CTFramesetterSuggestFrameSizeWithConstraints(ctFrameSetter, CFRangeMake(0, attributeStr.length), nil, CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), nil)
        
        let path =  CGMutablePath()
        
        CGPathAddRect(path, nil, CGRect(x: 0, y: 0, width: width, height: suggestSize.height*2))//2是假的，只是防止画布不够大，计算有误，下面才开始精确计算高度
        
        
        
        let ctFrame = CTFramesetterCreateFrame(ctFrameSetter, CFRangeMake(0, 0), path, nil)
        
        let lines =  CTFrameGetLines(ctFrame) as Array
        
        var lineOrigins = Array<CGPoint>(repeating: CGPoint.zero, count: lines.count)//获取每一个行的坐标
        
        CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), &lineOrigins)
        var lineAscent:CGFloat      = 0
        var lineDescent:CGFloat     = 0
        var lineLeading:CGFloat     = 0
        var lineTotalHeight:CGFloat = 0
        
        for (_,line) in lines.enumerated() {
            CTLineGetTypographicBounds(line as! CTLine, &lineAscent, &lineDescent, &lineLeading)
            let oneLineHeight = lineAscent+lineDescent + lineLeading + lineLeading//这里可以接上细节微调，来返回高度
            lineTotalHeight += oneLineHeight
        }
        //高度就这么计算好了
        print("suggestSize:\(suggestSize),CGSizeMake(suggestSize.width, lineTotalHeight):\(CGSize(width: suggestSize.width, height: lineTotalHeight))")
        return CGSize(width: suggestSize.width, height: lineTotalHeight + 3)
        
    }
    
    
}
