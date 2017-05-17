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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cttableviewCellidentifier")!
        cell.ctDomain = dataArray[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ctDomain = dataArray[indexPath.row]
        switch ctDomain.domainType {
        case CTDomain.DomainType.usePerformIdentifier:
            self.performSegue(withIdentifier: ctDomain.performIdentifier, sender: self)

        case CTDomain.DomainType.useStoryBoardId:
            let st = UIStoryboard(name: ctDomain.storyBoard, bundle: Bundle.main)
            let vc = st.instantiateViewController(withIdentifier: ctDomain.storyBoardId)
            vc.title = ctDomain.title
            self.navigationController?.pushViewController(vc, animated: true)
            
        case CTDomain.DomainType.useViewClass:
            let viewclass = ctDomain.viewClass
            let vc = (NSClassFromString(viewclass) as! UIViewController.Type).init()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if ctDomain.performIdentifier.isEmpty {
            
        } else {
        }
    }
}
