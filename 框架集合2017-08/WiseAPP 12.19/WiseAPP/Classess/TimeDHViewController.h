//
//  TimeDHViewController.h
//  SelectTime
//
//  Created by app on 16/11/15.
//  Copyright © 2016年 i. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passTimHMvalue <NSObject>

-(void)passTime:(NSString*)timeString type:(NSString*)typeString;

@end

@interface TimeDHViewController : UIViewController

@property(nonatomic,weak)id<passTimHMvalue>delegate;
@property(nonatomic,strong)NSString*timeTitle;
@property(nonatomic,strong)NSString* timeString;
@property(nonatomic,strong)NSString* uppagetype;
@end
