//
//  KBTabbarController.m
//  KBTabbarController
//
//  Created by kangbing on 16/5/31.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import "KBTabbarController.h"
#import "KBTabbar.h"
#import "baibianjiajia-Swift.h"
#import "WenwenGuideView.h"
#import "BijiguideView.h"

#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

@interface KBTabbarController ()<UITabBarControllerDelegate>

@property(nonatomic,strong)KBTabbar *customBar;
@property(nonatomic,strong)UIColor *grassColor;

@end

@implementation KBTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BijiVC *hvc = [[BijiVC alloc] init];
    [self addChildController:hvc title:@"笔记" imageName:@"tabBar_note" selectedImageName:@"tabBar_noteSelected" navVc:[UINavigationController class]];
    wenwenVC *fvc = [[wenwenVC alloc] init];
    [self addChildController:fvc title:@"问问" imageName:@"tabBar_question" selectedImageName:@"tabBar_questionSelected" navVc:[UINavigationController class]];
    
    shifuVC *MoreVc = [[shifuVC alloc] init];
    [self addChildController:MoreVc title:@"师傅" imageName:@"tabBar_mastor" selectedImageName:@"tabBar_mastorSelected" navVc:[UINavigationController class]];
    
    JiazhuangGuanVC *svc = [[JiazhuangGuanVC alloc] init];
    [self addChildController:svc title:@"家装馆" imageName:@"tabBar_home" selectedImageName:@"tabBar_homeSelected" navVc:[UINavigationController class]];

    //再加一个item会被挤到屏幕右侧
    GameVC *avc = [[GameVC alloc] init];
    [self addChildController:avc title:@"U3D" imageName:@"" selectedImageName:@"" navVc:[UINavigationController class]];

    // 设置自定义的tabbar
    [self setCustomtabbar];
    self.selectedIndex = 4;
    self.customBar.centerBtn.selected = YES;
    self.delegate = self;
}

- (void)setCustomtabbar{

    self.customBar = [[KBTabbar alloc]init];
    
    [self setValue:self.customBar forKeyPath:@"tabBar"];

    [self.customBar.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)centerBtnClick:(UIButton *)btn{
    [self setSelectedIndex:4];
    self.customBar.centerBtn.selected = YES;
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.menuButton showAddBtn];
}


- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName navVc:(Class)navVc
{
    
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置一下选中tabbar文字颜色
    
    [childController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : COLOR_WITH_HEX(0xc6b378) }forState:UIControlStateSelected];
    [childController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : COLOR_WITH_HEX(0xc6b378) }forState:UIControlStateNormal];
//    UINavigationController* nav = [[navVc alloc] initWithRootViewController:childController];
    [self addChildViewController:childController];
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
   self.customBar.centerBtn.selected = NO;
    
    return YES;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.menuButton showAddBtn];
    BOOL firstLaunch1 = [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch1"];
    BOOL firstLaunch2 = [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch2"];
    if (firstLaunch1) {
        if (self.selectedIndex == 0) {
            BijiguideView *view = [[BijiguideView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            [appdelegate.window addSubview:view];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch1"];
        }
    }
    
    if (firstLaunch2) {
        if (self.selectedIndex == 1) {
            WenwenGuideView *view = [[WenwenGuideView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            [appdelegate.window addSubview:view];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch2"];
        }
    }

}

@end
