//
//  CommonUtil.swift
//  handTreasure
//
//  Created by liyang on 16/5/21.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class CommonUtil: NSObject {
    /*
     *处理掉json字符串中不必要的字符
     *
     */
    class func handdleJsonStr(handleStr:NSString,deleteStrs:[String] = ["\r\n","\n","\r","\\"," "]) -> NSString{
        var  responseString = handleStr
        for dStr in deleteStrs {
            responseString = responseString.stringByReplacingOccurrencesOfString(dStr, withString: "")
        }
        return responseString
    }
    
    /*
     根据属性字符串计算绘制所需要的高度
     思路就是 lineAscent＋lineDescent ＋lineLeading代表一行的高度，分别对每一行进行高度累加
     */
   class func caculateDisplayHeight(attributeStr: NSAttributedString,width:CGFloat) -> CGFloat{
        
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
            let oneLineHeight = lineAscent + lineDescent + lineLeading//这里可以接上细节微调，来返回高度
            lineTotalHeight += oneLineHeight
        }
        //高度就这么计算好了
        return lineTotalHeight
    }
    
    /*
     *交换方法实现
     */
    class func exchangeSelectorImplement(obser:AnyClass,originalSelector:Selector, swizzledSelector:Selector){
        let originalMethod = class_getInstanceMethod(obser, originalSelector)
        let swizzledMethod = class_getInstanceMethod(obser, swizzledSelector)
        
        let didAddMethod = class_addMethod(obser, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(obser, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }

    
    }
    
    
    
}
