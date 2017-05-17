//
//  AnimatedAnnotationView.swift
//  iOSComponent
//
//  Created by liyang on 16/5/17.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
/*
 *自定义BMKAnnotationView：动画AnnotationView
 */
class AnimatedAnnotationView: BMKAnnotationView {
    
    var annotationImages: [UIImage]!
    var annotationImageView: UIImageView!
    
    override init(annotation: BMKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        self.backgroundColor = UIColor.clear
        
        annotationImageView = UIImageView(frame: bounds)
        annotationImageView.contentMode = UIViewContentMode.center
        
        self.addSubview(annotationImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImages(_ images: [UIImage]) {
        annotationImages = images
        updateImageView()
    }
    
    func updateImageView() {
        if annotationImageView.isAnimating {
            annotationImageView.stopAnimating()
        }
        annotationImageView.animationImages = annotationImages
        annotationImageView.animationDuration = 0.5 * TimeInterval(self.annotationImages.count)
        annotationImageView.animationRepeatCount = 0
        annotationImageView.startAnimating()
    }
}
