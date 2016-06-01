//
//  TipsVCList.swift
//  iOSComponent
//
//  Created by liyang on 16/5/24.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import PhotosUI
class TipsVCList: BasePlainTableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArray = [
            CTDomain(title: "评价五角星-当然可以随便换", storyBoard: "tips", storyBoardId: "CommentDegreeShowVCStoryBoardId"),
            CTDomain(title: "popView-仿微信左上角的", storyBoard: "tips", storyBoardId: "popViewControllerStoryBoardId"),
            CTDomain(title: "CAShapeLayer-实现饼状图", storyBoard: "tips", storyBoardId: "CAShapeLayerForPanakeStorboardID")]
    }
}
