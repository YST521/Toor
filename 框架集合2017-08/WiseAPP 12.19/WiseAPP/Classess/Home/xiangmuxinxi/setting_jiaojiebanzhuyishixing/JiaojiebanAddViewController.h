//
//  JiaojiebanAddViewController.h
//  WiseAPP
//
//  Created by app on 16/11/1.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaseViewController.h"
@class JiaojiebanModel;

@interface JiaojiebanAddViewController : BaseViewController
@property(nonatomic,assign)NSInteger  nextPageType;
@property(nonatomic,strong)JiaojiebanModel* model;
@end
