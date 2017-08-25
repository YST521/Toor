//
//  MainTabBarController.m
//  WiseAPP
//
//  Created by app on 16/10/11.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "MainTabBarController.h"
#import "RootUINavigationController.h"
#import "HomeViewController.h"
#import "AddressBookViewController.h"
#import "MessageViewController.h"
#import "UsereViewController.h"
#import "MyPageViewController.h"
#import "LLTabBar.h"

@interface MainTabBarController ()
/**<>*/

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChindControllers];
    
}
-(void)addChindControllers{

    //初始化控制器
    HomeViewController*homeVC = [[HomeViewController alloc]init];
    AddressBookViewController*addressVC = [[AddressBookViewController alloc]init];
    UsereViewController*userVC = [[UsereViewController alloc]init];
    MyPageViewController*myVC = [[MyPageViewController alloc]init];
    MessageViewController*messageVC=[[MessageViewController alloc]init];
  //添加导航控制器
    RootUINavigationController*homeNA = [[RootUINavigationController alloc]initWithRootViewController:homeVC];
    RootUINavigationController*addressNA = [[RootUINavigationController alloc]initWithRootViewController:addressVC];
    RootUINavigationController*userNA = [[RootUINavigationController alloc]initWithRootViewController:userVC];
    RootUINavigationController*myNA = [[RootUINavigationController alloc]initWithRootViewController:myVC];
    RootUINavigationController*messageNA = [[RootUINavigationController alloc]initWithRootViewController:messageVC];
    
     self.viewControllers = @[homeNA, addressNA, messageNA,userNA, myNA];

    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:self.tabBar.bounds];
    //tabBar.backgroundColor = [UIColor redColor];
    //LLTabBarItemRise 中间凸起type
    tabBar.tabBarItemAttributes = @[@{kLLTabBarItemAttributeTitle : @"首页", kLLTabBarItemAttributeNormalImageName : @"tabar_home", kLLTabBarItemAttributeSelectedImageName : @"tabar-click_home", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"通讯录", kLLTabBarItemAttributeNormalImageName : @"tabbar_addressBook", kLLTabBarItemAttributeSelectedImageName : @"tabbar_click_addressBook", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"消息", kLLTabBarItemAttributeNormalImageName : @"tabbar-icon_message", kLLTabBarItemAttributeSelectedImageName : @"tabbar_message_click", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"应用", kLLTabBarItemAttributeNormalImageName : @"tabbar_application", kLLTabBarItemAttributeSelectedImageName : @"tabbar_click_application", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"我的", kLLTabBarItemAttributeNormalImageName : @"tabbar_my", kLLTabBarItemAttributeSelectedImageName : @"tabbar_click_mine", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)}];
    //tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];


}
#pragma mark - LLTabBarDelegate

//- (void)tabBarDidSelectedRiseButton {
//    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
//    UIViewController *viewController = tabBarController.selectedViewController;
//    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
//                                                             delegate:self
//                                                    cancelButtonTitle:@"取消"
//                                               destructiveButtonTitle:nil
//                                                    otherButtonTitles:@"拍照", @"从相册选取", @"淘宝一键转卖", nil];
//    [actionSheet showInView:viewController.view];
//}

#pragma mark - UIActionSheetDelegate

//- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
//    NSLog(@"buttonIndex = %ld", buttonIndex);
//}


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
