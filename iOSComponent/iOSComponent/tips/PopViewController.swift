//
//  PopViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/5/30.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class PopViewController: BaseViewController,PopViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func popAction(_ sender: UIButton) {
        
        let frame =  self.view.convert(sender.frame, from: self.view)
        let pop = PopContentView()
        pop.backgroundColor = UIColor.blue
        PopView.showInWindowWithSubFrame(frame, subBoundsDelegate: self, contentView: pop)
    }
    
    func popViewWH() -> (width: CGFloat, height: CGFloat) {
        return (100,170)
    }
}
