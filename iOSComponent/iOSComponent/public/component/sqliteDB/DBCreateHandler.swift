//
//  DBCreateHandler.swift
//  iOSComponent
//
//  Created by liyang on 16/5/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class DBCreateHandler{
   private var type    : String
   private var db      : Connection
    
    init(type:String,db:Connection){
        self.type   = type
        self.db     = db
    }
    
    func doCreate(){
        //建立表语句，不同类型
        switch self.type {
        case SqliteDB.DBProperty.type_public:
            self.createSettingsTable()
        case SqliteDB.DBProperty.type_private:
            break;
        default:
            break;
        }
    
    }
    
    private func createSettingsTable() {
        print("create settings table")
        var sql = "CREATE TABLE IF NOT EXISTS settings"
        sql += "(name TEXT UNIQUE PRIMARY KEY NOT NULL, "
        sql += "value TEXT)"
        do {
            try self.db.execute(sql)
        }
        catch {
        }
    }


}


