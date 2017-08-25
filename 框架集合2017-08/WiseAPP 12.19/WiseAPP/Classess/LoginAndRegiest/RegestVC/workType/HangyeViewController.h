//
//  HangyeViewController.h
//  WiseAPP
//
//  Created by app on 16/10/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^passvalue)(NSMutableArray *hangyeArray) ;
@interface HangyeViewController : BaseViewController

@property(nonatomic,strong)passvalue passHangyeBlock;
@end
