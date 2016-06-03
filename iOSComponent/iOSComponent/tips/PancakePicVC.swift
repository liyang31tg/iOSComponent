//
//  PancakePicVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/31.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class PancakePicVC: BaseViewController {
    
    @IBOutlet weak var pannacakeView: PanCakeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pannacakeView.dataArray = [ PanCakeDomain(color: UIColor.redColor(), value: 53),
                                    PanCakeDomain(color: UIColor.brownColor(), value: 23),
                                    PanCakeDomain(color: UIColor.purpleColor(), value: 23)]
    }
}
