//
//  BanhuiAddViewController.h
//  WiseAPP
//
//  Created by app on 16/11/4.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaseViewController.h"

@class BanhuiModel;
@interface BanhuiAddViewController : BaseViewController

@property(nonatomic,strong)BanhuiModel* model;
@property(nonatomic,strong)NSString* banhuiID;
@property(nonatomic,assign)NSInteger upPageType;

@end
