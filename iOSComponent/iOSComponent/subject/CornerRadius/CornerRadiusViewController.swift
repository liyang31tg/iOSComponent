//
//  CornerRadiusViewController.swift
//  iOSComponent
//
//  Created by liyang on 16/4/24.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class CornerRadiusViewController: BaseViewController {
    var isNormal    = false{
        didSet{
            self.contentTableView.reloadData()
        }
    
    }
    
    @IBOutlet weak var swichBtn: UISwitch!
    @IBOutlet weak var contentTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.swichBtn.on = false
        
        self.title = "cornerRadius 正确的姿势"
    }
    
    
    @IBAction func swichtAcrion(sender: AnyObject) {
        
        self.isNormal = (sender as! UISwitch).on
        
    }
    
}

extension CornerRadiusViewController:UITableViewDelegate,UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 600
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print("heightForRowAtIndexPath:\(indexPath.row)")
        return 44
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = isNormal ? "CornerCellNormolIdentifier" : "CornerCellidentifier"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
//        print("cellForRowAtIndexPath---------cell:\(cell)-------indexpath:\(indexPath)")
        return cell
    }
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        print("willDisplayCell---------cell:\(cell)-------indexpath:\(indexPath)")
//    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}


class CornerCell: UITableViewCell {
    
    @IBOutlet weak var C1: UILabel!
    
    @IBOutlet weak var C2: UILabel!
    
    @IBOutlet weak var C3: UILabel!
    
    @IBOutlet weak var C4: UILabel!
    
    @IBOutlet weak var C5: UILabel!
    
    @IBOutlet weak var testView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        testView.layer.cornerRadius = 8
        let CL1 = (C1.layer as! CornerRadiusLayer)
        let CL2 = (C2.layer as! CornerRadiusLayer)
        let CL3 = (C3.layer as! CornerRadiusLayer)
        let CL4 = (C4.layer as! CornerRadiusLayer)
        let CL5 = (C5.layer as! CornerRadiusLayer)
        
        for m in [CL1,CL2,CL3,CL4,CL5] {
            m.sborderWidth  = 0.5
            
            m.scornerRadius = 8
            
            m.sborderColor  = UIColor.redColor()
            
            
        
        }
    }
}

class testlabel: UILabel {
    
    override class func layerClass()-> AnyClass{
        
        return CornerRadiusLayer.self
    }
}




class testView: UIView {
    
}


class CornerCellNormol: UITableViewCell {
    
    @IBOutlet weak var N1: UILabel!
    @IBOutlet weak var N2: UILabel!
    @IBOutlet weak var N3: UILabel!
    @IBOutlet weak var N4: UILabel!
    @IBOutlet weak var N5: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for m in [N1,N2,N3,N4,N5] {
            m.layer.borderWidth  = 0.5
            
            m.layer.cornerRadius = 8
            
            m.layer.borderColor  = UIColor.redColor().CGColor
            
            m.layer.masksToBounds   = true
            
        }
    }
    
    
}




