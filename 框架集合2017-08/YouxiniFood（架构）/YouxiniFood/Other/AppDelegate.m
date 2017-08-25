//
//  AppDelegate.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/26.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h" //键盘回收
#import "LaunchViewController.h"
#import "LoginViewController.h"
#import "MainNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate{
    
    Reachability    *hostReach;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [APIHelper setService:nil];
    
    NSLog(@"---测试用-沙盒路径-----%@",NSHomeDirectory());
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor =[UIColor whiteColor];
    self.mainTabBarVC = [[MainTabBarController alloc] init];

    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[firstLaunchKey];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:firstLaunchKey];
    
    //根据版本更新引导图
    if (![currentVersion isEqualToString:sanboxVersion]) {
        LaunchViewController *lunchVC = [[LaunchViewController alloc]init];
        lunchVC.title = @"注册";
        self.window.rootViewController = lunchVC;
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:firstLaunchKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults] ;
        NSString *phoneStr = [userDefault objectForKey:@"iFoodName"];
        NSString *pswStr = [userDefault objectForKey:@"iFoodPassword"];
        if (phoneStr && pswStr) {
            //进入主页
            self.window.rootViewController = self.mainTabBarVC;
        }else{
            LoginViewController*loginVC = [[LoginViewController alloc]init];
            MainNavigationController*na=[[MainNavigationController alloc]initWithRootViewController:loginVC];
            self.window.rootViewController = na;
        }
    }
    
 
    [self.window makeKeyAndVisible];
    
    
    // 网络检测
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    hostReach = [Reachability reachabilityWithHostName:@"haosou.com"];
    
    [hostReach startNotifier];
    
    //键盘回收
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    return YES;
}

- (void)showLunch
{
  
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[firstLaunchKey];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:firstLaunchKey];

  //根据版本更新引导图
    if (![currentVersion isEqualToString:sanboxVersion]) {
       
        LaunchViewController *lunchVC = [[LaunchViewController alloc]init];
        lunchVC.title = @"注册";
        self.window.rootViewController = lunchVC;
        [self.window makeKeyAndVisible];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:firstLaunchKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Notification----------网络监测----------------

- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    _netStatus = [curReach currentReachabilityStatus];
    
    if (_netStatus == NotReachable) {
        
    } else if (_netStatus == ReachableViaWiFi) {
        
    } else {
        
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}



@end
