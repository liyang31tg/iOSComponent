//
//  DBUpdateHandler.swift
//  iOSComponent
//
//  Created by liyang on 16/5/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class DBUpdateHandler {

    fileprivate var type        : String
    fileprivate var db          : Connection
    fileprivate var oldVersion  : Int
    
    init(type:String,db:Connection,oldVersion:Int){
        self.type       = type
        self.db         = db
        self.oldVersion = oldVersion
    }
    
    func doUpdate(){
        //更新语句
        switch self.type {
            case SqliteDB.DBProperty.type_public:
                if self.oldVersion == 1 {
                    self.updateV1ToV2()
                    return
                }
                if self.oldVersion == SqliteDB.DBProperty.type_Dic[self.type] { return }
            case SqliteDB.DBProperty.type_private:
                break;
            default:
                break;
        }
        
    }
    
    fileprivate func updateV1ToV2() {
        print("create settings table")
        var sql = "CREATE TABLE IF NOT EXISTS settings"
        sql += "(name TEXT UNIQUE PRIMARY KEY NOT NULL, "
        sql += "value TEXT)"
        do {
            try self.db.execute(sql)
        }
        catch {
            print("create settings table is fail")
        }
        self.oldVersion += 1
        self.doUpdate()
    }

}
