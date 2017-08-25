//
//  TimeYYMMDDViewController.h
//  WiseAPP
//
//  Created by app on 16/11/16.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol passTimYMDHMvalue <NSObject>

-(void)passYMRTime:(NSString*)timeString type:(NSString*)typeString;

@end

@interface TimeYYMMDDViewController : UIViewController
@property(nonatomic,weak)id<passTimYMDHMvalue>delegate;
@property(nonatomic,strong)NSString*timeTitle;
@property(nonatomic,strong)NSString* timeString;
@property(nonatomic,strong)NSString* uppagetype;

@end
