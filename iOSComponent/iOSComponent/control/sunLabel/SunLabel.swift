//
//  SunLabel.swift
//  iOSComponent
//
//  Created by liyang on 16/4/22.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class SunLabel: UIView {
    
    override class func layerClass() -> AnyClass{
    
        return SunAsynsLayer.classForCoder()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
      

       
    }
    
}


class SunAsynsLayer: CALayer {
    
    deinit{
        print("sunLayer is die")
    }
    
    
    override func drawInContext(ctx: CGContext) {
        super.drawInContext(ctx)
        
        let path = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("test.pdf")
        let context = ctx
        CGContextTranslateCTM(context, 0.0, self.bounds.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        let url = NSURL(fileURLWithPath: path) as CFURLRef
        let pdf = CGPDFDocumentCreateWithURL(url)
        let page = CGPDFDocumentGetPage(pdf, 1)
        CGContextSaveGState(context)
        
        //        let pdfTransform = CGPDFPageGetDrawingTransform(page, CGPDFBox.CropBox, self.bounds, 0, true)
        //        CGContextConcatCTM(context, pdfTransform)
        
        CGContextDrawPDFPage(context, page);
        CGContextRestoreGState(context);
        
        
        
    }

    
    
}
