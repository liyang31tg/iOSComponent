//
//  BaseGroupTableViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/4/15.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class BaseGroupTableViewController: BaseViewController {
     var dataArray:[[CTDomain]] = []
}

extension BaseGroupTableViewController :UITableViewDataSource,UITableViewDelegate {
    //MARK:TableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].count - 1//
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cttableviewCellidentifier")!
        cell.ctDomain = dataArray[indexPath.section][indexPath.row + 1]
        return cell
            
    }
        
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataArray[section][0].sectionTitle
    }
        
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
        
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
        
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return dataArray.count
    }
        
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let ctDomain = dataArray[indexPath.section][indexPath.row + 1]
        if ctDomain.performIdentifier.isEmpty {
            let st = UIStoryboard(name: ctDomain.storyBoard, bundle: NSBundle.mainBundle())
            let vc = st.instantiateViewControllerWithIdentifier(ctDomain.storyBoardId)
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            self.performSegueWithIdentifier(ctDomain.performIdentifier, sender: self)
        }
    }
}


extension UITableViewCell{
    var ctDomain: CTDomain {
        get{
            return CTDomain()
        }
        set{
            self.textLabel?.text = newValue.title
            self.accessoryType   = UITableViewCellAccessoryType.DisclosureIndicator
        }
    
    }
}
    
struct CTDomain {
    var sectionTitle        = ""
    var title               = ""
    var performIdentifier   = ""
    var storyBoard          = ""
    var storyBoardId        = ""
    init(){}
    init(sectionTitle: String){
        self.sectionTitle       = sectionTitle
    }
    init(title: String,performIdentifier: String){
        self.title              = title
        self.performIdentifier  = performIdentifier
    }
    
    init(title: String,storyBoard: String,storyBoardId: String){
        self.title              = title
        self.storyBoard         = storyBoard
        self.storyBoardId       = storyBoardId
    }
}

