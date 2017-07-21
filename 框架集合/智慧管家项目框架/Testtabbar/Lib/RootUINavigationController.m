//
//  RootUINavigationController.m
//  WiseAPP
//
//  Created by app on 16/10/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "RootUINavigationController.h"
#import "UIView+YSTExtension.h"

@interface RootUINavigationController ()

@end

@implementation RootUINavigationController

/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
    // 当导航栏用在XMGNavigationController中, appearance设置才会生效
    //    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"Rectangle 5"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    // 设置item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // UIControlStateNormal
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    // UIControlStateDisabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 如果滑动移除控制器的功能失效，清空代理(让导航控制器重新设置这个功能)
    
    self.interactivePopGestureRecognizer.delegate=nil;
    //UINavigationBar *bar = [UINavigationBar appearance];
   // [bar setBackgroundImage:[UIImage imageNamed:@"Rectangle 5"] forBarMetrics:UIBarMetricsDefault];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    //viewController.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:nil action:nil];
    
    if (self.childViewControllers.count > 0) {//如果push进来的不是第一个控制器
        
        UIButton*button=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setTitle:@"返回" forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:@"iconfont-fanhui copy.png"] forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:(UIControlStateHighlighted)];
        button.size =CGSizeMake(70, 30);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        [button sizeToFit];
        // 让按钮的内容往左边偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
    
}
//改变状态栏状态 (字变白)//需要放到viewController
//-(UIStatusBarStyle)preferredStatusBarStyle{
//
//
//    return  UIStatusBarStyleLightContent;
//}


- (void)back
{
    [self popViewControllerAnimated:YES];
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
