//
//  SingleSelectBtnView.swift
//  iOSComponent
//
//  Created by liyang on 16/6/3.
//  Copyright © 2016年 liyang. All rights reserved.
//  有个bug限制，因为用约束做的事先不知道其frame，所以统一宽度为UIScreenWidth

import Foundation
protocol SingleSelectBtnDelegate:NSObjectProtocol {
    func singleSelectBtnView(btnView:SingleSelectBtnView,clickIndex:Int)
}
class SingleSelectBtnView: UIView {
    //下面的都可setUpblock里面设置
    var selectView:UIView          = {
        let tmpView = UIView()
        tmpView.translatesAutoresizingMaskIntoConstraints   = false
        tmpView.backgroundColor                             = UIColor.blueColor()
        return tmpView
    }()
    var normalColor                                         = UIColor.whiteColor()
    var selectColor                                         = UIColor.blueColor()
    var normalFont                                          = UIFont.systemFontOfSize(12)
    var selectViewHeight:CGFloat                            = 2
    var itemSize                                            = CGSizeMake(70, 21)
    weak var delegate:SingleSelectBtnDelegate?                   = nil
    
    private var selectViewLeading:NSLayoutConstraint!
    private var offsetX:CGFloat!
    private var dataArrayCount:Int!
    private var singleBtns:[SinglSelectBtn]                 = []
    private var currentSelectTag                            = 0 //记录选中效果(0,1,2,3,4)//默认出初始化在0那里
    var dataArray:[SingleSelectBtnViewDomain]!{
        didSet{
            self.reloadData()
        }
    }
    
    func setUpBlock(s:((s:SingleSelectBtnView) -> Void)){
        s(s: self)
        if let _ = self.dataArray{
            self.reloadData()
        }
        
    }
    
    func reloadData(){
        self.clearSubViewAndConstraints()
        self.dataArrayCount     = self.dataArray.count
        self.singleBtns.removeAll()
        //#warning
        self.offsetX            = (ScreenWidth - (CGFloat(self.dataArrayCount) * self.itemSize.width)) / CGFloat(self.dataArrayCount + 1)
        var tmpBtn:SinglSelectBtn?
        for (index,d) in self.dataArray.enumerate() {
            let btn = SinglSelectBtn()
            btn.setTitleColor(self.normalColor, forState: UIControlState.Normal)
            btn.titleLabel?.font                = self.normalFont
            self.singleBtns.append(btn)
            btn.identifierTag   = index
            btn.setTitle(d.showText, forState: UIControlState.Normal)
            btn.addTarget(self, action: #selector(SingleSelectBtnView.selectBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(btn)
            var leading:NSLayoutConstraint!
            if  let t = tmpBtn {//说明是其他的
                
                leading = NSLayoutConstraint(item: btn, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: t, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: self.offsetX)
            }else{//说明是第一个
                btn.setTitleColor(self.selectColor, forState: UIControlState.Normal)
                leading = NSLayoutConstraint(item: btn, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: self.offsetX)
                
            }
            tmpBtn  = btn
            
            let centerY = NSLayoutConstraint(item: btn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
            
            let width = NSLayoutConstraint(item: btn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.itemSize.width)
            
            let height = NSLayoutConstraint(item: btn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.itemSize.height)
            
            self.addConstraints([leading,centerY,width,height])
        }
        
        //add selectViewConstraint
        self.addSubview(self.selectView)
        
        selectViewLeading = NSLayoutConstraint(item: self.selectView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: self.offsetX)
        
        let selectViewBottom = NSLayoutConstraint(item: self.selectView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        
        
        let selectViewWidth = NSLayoutConstraint(item: self.selectView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.itemSize.width)
        
        let selectViewHeight = NSLayoutConstraint(item: self.selectView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.selectViewHeight)
        
        self.addConstraints([selectViewLeading,selectViewBottom,selectViewWidth,selectViewHeight])
        
        
        
    }
    func selectBtnAction(selectbtn:SinglSelectBtn){
        let identifierTag = selectbtn.identifierTag
        guard self.currentSelectTag     != identifierTag else{return}
        self.showIndex(identifierTag)
        
        //这里触发一个block或者代理
        self.delegate?.singleSelectBtnView(self, clickIndex: identifierTag)
    }
    
    func showIndex(index:Int){
        guard index < self.dataArray.count else{ return }
        self.currentSelectTag           = index
        self.selectViewLeading.constant = CGFloat( index + 1 ) * self.offsetX + CGFloat(index) * self.itemSize.width
        self.resetBtn()
        UIView.animateWithDuration(0.3) {
            self.singleBtns[index].setTitleColor(self.selectColor, forState: UIControlState.Normal)
            self.layoutIfNeeded()
        }
        
        
        
        
    }
    
    private func resetBtn(){
        for b in self.singleBtns{
            b.setTitleColor(self.normalColor, forState: UIControlState.Normal)
        }
        
    }
    
    func setDataArray(datas:[SingleSelectBtnViewDomain]){
        self.dataArray = datas
        self.reloadData()
    }
    
    
    private func clearSubViewAndConstraints(){
        for v in self.subviews{
            v.removeFromSuperview()
        }
    }
}

struct SingleSelectBtnViewDomain {
    var showText    = ""
}

class SinglSelectBtn:UIButton{
    var identifierTag       = 0//作用类似tag，添加一个属性是便于扩展
    init(){
        super.init(frame: CGRectZero)
        self.translatesAutoresizingMaskIntoConstraints  = false//使用约束
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
