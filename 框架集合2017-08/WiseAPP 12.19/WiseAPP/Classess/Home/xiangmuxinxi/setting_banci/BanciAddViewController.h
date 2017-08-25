//
//  BanciAddViewController.h
//  WiseAPP
//
//  Created by app on 16/10/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaseViewController.h"
@class BanciModel;

@interface BanciAddViewController : BaseViewController

@property(nonatomic,strong)BanciModel* banciModel;
@property(nonatomic,assign)NSInteger editorType;//修改类型判断

@end
