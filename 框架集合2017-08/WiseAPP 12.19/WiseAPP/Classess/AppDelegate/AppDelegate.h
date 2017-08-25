//
//  AppDelegate.h
//  WQEWQ
//
//  Created by app on 16/10/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MainTabBarController.h"
#import <CoreLocation/CoreLocation.h>
#import "LoginViewController.h"
#import "RootUINavigationController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
//定位管理对象
@property(nonatomic,strong)CLLocationManager *locationManger;

/***  是否允许横屏的标记 */
@property (nonatomic,assign)BOOL allowRotation;

@end

