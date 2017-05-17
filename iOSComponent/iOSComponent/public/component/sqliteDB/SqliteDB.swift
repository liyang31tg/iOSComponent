//
//  SqliteDB.swift
//  iOSComponent
//
//  Created by liyang on 16/5/29.
//  Copyright © 2016年 liyang. All rights reserved.
//  业务场景主要是针对不同的用户（切换用户），不同的数据库

import Foundation
class SqliteDB{
     struct DBProperty {//类型和版本成对出现，并且可新增
        //可以直接针对版本进行修改(类型与版本根据业务需求来定)
        static let type_public          = "public"
        static let type_public_version  = 2
        
        static let type_private         = "private"
        static let type_private_version = 0
        
        //增加类型需要修改下面这个
        static let type_Dic = [type_public:type_public_version,type_private:type_private_version]
    }
    var dbName                          = ""
    var dbTpype                         = ""
    var db:Connection?
    init(dbName:String,dbType:String){
        self.dbName         = dbName
        self.dbTpype        = dbType
        
        let prePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        
        let dbPath = URLUtil.appendPath(prePath, path: "\(dbName).db")
        print("dbPath:\(dbPath)")
        do {
            self.db = try Connection(dbPath)
        }catch{
            self.db = nil
            print("数据库:\(dbName),创建失败")
        }
        
        
        if let db = self.db {
            let currentdbVersion = ConvertUtil.toInt(DBProperty.type_Dic[self.dbTpype])
            if db.dbVersion == 0 {//创建
                //创建操作
                DBCreateHandler(type: self.dbTpype, db: db).doCreate()
                self.db?.dbVersion = currentdbVersion
            }else{
                if db.dbVersion < currentdbVersion {
                    DBUpdateHandler(type: self.dbTpype, db: db, oldVersion: db.dbVersion).doUpdate()
                }
                //更新操作操作
                self.db?.dbVersion = currentdbVersion
            
            
            }
        
        }
        
        
        
        
    
        
        
    
    }
    
    deinit{
        self.db = nil
        print("sqlitedb is die")
    
    }

}

extension Connection {
    //将版本绑定到数据库里面(user_version)不可更改，这属于sql数据字典的，默认值是0
    public var dbVersion: Int {
        get { return Int(scalar("PRAGMA user_version") as! Int64) }
        set {
            do {
                try run("PRAGMA user_version = \(transcode(Int64(newValue)))")
            }catch {
                print("数据库版本设置失败")
            }
        }
    }
    
}
