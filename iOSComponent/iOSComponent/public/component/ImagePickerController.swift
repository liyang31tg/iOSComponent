//
//  ImagePickerController.swift
//  iOSComponent
//
//  Created by liyang on 16/5/30.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import PhotosUI

class ImagePickerController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ImagePickerController.dismiss)))
        
        let a = PHAsset.fetchAssets(with: nil)
        print(a)
        
    
    }
    func dismiss(){
        self.dismiss(animated: true, completion: nil)
    }
}
