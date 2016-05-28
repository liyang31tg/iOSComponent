# iOSComponent一个喜欢插拔式开发的工程师
iOS项目积累的一些干货
###监听runloop的beforeWaiting和exit事件执行的任务（只有主线程才有意义）
```Swift
Transaction(target: self, selector: #selector(ChatVC.todo)).commit()
```


###上拉下拉刷新的集成（刷新View完全是插拔式，绝对的自由，koa组件的精髓）
```
self.contentTableView.refreshType = RefreshType.PullBoth.rawValue
        
self.contentTableView.refreshDelegate = self
        
self.contentTableView.currentRefreshDataState = RefreshDataType.PullDownRefreshing.rawValue //这样就可以触发自动刷新

说明：
enum RefreshType:Int {
    case PullNone   = 0 //默认状态，没有任何上啦下啦
    case PullDown   = 1 //只有上拉
    case PullUp     = 2 //只有下拉
    case PullBoth   = 3 //上拉下拉同时（暂时默认上拉，也必须拉动，以后有空扩展类似qq的滚动到底部自动刷新）
}

protocol RefreshProtocol { //暴露给外部接口实现
    func loadMoreData()
    func refreshData()
}

enum RefreshDataType:Int {//状态控制
    case RefreshNone        = 0 //默认状态
    
    case PullDownIng        = 1 //下拉中
    case PullDownOverZero   = 2 //下拉到零界点
    case PullDownRefreshing = 3 //下拉松开手势，刷新中
    case PullDownRefreshed  = 4 //下拉结束
    
    case PullUpIng          = 5 //上拉中
    case PullUpOverZero     = 6 //上拉到零界点
    case PullUpRefreshing   = 7 //上拉松开手势，刷新中
    case PullUpRefreshed    = 8 //上拉结束
}
```

###BannerView的延展，我绝对不仅仅是bannerView哦
```
   self.bottomBannerView.delegate = self
   self.bottomBannerView.bannerViewCell = UICollectionView.self //类似UITableView的注册
   
   说明：
   protocol BannerViewDelegate{
    func bannerView(bannerView:BannerView,cell:UIView,index:Int)
    func numberOfBannerView(bannerView:BannerView) -> Int
    optional func bannerView(bannerView:BannerView,didIndex:Int)
    //MARK:注册的时候回调
    optional func initBannerCellView(bannerView:BannerView,cellView:UIView)
    //MARK:是否响应轻击事件
    optional func isResponderTapAction(bannerView:BannerView) -> Bool
    //MARK:是否启动定时器
    optional func isResponderTimeAction(bannerView:BannerView) -> Bool
    //MARK:show which index
    optional func bannerView(bannerView:BannerView,showWhichIndex:Int)
    //MARK:是否循环滚动（主要针对新闻列表，手动滑动到最后一个，是否可循环）
    optional func bannerViewIsCycle(bannerView:BannerView) -> Bool
    //MARK:对于不循环的缓存初始化几个cell,默认初始化一个
    optional func bannerViewCacheCellCount(bannerView:BannerView) -> Int
}
```
