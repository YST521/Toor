//
//  JINengViewController.h
//  WiseAPP
//
//  Created by app on 16/10/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaseViewController.h"
//第一步
typedef void(^passvalue)(NSMutableArray *passArray) ;
@interface JINengViewController : BaseViewController
//第二步
@property(nonatomic,strong)passvalue passBlock;
@end
