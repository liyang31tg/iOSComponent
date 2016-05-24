//
//  LYPullRefreshScrollView.swift
//  iOSComponent
//
//  Created by liyang on 16/5/20.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class LYPullRefreshScrollView: BaseViewController {
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "上啦下啦刷新"
        self.contentScrollView.contentSize = ScreenSize
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("contentInset:\(self.contentScrollView.contentInset)")
//        self.contentScrollView.contentInset
//        self.performSelectorOnMainThread(Selector, withObject: AnyObject?, waitUntilDone: Bool, modes: [String]?)
//        NSNotificationCenter.defaultCenter().
    }
}


extension LYPullRefreshScrollView:UIScrollViewDelegate{
    
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        
        print(scrollView.contentOffset.y)
        if (scrollView.contentOffset.y < -60) {
            
            UIView.animateWithDuration(0.3, animations: {
                self.contentScrollView.contentInset = UIEdgeInsetsMake(60.0, 0.0, 0.0, 0.0)
                }, completion: { (isFinish:Bool) in
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
                        sleep(3)
                        dispatch_async(dispatch_get_main_queue(), {
                            UIView.animateWithDuration(0.3, animations: {
                                self.contentScrollView.contentInset = UIEdgeInsetsZero
                                }, completion: nil)
                        })
                    })
                    
            })
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }


}
