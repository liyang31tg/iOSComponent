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
