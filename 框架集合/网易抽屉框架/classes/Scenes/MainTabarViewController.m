//
//  MainTabarViewController.m
//  MyTeamApp
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "MainTabarViewController.h"
#import "ProfileViewController.h"
#import "MessageViewController.h"
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "MoreViewController.h"
#import "UIFactory.h"
#import "UIViewExt.h"


@interface MainTabarViewController ()

@end

@implementation MainTabarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //隐藏tabBar
    [self.tabBar setHidden:YES];
    [self initViewController];
    [self InitTabarBar];
    

    
}
-(void)InitTabarBar
{
    //
    self.tabBarview =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
    self.tabBarview.backgroundColor =[UIColor cyanColor];
    
    [self.view addSubview:self.tabBarview];
    
    //tabBarItms image
    NSArray *backgroud = @[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    
    NSArray *heightBackground = @[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
    
    for (int i=0; i<backgroud.count; i++) {
        NSString *backImage = backgroud[i];
        NSString *heightImage = heightBackground[i];
        
        //        ThemeButton *button = [[ThemeButton alloc] initWithImage:backImage highlighted:heightImage];
        UIButton *button = [UIFactory createButton:backImage highlighted:heightImage];
        //85 处原来为64
        button.frame = CGRectMake((64-30)/2+(i*85), (49-30)/2, 30, 30);
        button.tag = i;
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarview addSubview:button];
    }
#warning  此处 _sliderView = [[UIFactory createImageView:@"tabbar_slider.png"] retain];
    _sliderView = (UIScrollView*)[UIFactory createImageView:@"tabbar_slider.png"] ;
    _sliderView.backgroundColor = [UIColor clearColor];
    _sliderView.frame = CGRectMake((64-15)/2, 5, 15, 44);
    [_tabBarview addSubview:_sliderView];
    
    
}
#pragma mark - actions
//tab 按钮的点击事件
- (void)selectedTab:(UIButton *)button {
    self.selectedIndex = button.tag;
    
    float x = button.left + (button.width-_sliderView.width)/2;
    [UIView animateWithDuration:0.2 animations:^{
        _sliderView.left = x;
    }];
}


//初始化子控制器
-(void)initViewController
{
    HomeViewController*home=[[HomeViewController alloc]init];
    MessageViewController*message=[[MessageViewController alloc]init];
    SearchViewController*dic=[[SearchViewController alloc]init];
    MoreViewController*more=[[MoreViewController alloc]init];
    ProfileViewController*pro=[[ProfileViewController alloc]init];
    
    NSArray *views = @[home,message,pro,dic,more];
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in views) {
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        
        [viewControllers addObject:nav];
        
    }
    
    //!!!!!!!!!!!!!!
    self.viewControllers = viewControllers;
    //self. viewControllers =viewControllers;
    
    
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
