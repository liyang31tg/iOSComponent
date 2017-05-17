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
        self.swichBtn.isOn = false
        
        self.title = "cornerRadius 正确的姿势"
    }
    
    
    @IBAction func swichtAcrion(_ sender: AnyObject) {
        
        self.isNormal = (sender as! UISwitch).isOn
        
    }
    
}

extension CornerRadiusViewController:UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 600
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("heightForRowAtIndexPath:\(indexPath.row)")
        return 44
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = isNormal ? "CornerCellNormolIdentifier" : "CornerCellidentifier"
        if isNormal {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CornerCellNormol
            cell.N1.text = "A1"
            cell.N2.text = "A2"
            cell.N3.text = "A3"
            cell.N4.text = "A4"
            cell.N5.text = "A5"
        

            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CornerCell
            cell.C1.text = "A1"
            cell.C2.text = "A2"
            cell.C3.text = "A3"
            cell.C4.text = "A4"
            cell.C5.text = "A5"
            return cell
        }
        
    }
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        print("willDisplayCell---------cell:\(cell)-------indexpath:\(indexPath)")
//    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


class CornerCell: UITableViewCell {
    
    @IBOutlet weak var C1: UILabel!
    
    @IBOutlet weak var C2: UILabel!
    
    @IBOutlet weak var C3: UILabel!
    
    @IBOutlet weak var C4: UILabel!
    
    @IBOutlet weak var C5: UILabel!
    
    @IBOutlet weak var cornerImageView: CornerImageView!
    
    @IBOutlet weak var cornerButton: CornerButton!
    
    @IBOutlet weak var testView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        testView.layer.cornerRadius = 8
        let CL1 = (C1.layer as! CornerRadiusLayer)
        let CL2 = (C2.layer as! CornerRadiusLayer)
        let CL3 = (C3.layer as! CornerRadiusLayer)
        let CL4 = (C4.layer as! CornerRadiusLayer)
        let CL5 = (C5.layer as! CornerRadiusLayer)
        
        let b6  = (cornerButton.layer as! CornerRadiusLayer)
        
        let b7 = (cornerImageView.layer as! CornerRadiusLayer)
        
        for m in [CL1,CL2,CL3,CL4,CL5] {
            m.sborderWidth  = 0.5
            
            m.scornerRadius = 8
            
            m.sborderColor  = UIColor.red
            
            
        
        }
        
        b6.sborderWidth  = 0.5
        
        b6.scornerRadius = 13
        
        b6.sborderColor  = UIColor.red
        
        b6.setNeedsDisplay()
        
        
        b7.sborderWidth  = 0.5
        
        b7.scornerRadius = 8
        
//        b7.sborderColor  = UIColor.redColor()
        
        b7.setNeedsDisplay()
        
        
        
       
    }
}

class testlabel: UILabel {
    
    override class var layerClass: AnyClass{
        
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
            m?.layer.borderWidth  = 0.5
            
            m?.layer.cornerRadius = 8
            
            m?.layer.borderColor  = UIColor.red.cgColor
            
            m?.layer.masksToBounds   = true
            
        }
    }
    
    
    
    
}

class CornerImageView: UIImageView {
    
    override class var layerClass: AnyClass{
        
        return CornerRadiusLayer.self
    }

}

class CornerButton: UIButton {
    override class var layerClass: AnyClass{
        
        return CornerRadiusLayer.self
    }

}




