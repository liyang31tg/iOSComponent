//
//  Config.swift
//  iOSComponent
//
//  Created by liyang on 16/5/17.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class Config: NSObject {
    private  var xml:XMLIndexer!
    var serverURL           = ""
    var imageURL            = ""
    var latitude:Double     = 0
    var longitude:Double    = 0
    var baiduMapKey         = ""
    
    override init() {
        super.init()
        self.readXML()
    }
    
    func readXML(){
        if let configPath = NSBundle.mainBundle().pathForResource("config", ofType: "xml"){
            let configs = try! NSString(contentsOfFile: configPath, encoding: NSUTF8StringEncoding)
            xml =  SWXMLHash.parse(configs as String)
            let root = xml["App"]
            let runTime = root.element?.attributes["runtime"]
            if let r = runTime {
                for elementsR in root.children{
                    if r == elementsR.element?.attributes["name"]!{
                        self.serverURL      = elementsR["server"].element?.text ?? ""
                        self.imageURL       = elementsR["imageUrl"].element?.text ?? ""//baiduMapKey
                        self.latitude       = Double(elementsR["latitude"].element?.text ?? "0") ?? 0
                        self.longitude      = Double(elementsR["longitude"].element?.text ?? "0") ?? 0
                        self.baiduMapKey    = elementsR["baiduMapKey"].element?.text ?? ""

                    }
                }
            }
        }
    }

}
