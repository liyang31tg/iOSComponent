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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].count - 1//
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cttableviewCellidentifier")!
        cell.ctDomain = dataArray[indexPath.section][indexPath.row + 1]
        return cell
            
    }
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataArray[section][0].sectionTitle
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
        
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
        
    func numberOfSections(in tableView: UITableView) -> Int{
        return dataArray.count
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ctDomain = dataArray[indexPath.section][indexPath.row + 1]
        if ctDomain.performIdentifier.isEmpty {
            let st = UIStoryboard(name: ctDomain.storyBoard, bundle: Bundle.main)
            let vc = st.instantiateViewController(withIdentifier: ctDomain.storyBoardId)
            vc.title = ctDomain.title
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            self.performSegue(withIdentifier: ctDomain.performIdentifier, sender: self)
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
            self.accessoryType   = UITableViewCellAccessoryType.disclosureIndicator
        }
    
    }
}
    
struct CTDomain {
    
    enum DomainType {
        case usePerformIdentifier //线跳转
        case useStoryBoardId      //通过storyboard
        case useViewClass          //通过class
    }
    var sectionTitle        = ""
    var title               = ""
    var performIdentifier   = ""
    var storyBoard          = ""
    var storyBoardId        = ""
    var viewClass           = ""
    var domainType          = DomainType.usePerformIdentifier
    init(){}
    init(sectionTitle: String){
        self.sectionTitle       = sectionTitle
    }
    init(title: String,performIdentifier: String){
        self.title              = title
        self.performIdentifier  = performIdentifier
        self.domainType         = DomainType.usePerformIdentifier
    }
    
    init(title: String,storyBoard: String,storyBoardId: String){
        self.title              = title
        self.storyBoard         = storyBoard
        self.storyBoardId       = storyBoardId
        self.domainType         = DomainType.useStoryBoardId
    }
    
    init(title: String,viewClass:String){
        self.title      = title
        self.viewClass  = viewClass
        self.domainType  = DomainType.useViewClass
    }
    
}

