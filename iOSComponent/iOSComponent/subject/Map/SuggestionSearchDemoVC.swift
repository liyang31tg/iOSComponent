//
//  SuggestionSearchDemoVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/19.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class SuggestionSearchDemoVC: BaseViewController {
    var dataArray:[[String]]            = []
    var sectionHeadString:[String]      = []
    @IBOutlet weak var onlineSearchBar: UISearchBar!
    @IBOutlet weak var contentTableView: UITableView!
    let suggestSearch = BMKSuggestionSearch()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "在线建议查询"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        suggestSearch.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        suggestSearch.delegate = nil
    }
}

extension SuggestionSearchDemoVC:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.keyWindow?.endEditing(true)
        let suggestOption = BMKSuggestionSearchOption()
        suggestOption.cityname = "成都"
        suggestOption.keyword = searchBar.text
        suggestSearch.suggestionSearch(suggestOption)
    }

}

extension SuggestionSearchDemoVC:BMKSuggestionSearchDelegate{

    func onGetSuggestionResult(_ searcher: BMKSuggestionSearch!, result: BMKSuggestionResult!, errorCode error: BMKSearchErrorCode) {
        self.sectionHeadString.removeAll()
        self.dataArray.removeAll()
        if result.keyList.count > 0{
            dataArray.append(result.keyList as! [String])
            sectionHeadString.append("keyList")
        }
        if result.cityList.count > 0{
            dataArray.append(result.cityList as! [String])
            sectionHeadString.append("cityList")
        }
        if result.districtList.count > 0{
            dataArray.append(result.districtList as! [String])
            sectionHeadString.append("districtList")
        }
        if result.poiIdList.count > 0{
            dataArray.append(result.poiIdList as! [String])
            sectionHeadString.append("poiIdList")
        }
        if result.ptList.count > 0{
            var ptValueString:[String] = []
            var location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            for a in result.ptList as! [NSValue] {
                a.getValue(&location)
                let tmpLocationStr = "latitude:\(location.latitude),longitude:\(location.longitude)"
                 ptValueString.append(tmpLocationStr)
            }
            dataArray.append(ptValueString)
            sectionHeadString.append("ptList")
        }
        self.contentTableView.reloadData()
        
    }
}

extension SuggestionSearchDemoVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionHeadString[section]
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = self.dataArray[indexPath.section][indexPath.row]
        return cell
    }



}
