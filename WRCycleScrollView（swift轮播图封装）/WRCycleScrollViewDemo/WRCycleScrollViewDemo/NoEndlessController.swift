//
//  ServerImgController.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/12.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRCycleScrollView

import UIKit

class NoEndlessController: UIViewController
{
    var cycleScrollView:WRCycleScrollView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "不无限轮播"
        
        let height = 520 * kScreenWidth / 1080.0
        let frame = CGRect(x: 0, y: 150, width: kScreenWidth, height: height)
        let serverImages = ["http://img0.imgtn.bdimg.com/it/u=2183547035,1684141703&fm=214&gp=0.jpg",
                            "http://pic20.nipic.com/20120330/2443543_101726406131_2.jpg",
                            "http://e.hiphotos.baidu.com/lvpics/h=800/sign=678b8cabccfc1e17e2bf81317a91f67c/279759ee3d6d55fb96d94d9b6e224f4a20a4dd6b.jpg",
                            "http://pic30.nipic.com/20130528/1427017_132336420181_2.jpg",
                            "http://pic72.nipic.com/file/20150710/20541695_100606251000_2.jpg"]
        cycleScrollView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: serverImages)
        view.addSubview(cycleScrollView!)
        cycleScrollView?.delegate = self
        cycleScrollView?.isEndlessScroll = false
    }
}

extension NoEndlessController: WRCycleScrollViewDelegate
{
    /// 点击图片回调
    func cycleScrollViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView)
    {
        print("点击了第\(index+1)个图片")
        if index == 1 {
            let  aa:UIViewController = UIViewController.init()
            self.navigationController?.pushViewController(aa, animated: true)
        }
        
    }
    /// 图片滚动回调
    func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView)
    {
        print("滚动到了第\(index+1)个图片")
    }
}

