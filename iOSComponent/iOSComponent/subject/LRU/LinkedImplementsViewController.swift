//
//  LinkedImplementsViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/4/18.
//  Copyright © 2016年 liyang. All rights reserved.
//
// Swift - 链表结构实现LRU(least recently used) 算法
import Foundation
import UIKit

class LinkedImplementsViewController: UIViewController {
    let tmpCache = LURCache(cacheSize: 5)
    
    @IBOutlet weak var contentTextField: UITextField!
    
    var contentText:String {
        return contentTextField.text ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    @IBAction func addDoAction(sender: AnyObject) {
        
        tmpCache.put(contentText, anyO: contentText)
        var tmpNode = tmpCache.firstNode
        while tmpNode != nil {
            print("key:\(tmpNode?.key) data:\(tmpNode?.data)")
            tmpNode = tmpNode?.next
        }
        
    }
    
    @IBAction func resetAction(sender: AnyObject) {
        
    }
    
    
    @IBAction func queryAction(sender: AnyObject) {
        tmpCache.get(contentText)
        var tmpNode = tmpCache.firstNode
        while tmpNode != nil {
            print("key:\(tmpNode?.key) data:\(tmpNode?.data)")
            tmpNode = tmpNode?.next
        }
    }
    
    
    @IBAction func removeAction(sender: AnyObject) {
        tmpCache.remove(contentText)
        var tmpNode = tmpCache.firstNode
        while tmpNode != nil {
            print("key:\(tmpNode?.key) data:\(tmpNode?.data)")
            tmpNode = tmpNode?.next
        }
    }
    
    
    
}




class LURCache {
    class CacheNode {
        var prev: CacheNode?
        var next: CacheNode?
        var data: Any?
        var key     = ""
        deinit{
            print("\(self.key) is die")
        }
    }
    
    
    private var cacheSize                           = 0
    lazy private  var nodes :[String: CacheNode]     = [:]
    private var currentSize                         = 0
    private var firstNode: CacheNode?
    private var lastNode: CacheNode?
    
    init(cacheSize :Int){
        self.cacheSize = cacheSize
    }
    
    func get(key : String) -> Any? {
        let tmpNode = nodes[key]
        move2Head(tmpNode)
        return tmpNode?.data
    }
    
    func put(key: String , anyO: Any){
        var tmpNode = nodes[key]
        if nil == tmpNode {
            if currentSize >= cacheSize {
                removeLast()
            }
            currentSize += 1
            tmpNode = CacheNode()
        }
        tmpNode!.key = key
        tmpNode!.data = anyO
        
        move2Head(tmpNode!)
        nodes[key] = tmpNode
        
    
    }
    
    
    func remove(key : String) -> CacheNode?{
        let tmpNode = nodes[key]
        if let node = tmpNode {
            if node.prev != nil {
                node.prev?.next = node.next
            }
            if node.next != nil {
                node.next?.prev = node.prev
            }
            if lastNode === tmpNode{
                lastNode = tmpNode?.prev
            }
            
            if firstNode === tmpNode {
                firstNode = tmpNode?.next
            }
            nodes[key] = nil
            currentSize -= 1
        }
        return tmpNode
    }
    
    //清空缓存
     func clear(){
        firstNode = nil
        lastNode = nil
        nodes.removeAll()
    }
    
    
    private func removeLast(){
        if let lastn = lastNode {
            nodes[lastn.key] = nil//从缓存中删除
            currentSize -= 1
            if let lastPre = lastn.prev {
                    lastPre.next = nil
                }else{
                    firstNode = nil
                }
                lastNode = lastNode?.prev
            }
    }
    
    
    private func move2Head(node: CacheNode?){
        if let n = node {
            if node === firstNode{
                return
            }
            
            if n.prev != nil {
                n.prev?.next = n.next
            }
            
            if n.next != nil{
                n.next?.prev = n.prev
            }
            
            if lastNode === node{
                lastNode  = n.prev
            }
            
            if firstNode != nil {
                n.next = firstNode
                firstNode?.prev = n
            }
            
            firstNode = node
            
            n.prev = nil
            
            if lastNode == nil{
                lastNode  = firstNode
            }

        }
    }

}