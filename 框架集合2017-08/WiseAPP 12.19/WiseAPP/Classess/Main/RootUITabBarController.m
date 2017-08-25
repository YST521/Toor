//
//  RootUITabBarController.m
//  WiseAPP
//
//  Created by app on 16/10/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "RootUITabBarController.h"
#import "RootUINavigationController.h"
#import "HomeViewController.h"
#import "AddressBookViewController.h"
#import "MessageViewController.h"
#import "UsereViewController.h"
#import "MyPageViewController.h"
#import "WiseTabbar.h"

@interface RootUITabBarController ()<UITabBarControllerDelegate>
@end

@implementation RootUITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addViewController];
}

-(void)addViewController{

    //[UITabBarItem appearance ]  拿到所有的item面试统一设置(UIappearance 宏 UI_APPEARANCE_SELECTOR )
    [[UITabBarItem appearance ] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor] } forState:(UIControlStateNormal)];
    
    [[UITabBarItem appearance ] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor] } forState:(UIControlStateSelected)];
    //初始化控制器
    HomeViewController*homeVC = [[HomeViewController alloc]init];
    AddressBookViewController*addressVC = [[AddressBookViewController alloc]init];
    UsereViewController*userVC = [[UsereViewController alloc]init];
    MyPageViewController*myVC = [[MyPageViewController alloc]init];
    MessageViewController*messageVC=[[MessageViewController alloc]init];
    
    
    [self addChildController:homeVC title:@"主页" imageName:@"tabar_home" selectedImageName:@"tabar-click_home" navVc:[RootUINavigationController class]];
    
    [self addChildController:addressVC title:@"通讯录" imageName:@"tabbar_addressBook" selectedImageName:@"tabbar_click_addressBook" navVc:[RootUINavigationController class]];
    
    [self addChildController:userVC title:@"应用" imageName:@"tabbar_application" selectedImageName:@"tabbar_click_application" navVc:[RootUINavigationController class]];
    
    
    [self addChildController:myVC title:@"我的" imageName:@"tabbar_my" selectedImageName:@"tabbar_click_mine" navVc:[RootUINavigationController class]];
    
    //再加一个item会被挤到屏幕右侧
    [self addChildController:messageVC title:@"消息" imageName:@"tabbar_message.png" selectedImageName:@"tabbar_message.png" navVc:[RootUINavigationController class]];
    [self setCustomtabbar];
    
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    //  设置tabbar
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    // 设置自定义的tabbar

}
- (void)setCustomtabbar{
    
   WiseTabbar *tabbar = [[WiseTabbar alloc]init];
    
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    [tabbar.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)centerBtnClick:(UIButton *)btn{
    
    NSLog(@"点击了中间");
    //设置tabbar点击 4号item
    [self setSelectedIndex:4];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName navVc:(Class)navVc
{
    
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置一下选中tabbar文字颜色
    
    [childController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }forState:UIControlStateSelected];
    
    RootUINavigationController * nav = [[navVc alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}


- (UIImage *)imageWithColor:(UIColor *)color{
    // 一个像素
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (self.selectedIndex == 4) {
        
    }
    return YES;
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
