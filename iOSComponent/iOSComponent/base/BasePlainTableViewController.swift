//
//  BasePlainTableViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/5/11.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class BasePlainTableViewController: BaseViewController {
    var dataArray:[CTDomain] = []
}

extension BasePlainTableViewController :UITableViewDataSource,UITableViewDelegate {
    //MARK:TableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cttableviewCellidentifier")!
        cell.ctDomain = dataArray[indexPath.row]
        return cell
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
   
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let ctDomain = dataArray[indexPath.row]
        if ctDomain.performIdentifier.isEmpty {
            let st = UIStoryboard(name: ctDomain.storyBoard, bundle: NSBundle.mainBundle())
            let vc = st.instantiateViewControllerWithIdentifier(ctDomain.storyBoardId)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.performSegueWithIdentifier(ctDomain.performIdentifier, sender: self)
        }
    }
}