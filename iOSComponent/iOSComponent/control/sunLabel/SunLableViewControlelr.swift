//
//  SunLableViewControlelr.swift
//  iOSComponent
//
//  Created by liyang on 16/4/22.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
let cellIdentifier = "aysnTextIdentifier"
class SunlableViewController: BaseViewController {
    
    let fps = SunFPSLabel(frame: CGRect(x: 0, y: 64, width: 60, height: 44))
    
    lazy var contentTableView: UITableView = { ()-> UITableView in
        var tmpTableView        = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: UITableViewStyle.Plain)
        tmpTableView.delegate   = self
        tmpTableView.dataSource = self
        tmpTableView.tableFooterView = UIView()
        tmpTableView.rowHeight       = 60
        tmpTableView.registerClass(AsynTextCell.self, forCellReuseIdentifier: cellIdentifier)
        return tmpTableView
    
    }()
    
    lazy var dataArray:[NSMutableAttributedString] = {() -> [NSMutableAttributedString] in
        var tempArray: [NSMutableAttributedString] = []
        for i in 0...300 {
            let s: NSString = "\(i)Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫"
            
            var as1 = NSMutableAttributedString(string: s as String)
            as1.beginEditing()
           let style = NSMutableParagraphStyle()
            style.lineSpacing = 10
            style.lineHeightMultiple = 1
            style.maximumLineHeight = 12
            style.minimumLineHeight = 12
            
            
            as1.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(10),NSStrokeWidthAttributeName : 1,NSStrokeColorAttributeName: UIColor.redColor(),NSParagraphStyleAttributeName: style], range: NSRange(location: 0, length: s.length))
            
            as1.endEditing()
            
          
            
            
          
          
            tempArray.append(as1)
        }
        return tempArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.contentTableView)
        self.view.addSubview(fps)
    }
    
   
}

extension SunlableViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AsynTextCell
        cell.isAsyn = true
        cell.contentS = self.dataArray[indexPath.row]
        return cell
    }
}


class AsynTextCell: UITableViewCell {
    
    
    let normalLabel = {()-> UILabel in
        let tmpLabel = UILabel(frame:CGRect(x: 0, y: 0, width: ScreenWidth, height: 60) )
        tmpLabel.numberOfLines = 0
        tmpLabel.font = UIFont.systemFontOfSize(10)
        
        return tmpLabel
    }()
    let asynLabel = {()-> SunLabel in
    
        let tmplabel = SunLabel(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
        tmplabel.backgroundColor = UIColor.whiteColor()
        return tmplabel
    }()
    
    var isAsyn          =   false {
        didSet{
            normalLabel.hidden  = isAsyn
            asynLabel.hidden    = !isAsyn
        }
    
    }
    var contentS = NSMutableAttributedString(string: "") {
        didSet{
            if self.isAsyn {
                asynLabel.attributedText    = contentS
            }else{
                normalLabel.attributedText  = contentS
            }
        
        }
    
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.contentView.addSubview(normalLabel)
        self.contentView.addSubview(asynLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
