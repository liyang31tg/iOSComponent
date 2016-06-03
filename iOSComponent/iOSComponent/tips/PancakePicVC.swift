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
    @IBOutlet weak var singleSelectbtnView: SingleSelectBtnView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pannacakeView.dataArray = [ PanCakeDomain(color: UIColor.redColor(), value: 53),
                                    PanCakeDomain(color: UIColor.brownColor(), value: 23),
                                    PanCakeDomain(color: UIColor.purpleColor(), value: 23)]
        
        
        
        singleSelectbtnView.dataArray = [SingleSelectBtnViewDomain(showText: "我"),
                                         SingleSelectBtnViewDomain(showText: "爱"),
                                         SingleSelectBtnViewDomain(showText: "中"),
                                         SingleSelectBtnViewDomain(showText: "华"),
                                         SingleSelectBtnViewDomain(showText: "啊")]
        singleSelectbtnView.delegate = self
    
    }
    
    override func viewDidAppear(animated: Bool) {
            super.viewDidAppear(animated)
            print(self.singleSelectbtnView.frame)
    }
}
extension PancakePicVC:SingleSelectBtnDelegate{
    func singleSelectBtnView(btnView: SingleSelectBtnView, clickIndex: Int) {
        print("clickIndex:\(clickIndex)")
    }

}
