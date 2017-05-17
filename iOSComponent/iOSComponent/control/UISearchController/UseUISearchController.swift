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
        v.view.backgroundColor = UIColor.white
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
        contentTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.configerUISearchBar()
    }
    
    
    func configerUISearchBar(){
    
        // 初始化
        // 添加到UITableView头部
        self.contentTableView.tableHeaderView   = searchVC.searchBar
        // 弹窗搜索栏，是否显示半透明背景层，默认是Yes
        let btn = UIButton(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64))
        btn.backgroundColor = UIColor.white
        
        btn.addTarget(self, action: #selector(UseUISearchController.btnAction), for: UIControlEvents.touchUpInside)
        searchVC.searchResultsController?.view.addSubview(btn)
        
        // 设置代理
        searchVC.searchResultsUpdater = self
        searchVC.delegate = self
        
        // 搜索背景颜色设置
        searchVC.searchBar.barTintColor = UIColor(white: 0.95, alpha: 1)
        searchVC.searchBar.sizeToFit()
        
        // 去掉默认的黑色边框，hack方法，使它的颜色和背景色一致
        searchVC.searchBar.layer.borderWidth = 1;
        searchVC.searchBar.layer.borderColor = UIColor(white: 0.95, alpha: 1).cgColor

    }
    
    func btnAction(){
        print("btnAction")
        let presentVC = BaseViewController()
        presentVC.view.backgroundColor = UIColor.red
        presentVC.title = "presentVC"
//        (self.searchVC.searchResultsController as! UINavigationController).pushViewController(presentVC, animated: true)
        self.navigationController?.pushViewController(presentVC, animated: true)
    }
    
    deinit{
        
        self.searchVC.view.removeFromSuperview()
    
    }
    
    
    
}

extension UseUISearchController:UISearchControllerDelegate{
    func presentSearchController(_ searchController: UISearchController) {
        print("searchController:\(searchController)")
        
    }
}

extension UseUISearchController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
        
    }
}

extension UseUISearchController:UITableViewDataSource,UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("self.searchVC.active:\(self.searchVC.isActive)")
        
        return self.dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells", for: indexPath)
        cell.textLabel?.text    = self.dataArray[indexPath.row]
        return cell
    }
    

    
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let presentVC = BaseViewController()
        presentVC.view.backgroundColor = UIColor.red
        presentVC.title = "presentVC"
        
        self.navigationController?.pushViewController(presentVC, animated: true)
    }
}
