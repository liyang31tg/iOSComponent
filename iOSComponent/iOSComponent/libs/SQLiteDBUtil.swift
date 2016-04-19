//
//  SQLiteDBUtil.swift
//  iOSComponent
//
//  Created by liyang on 16/4/19.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation

class SQLiteDBUtil {
    
    private var currentDb :     COpaquePointer = nil
    private var handleQueue     = dispatch_queue_create("sqlliteDb", nil) //数据库操作队列
    
    struct Static {
        static var instace: SQLiteDBUtil?   = nil
        static var tocken: dispatch_once_t  = 0
    }
    class func shareInstance() -> SQLiteDBUtil{
        dispatch_once(&Static.tocken) { () -> Void in
            Static.instace = SQLiteDBUtil()
        }
        return Static.instace!
    }
    
    class dbNode {
        var db: COpaquePointer = nil
        var createTime      = 0//创建时间
        var lastUseTime     = 0//最后次使用时间
        var liveTime        = 0//最后使用后可存活时间
    }
    
    private func openDB(dbPath: String){
        
      let openStatus =  sqlite3_open(dbPath.cStringUsingEncoding(NSUTF8StringEncoding)!, &currentDb)
        if openStatus != SQLITE_OK {
            print("open  fail")
            sqlite3_close(currentDb)
        }
    }
    
    
}
