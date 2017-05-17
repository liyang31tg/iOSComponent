//
//  ColorExtension.swift
//  iOSComponent
//
//  Created by liyang on 16/5/28.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    class func ColorWithRGBDataSource(red:CGFloat, green:CGFloat, blue:CGFloat,alpha:CGFloat) -> UIColor{
        let reds        = red / 255.0
        let greens      = green / 255.0
        let blues       = blue / 255.0
        let lastColor   = UIColor(red: reds, green: greens, blue: blues, alpha: alpha)
        return lastColor
    }
    //MARK  十六进制颜色
    class func colorWithHexColorString(_ hexColorString:String)->UIColor{
        return UIColor.colorWithHexColorString(hexColorString, alpha: 1.0)
    }
    
    class  func colorWithHexColorString(_ hexColorString:String,alpha:CGFloat)->UIColor{
        var red =   0, green    =   0, blue =   0
        var range       =   NSRange()
        range.length    = 2
        range.location  = 0
        red             = self.getHexIntWith((hexColorString as NSString).substring(with: range))
        range.location  = 2
        green           = self.getHexIntWith((hexColorString as NSString).substring(with: range))
        range.location  = 4
        blue            = self.getHexIntWith((hexColorString as NSString).substring(with: range))
        return UIColor(red: CGFloat(Double(red)/255.0), green: CGFloat(Double(green)/255.0), blue: CGFloat(Double(blue)/255.0), alpha: alpha)
    }
    
    
    //TODO:这个方法只能用于解析2位的16进制翻译成
    fileprivate  class func getHexIntWith(_ hexStr:String)->Int{
        var a:[Int] = []
        for charactor in hexStr.characters {
            a.append(self.getIntBy(charactor))
        }
        let c       = a.reversed()
        var result  =    0
        for (index,item) in c.enumerated() {
            let r   = Int(pow(16.0, Double(index))*Double(item))
            result  = result + r
        }
        return result
    }
    //TODO:16进制转10进制
    fileprivate  class func getIntBy(_ hex:Character)->Int{
        switch hex{
        case "1":
            return 1
        case "2":
            return 2
        case "3":
            return 3
        case "4":
            return 4
        case "5":
            return 5
        case "6":
            return 6
        case "7":
            return 7
        case "8":
            return 8
        case "9":
            return 9
        case "a","A":
            return 10
        case "b","B":
            return 11
        case "c","C":
            return 12
        case "d","D":
            return 13
        case "e","E":
            return 14
        case "f","F":
            return 15
        default :
            return 0
        }
        
    }


}
