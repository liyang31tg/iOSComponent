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
    
    @IBOutlet weak var progressView: ProgressView!
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
        
        
        let node1 =  ProgressNode(selectImageName: "tabbar_mainframeHL", normalImageName: "tabbar_discoverHL", title: "yyyy", titleSelectColor: UIColor.blueColor(), titleNormalColor:  UIColor.grayColor())
        let node2 =  ProgressNode(selectImageName: "tabbar_mainframeHL", normalImageName: "tabbar_discoverHL", title: "ttttt", titleSelectColor: UIColor.blueColor(), titleNormalColor:  UIColor.grayColor())
        let node3 =  ProgressNode(selectImageName: "tabbar_mainframeHL", normalImageName: "tabbar_discoverHL", title: "上门维修", titleSelectColor: UIColor.blueColor(), titleNormalColor:  UIColor.grayColor())
        let node4 =  ProgressNode(selectImageName: "tabbar_mainframeHL", normalImageName: "tabbar_discoverHL", title: "付款", titleSelectColor: UIColor.blueColor(), titleNormalColor:  UIColor.grayColor())
        let node5 =  ProgressNode(selectImageName: "tabbar_mainframeHL", normalImageName: "tabbar_discoverHL", title: "评价", titleSelectColor: UIColor.blueColor(), titleNormalColor:  UIColor.grayColor())
        
        progressView.nodes = [node1,node2,node3,node4,node5]
        
        progressView.imageSize = CGSize(width: 20, height: 20)
        
        progressView.setSelectIndex1(4)
    
    }
    
    override func viewDidAppear(animated: Bool) {
            super.viewDidAppear(animated)
    }
}
extension PancakePicVC:SingleSelectBtnDelegate{
    func singleSelectBtnView(btnView: SingleSelectBtnView, clickIndex: Int) {
        print("clickIndex:\(clickIndex)")
    }

}
