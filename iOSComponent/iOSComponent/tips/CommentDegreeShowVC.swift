//
//  CommentDegreeShowVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/24.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class CommentDegreeShowVC: BaseViewController {
    
    @IBOutlet weak var commentDegreeViewA: CommentDegreeShowView!
    @IBOutlet weak var commentDegreeViewB: CommentDegreeShowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentDegreeViewA.degree       = 4
        commentDegreeViewA.tap.enabled  = false
        
        commentDegreeViewB.degree       = 5
    }
}
