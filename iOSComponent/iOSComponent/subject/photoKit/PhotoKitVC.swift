//
//  PhotoKitVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/30.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import PhotosUI

class PhotoKitVC: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func openPhotoAction(_ sender: AnyObject) {
        let imagePickerVC = ImagePickerController()
        imagePickerVC.view.backgroundColor = UIColor.red
        self.present(imagePickerVC, animated: true, completion: nil)
    }
}
