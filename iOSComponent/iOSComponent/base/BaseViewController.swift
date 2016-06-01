//
//  BaseViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/4/15.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.navigationController?.viewControllers.first == self {
            self.navigationItem.leftBarButtonItem = nil
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "fts_search_backicon_ios7"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BaseViewController.backAction))
        }
        
    }
    
    func backAction(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    //MARK 解决假卡死
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if self.navigationController?.viewControllers.first == self {
            self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        }else{
            self.navigationController?.interactivePopGestureRecognizer?.enabled = true
        }
    }
    //MARK:StoryBoardz之间的跳转
    func getUIStoryboard(storyboardName: String) -> UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: NSBundle.mainBundle())
    }
    func getUIViewController(storyboard: UIStoryboard, controllerIdentifier: String) -> UIViewController {
        return storyboard.instantiateViewControllerWithIdentifier(controllerIdentifier)
    }
    
    func storyboardNavPushToController(storyboardName: String, controllerIdentifier: String,settingBlockPushVC:((UIViewController?)->())?) -> UIViewController {
        let storyboard = self.getUIStoryboard(storyboardName)
        let pushController = self.getUIViewController(storyboard, controllerIdentifier: controllerIdentifier)
        settingBlockPushVC?(pushController)
        self.navigationController?.pushViewController(pushController, animated: true)
        return pushController
    }

}