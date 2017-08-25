//
//  AppDelegate.h
//  YouxiniFood
//
//  Created by youxin on 2017/7/26.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)MainTabBarController *mainTabBarVC;
@property (nonatomic, assign) NetworkStatus   netStatus;

@end

