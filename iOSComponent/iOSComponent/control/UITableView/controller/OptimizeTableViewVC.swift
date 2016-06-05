//
//  OptimizeTableViewVC.swift
//  iOSComponent
//
//  Created by liyang on 16/5/24.
//  Copyright © 2016年 liyang. All rights reserved.
//  优化cellHeight的思路，reload的时候异步计算cell（错误的思路绝对不要去监听主线程的Runloop，可以异步的绝对一步）

import Foundation
class OptimizeTableViewVC: BaseViewController,RefreshProtocol {
    
    @IBOutlet weak var contentTableView: OptimizeTableView!
    var dataArray: [[OptimizeTableViewCellDomainDelegate]]    = []//不管是一维、二维统一有二维处理
    override func viewDidLoad() {
        super.viewDidLoad()

        self.contentTableView.refreshType = RefreshType.PullBoth
        
        self.contentTableView.refreshDelegate = self
        
        self.contentTableView.currentRefreshDataState = RefreshDataType.PullDownRefreshing
        

        var part1: [OptimizeTableViewCellDomainDelegate]        = []
        for i in 0...1 {
            let oneline = "pre😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢阿克苏江东父老客机失联飞机了"
            var title = ""
            let to = arc4random() % 5 + 1
            for _ in 0..<to{
                title += oneline
            }
            part1.append(OptimizeTableViewCellDomain(index:"\(i)",title: title , image: "", cellIdentifier: "optimizeTableViewCellIdentifier"))
        }
        dataArray.append(part1)
        contentTableView.reloadData(self.dataArray)
    }
    
    func loadMoreData() {
        print("loadMoreData")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            sleep(3)
            dispatch_async(dispatch_get_main_queue(), {
                self.contentTableView.currentRefreshDataState = RefreshDataType.PullUpRefreshed
            })
        }
    }
    
    func refreshData() {
        print("refreshData")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            sleep(3)
            dispatch_async(dispatch_get_main_queue(), {
                self.contentTableView.currentRefreshDataState = RefreshDataType.PullDownRefreshed
            })
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(self.contentTableView.contentSize.height)
//        self.contentTableView.addRefreshFooterView()
//        
//        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        footerView.translatesAutoresizingMaskIntoConstraints    = false
//        footerView.backgroundColor = UIColor .brownColor()
//        
//        self.contentTableView.addSubview(footerView)
//        
//        
//        //addConstraint
//        let centerX =   NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: contentTableView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
//        let width = NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentTableView, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
//        let top =   NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentTableView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
//        let heightC =   NSLayoutConstraint(item: footerView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 60)
//        contentTableView.addConstraints([centerX,width,top,heightC])
//        
//        top.constant =  self.contentTableView.contentSize.height + 64
      
        
        
        


    }
    
//    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        print("observeValueForKeyPath")
//    }
    
    @IBAction func rightBtnAction(sender: AnyObject) {
        let a = self.dataArray[0].count
        for i in 0...10 {
            
            let oneline = "pre😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢😊😊😢⬇️😢阿克苏江东父老客机失联飞机了"
            var title = ""
            let to = arc4random() % 5 + 1
            for _ in 0..<to{
                title += oneline
            }
            self.dataArray[0].append(OptimizeTableViewCellDomain(index:"\(a + i)",title: title, image: "", cellIdentifier: "optimizeTableViewCellIdentifier"))
        }
        contentTableView.reloadData(self.dataArray)
       
    }
    
    
    
    deinit{
        print("\(self) is die")
    }
}


//MARK:TableViewDelegate
extension OptimizeTableViewVC:UITableViewDataSource,UITableViewDelegate{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellDomain = self.dataArray[indexPath.section][indexPath.row]
        return tableView.dequeueReusableCellWithIdentifier(cellDomain.cellIdentifier, forIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        var c = cell as! OptimizeTableViewCellDelegate
        c.cellDomain = self.dataArray[indexPath.section][indexPath.row]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return self.dataArray[indexPath.section][indexPath.row].caculateCellHeight()
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.dataArray[indexPath.section][indexPath.row].cellHeight ?? 50
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}


//为了能取消，放弃GCD
class OptimizeTableView: UITableView {
    let caculateQueue = NSOperationQueue()
    /*datas 这个数据源必须是二维数组,操作的数据源
     *
     *foreCaculate 预先需要先发送几个异步请求再刷新（这个参数的作用本来是用来控制异步资源（意思就是根据不同的页面，估算（不用准确，线程安全的）出一个界面会显示几个cell，先用全部CPU优先计算这几个cell的高）的（暂时还没想到好的思路））
     *
     ＊asynIndexPaths 对哪些indexPath进行异步计算（默认为空，就全部计算(只有没有才计算)）这个参数到底能是否能提高多少性能，暂时不清楚（没有时间测算）
     */
    func reloadData(datas:[[OptimizeTableViewCellDomainDelegate]],foreCaculate:Int = 0,asynIndexPaths:[NSIndexPath]? = nil) {
        var allCount            = 0 // 总的需要计算cell的height的个数
        for dataRow in datas{
            allCount += dataRow.count
        }
        var currentCalculate    = 0 //当前发送计算请求到队列里的个数
        caculateQueue.cancelAllOperations()
        if let aIndexPaths = asynIndexPaths {
            dispatch_async(dispatch_get_main_queue(), {
                self.reloadData()
            })
            for indexPth in aIndexPaths {
                let operation =  NSBlockOperation(block: {
                    datas[indexPth.section][indexPth.row].caculateCellHeight()
                })
                caculateQueue.addOperation(operation)
            }
        
        }else{
            for (i,dataRow) in datas.enumerate() {
                for (j,_) in dataRow.enumerate() {
                    if currentCalculate == foreCaculate{
                        dispatch_async(dispatch_get_main_queue(), {
                            self.reloadData()
                        })
                    }
                    let operation =  NSBlockOperation(block: {
                        datas[i][j].caculateCellHeight()
                    })
                    caculateQueue.addOperation(operation)
                    currentCalculate += 1
                }
            }
        
        }
    }
    deinit{
        caculateQueue.cancelAllOperations()
    }
 
}

protocol OptimizeTableViewCellDomainDelegate {
    var  cellIdentifier:String{get set}
    var  cellHeight:CGFloat?{get set}//这个标明的是（可读可写）、并非指定的存储属性还是计算属性
    func caculateCellHeight() -> CGFloat
}

protocol OptimizeTableViewCellDelegate {
    var cellDomain:OptimizeTableViewCellDomainDelegate{get set}
}

//MARK:注意保重线程安全
class OptimizeTableViewCellDomain : OptimizeTableViewCellDomainDelegate{
    private let a       = dispatch_semaphore_create(1)
    var index           = ""
    var title           = ""
    var image           = ""
    
    var cellIdentifier = ""
    var cellHeight: CGFloat?
    func caculateCellHeight() -> CGFloat {
        dispatch_semaphore_wait(a, DISPATCH_TIME_FOREVER)
        if self.cellHeight == nil {
            let attributeStr = NSAttributedString(string: self.title)
            self.cellHeight = CommonUtil.caculateDisplayHeight(attributeStr, width: ScreenWidth)
        }
        dispatch_semaphore_signal(a)
        return self.cellHeight!
    }
    
    init(index:String,title:String,image:String,cellIdentifier:String){
        self.index          = index
        self.title          = title
        self.image          = image
        self.cellIdentifier = cellIdentifier
    }
    init(){}
}



class OptimizeTableViewCell: UITableViewCell,OptimizeTableViewCellDelegate {
    
    @IBOutlet weak var coreTextView: CoreTextView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    var isAsynShow      = true;//是否异步绘制
    
    var cellDomain: OptimizeTableViewCellDomainDelegate{
        get {
            return OptimizeTableViewCellDomain()
        }
        set {
            let domain = newValue as! OptimizeTableViewCellDomain
            if isAsynShow {
                self.coreTextView.contentAttribute = NSAttributedString(string: (domain.index + " : " + domain.title))
                self.coreTextView.layer.setNeedsDisplay()
            }else{
                self.contentLabel.text = domain.title
            }
            self.coreTextView.hidden = !self.isAsynShow
            self.contentLabel.hidden = self.isAsynShow
            
        }
    }
    
}
