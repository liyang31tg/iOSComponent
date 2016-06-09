//
//  UseUISearchController.swift
//  iOSComponent
//
//  Created by liyang on 16/6/9.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation

class UseUISearchController: BaseViewController {
    @IBOutlet weak var contentTableView: UITableView!
    var dataArray: [String]     = []
    var filterArray: [String]   = []
    
    let searchVC = {()-> UISearchController in
        
        let v = UIViewController()
        v.view.backgroundColor = UIColor.whiteColor()
        let nav = UINavigationController(rootViewController: v)
        let tmp = UISearchController(searchResultsController: nav)
//        tmp.dimsBackgroundDuringPresentation    = false
    
        return tmp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...30 {
            dataArray.append("\(i)")
        }
        
        for i in 0...10{
            self.filterArray.append("filter:\(i)")
        }
//设置为true可以保证sear跳转的时候会更好
        self.definesPresentationContext = true
//        self.providesPresentationContextTransitionStyle =   true
        contentTableView.tableFooterView = UIView(frame: CGRectZero)
        self.configerUISearchBar()
    }
    
    
    func configerUISearchBar(){
    
        // 初始化
        // 添加到UITableView头部
        self.contentTableView.tableHeaderView   = searchVC.searchBar
        // 弹窗搜索栏，是否显示半透明背景层，默认是Yes
        let btn = UIButton(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64))
        btn.backgroundColor = UIColor.whiteColor()
        
        btn.addTarget(self, action: #selector(UseUISearchController.btnAction), forControlEvents: UIControlEvents.TouchUpInside)
        searchVC.searchResultsController?.view.addSubview(btn)
        
        // 设置代理
        searchVC.searchResultsUpdater = self
        searchVC.delegate = self
        
        // 搜索背景颜色设置
        searchVC.searchBar.barTintColor = UIColor(white: 0.95, alpha: 1)
        searchVC.searchBar.sizeToFit()
        
        // 去掉默认的黑色边框，hack方法，使它的颜色和背景色一致
        searchVC.searchBar.layer.borderWidth = 1;
        searchVC.searchBar.layer.borderColor = UIColor(white: 0.95, alpha: 1).CGColor

    }
    
    func btnAction(){
        print("btnAction")
        let presentVC = BaseViewController()
        presentVC.view.backgroundColor = UIColor.redColor()
        presentVC.title = "presentVC"
//        (self.searchVC.searchResultsController as! UINavigationController).pushViewController(presentVC, animated: true)
        self.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    deinit{
        
        self.searchVC.view.removeFromSuperview()
    
    }
    
    
    
}

extension UseUISearchController:UISearchControllerDelegate{
    func presentSearchController(searchController: UISearchController) {
        print("searchController:\(searchController)")
        
    }
}

extension UseUISearchController:UISearchResultsUpdating{
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        print(searchController.searchBar.text)
        
    }
}

extension UseUISearchController:UITableViewDataSource,UITableViewDelegate{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("self.searchVC.active:\(self.searchVC.active)")
        
        return self.dataArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cells", forIndexPath: indexPath)
        cell.textLabel?.text    = self.dataArray[indexPath.row]
        return cell
    }
    

    
    

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
  
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let presentVC = BaseViewController()
        presentVC.view.backgroundColor = UIColor.redColor()
        presentVC.title = "presentVC"
        
        self.navigationController?.pushViewController(presentVC, animated: true)
    }
}
