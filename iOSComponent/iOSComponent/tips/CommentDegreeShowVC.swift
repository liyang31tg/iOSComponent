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
    
    var  observe = NSNotificationCenter.defaultCenter().addObserverForName("oneNotification", object: nil, queue: NSOperationQueue.mainQueue()) { (n:NSNotification) in
        print("\(self)我收到通知了:object:\(n.object),userInfo:\(n.userInfo)")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentDegreeViewA.degree       = 4
        commentDegreeViewA.tap.enabled  = false
        
        commentDegreeViewB.degree       = 5
        
        let tap =   UITapGestureRecognizer(target: self, action: #selector(CommentDegreeShowVC.tap(_:)))
        self.view.addGestureRecognizer(tap)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentDegreeShowVC.noticeAcion(_:)), name: "oneNotification", object: nil)
        
     
        print("ObjectIdentifier(self).uintValue:\(ObjectIdentifier(self).uintValue)")
        print("ObjectIdentifier(self).hashValue:\(ObjectIdentifier(self).hashValue)")
        
        
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
//        NSNotificationCenter.defaultCenter().removeObserver(self)//这个方法可以移除 addObserver 监听的通知
        NSNotificationCenter.defaultCenter().removeObserver(self.observe)
    }
    
    
    func tap(tap:UITapGestureRecognizer){
        
        print("ObjectIdentifier(self).uintValue:\(ObjectIdentifier(self).uintValue)")
        print("ObjectIdentifier(self).hashValue:\(ObjectIdentifier(self).hashValue)")
        
        NSNotificationCenter.defaultCenter().postNotificationName("oneNotification", object: "liyang", userInfo: ["li":"yang"])
    
    }
    
    func noticeAcion(n:NSNotification){
        
    
        print("\(self)========我收到通知了:object:\(n.object),userInfo:\(n.userInfo)")
    }
    
    deinit{
        print("\(self) is die")
    }
}
