//
//  MyViewController.m
//  MyApp
//
//  Created by liaowentao on 17/3/29.
//  Copyright © 2017年 Haochuang. All rights reserved.
//

#import "MyViewController.h"
#import "LWTNavigationViewController.h"
#import "RootTabViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    self.view.backgroundColor = WHITCOLOR;
    
    NSLog(@"**%@", [[self getLastActivityController] class]);
    // Do any additional setup after loading the view.
    
//    [self getLastActivityControllerrPasstabbarVC:[RootTabViewController new] navc:[LWTNavigationViewController new]];
}


//-(UIViewController *)getLastActivityControllerrPasstabbarVC:(UITabBarController*)tabbarVC navc:(UINavigationController*)navc
//{
//    UIViewController *vController = [UIApplication sharedApplication].keyWindow.rootViewController;
//    if ([vController isKindOfClass:[tabbarVC class]]) {
//        RootTabViewController *tabVc = (UITabBarController *)vController;
//        LWTNavigationViewController *navVc = (LWTNavigationViewController *)tabVc.selectedViewController;
//        return navVc.visibleViewController;
//    }
//    
// 
//    return vController;
//}


// 获取在你眼前的控制器
-(UIViewController *)getLastActivityController
{
    UIViewController *vController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([vController isKindOfClass:[RootTabViewController class]]) {
      RootTabViewController *tabVc = (RootTabViewController *)vController;
       LWTNavigationViewController *navVc = (LWTNavigationViewController *)tabVc.selectedViewController;
        return navVc.visibleViewController;
    }
    
//    if ([vController isKindOfClass:[RootTabViewController class]]) {
//        RootTabViewController *navVc = (RootTabViewController *)vController;
//        return navVc.visibleViewController;
//    }
    return vController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
