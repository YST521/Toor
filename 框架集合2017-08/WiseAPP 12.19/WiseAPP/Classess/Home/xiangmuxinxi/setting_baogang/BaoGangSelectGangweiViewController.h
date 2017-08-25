//
//  BaoGangSelectGangweiViewController.h
//  WiseAPP
//
//  Created by app on 16/11/3.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaseViewController.h"


typedef void(^passPointID)(NSString* pointStr,NSString* pointName);

@interface BaoGangSelectGangweiViewController : BaseViewController

@property(nonatomic,strong)passPointID pointIdStr;
@end
