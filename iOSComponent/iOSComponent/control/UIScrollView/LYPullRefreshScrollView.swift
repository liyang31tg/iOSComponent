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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("contentInset:\(self.contentScrollView.contentInset)")
//        self.contentScrollView.contentInset
//        self.performSelectorOnMainThread(Selector, withObject: AnyObject?, waitUntilDone: Bool, modes: [String]?)
//        NSNotificationCenter.defaultCenter().
    }
}


extension LYPullRefreshScrollView:UIScrollViewDelegate{
    
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        print(scrollView.contentOffset.y)
        if (scrollView.contentOffset.y < -60) {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.contentScrollView.contentInset = UIEdgeInsetsMake(60.0, 0.0, 0.0, 0.0)
                }, completion: { (isFinish:Bool) in
                    DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.high).async(execute: {
                        sleep(3)
                        DispatchQueue.main.async(execute: {
                            UIView.animate(withDuration: 0.3, animations: {
                                self.contentScrollView.contentInset = UIEdgeInsets.zero
                                }, completion: nil)
                        })
                    })
                    
            })
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }


}
