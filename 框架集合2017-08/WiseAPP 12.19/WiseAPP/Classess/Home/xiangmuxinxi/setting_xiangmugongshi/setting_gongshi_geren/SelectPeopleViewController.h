//
//  SelectPeopleViewController.h
//  WiseAPP
//
//  Created by app on 16/12/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaseViewController.h"


@protocol passUserIdDelegate <NSObject>

-(void)passUserId:(NSString*)userId userName:(NSString*)username;

@end
@interface SelectPeopleViewController : BaseViewController

@property(nonatomic,weak)id<passUserIdDelegate>userIdDelegate;
@end
