//
//  MainTabBarController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/26.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "OrderViewController.h"
#import "WiseLifeViewController.h"
#import "MYViewController.h"
#import "TabBar.h"
#import "LoginViewController.h"
#import "AnimationManager.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>
@property(nonatomic,strong)NSArray *titlesArray;
@end

@implementation MainTabBarController



+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (NO) {
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    
    [self setupChildVc:[[OrderViewController alloc] init] title:@"订餐.吃饭" image:@"icon_dingcan" selectedImage:@"icon_dingcan_xuanzhong" withIndex:0];
    
    [self setupChildVc:[[WiseLifeViewController alloc] init] title:@"智慧生活" image:@"icon_zihuishenghuo" selectedImage:@"icon_zihuishenghuo_xuanzhong" withIndex:1];
    
    [self setupChildVc:[[MYViewController alloc] init] title:@"我的" image:@"icon_wode" selectedImage:@"icon_wode_xuanzhong" withIndex:2];
    // 更换tabBar
//   [self setValue:[[TabBar alloc] init] forKeyPath:@"tabBar"];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage withIndex:(NSInteger)index
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: NaTitleColor, UITextAttributeTextColor,nil] forState:UIControlStateSelected];
    vc.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *selectImage = [UIImage imageNamed:selectedImage];
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selectImage;
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:vc];
    nav.index = index;
    [self addChildViewController:nav];
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    return [[AnimationManager alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
