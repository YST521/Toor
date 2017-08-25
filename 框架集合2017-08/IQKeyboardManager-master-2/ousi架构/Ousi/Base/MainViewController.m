//
//  HYMainViewController.m
//  17zwd
//
//  Created by D_han on 13-11-2.
//  Copyright (c) 2013年 Hanyun. All rights reserved.
//

#import "MainViewController.h"
#import "HYBaseNavigationController.h"
#import "HYTabbarView.h"


@interface HYMainViewController ()
{
    UIButton *beforeB;
    NSArray *backImage;
    NSArray *backHlImage;
}
@end

@implementation HYMainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self _initView:nil];
    
    [self _initCustomTarBar];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)_initView:(Class)clsName
{
   
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.tabBarItem.title = @"数据分析";
    vc1.tabBarItem.image = [UIImage imageNamed:@"数据分析 (1)"];
    HYBaseNavigationController *nav1 = [[HYBaseNavigationController alloc] initWithRootViewController:vc1];
    vc1.view.backgroundColor =[UIColor redColor];

    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.tabBarItem.title = @"个人中心";
    vc2.tabBarItem.image = [UIImage imageNamed:@"个人中心"];
    HYBaseNavigationController *nav2 = [[HYBaseNavigationController alloc] initWithRootViewController:vc2];
      vc2.view.backgroundColor =[UIColor greenColor];

    self.selectedIndex = 0;
    self.viewControllers = @[nav1,nav2];
    
}

// 初始化自定义 TarBar
- (void)_initCustomTarBar
{
    self.tabBar.hidden = YES;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    
    self.isShowTabbar = YES;
    
    // 设置 TarBar 背景颜色
    _tabbarView = [[HYTabbarView alloc] initWithFrame:CGRectMake(0, SceneHeight - 44, SceneWidth, 44)]; // OK
//    _tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, SceneHeight - 65, SceneWidth, 65)];
//    _tabbarView.backgroundColor = UIColorFromRGB(0xf9f9f9);
    _tabbarView.backgroundColor = [UIColor colorWithWhite:0.99 alpha:1];
    

//    UIImage *I = [UIImage imageNamed:@"tabbar_bg"];
//    UIImageView *IV = [[UIImageView alloc] initWithImage:I];
//    [IV sizeToFit];
//    NSLog(@"%f,%f,%f,%f,", IV.left, IV.top, IV.width, IV.height);
//    IV.top = 0;
//    IV.alpha = 0.5;
//    [_tabbarView addSubview:IV];
    
    if ([[UIDevice currentDevice].systemVersion intValue] >= 7)
    {
//        _tabbarView.bottom += 20;
    }
    
    backImage = @[@"account_normal",
//                  @"tab-btn-encounter-n",
//                  @"tab-btn-reward-n",
                  @"home_highlight", @"tab-btn-my-n"];
    backHlImage = @[@"account_highlight",
//                    @"tab-btn-encounter-h",
//                    @"tab-btn-reward-h",
                    @"home_normal", @"tab-btn-my-h"];
    NSArray *titles = @[@"我的服务网", @"我的订单", @"个人中心"];
    
//    float center = (SceneWidth / 4.0f - 96.0f) / 2.0;
    float center = (SceneWidth / 3.0f - 106.0f) / 2.0;
    
    for (int i = 0; i < backImage.count; i++)
    {
        UIButton *button = [[UIButton alloc] init];

        button.frame = CGRectMake(center + i * SceneWidth / backHlImage.count, 0, SceneWidth/3.0, 44);
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(button.width/2-10, 5, 20, 20)];
        iv.image = [UIImage imageNamed:backImage[i]];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.tag = 288;
        [button addSubview:iv];
        
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, iv.bottom+3, button.width, 10)];
        l.textAlignment = NSTextAlignmentCenter;
        l.font = [UIFont systemFontOfSize:10];
        l.text = titles[i];
        l.tag = 299;
        l.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        [button addSubview:l];
        
        button.tag = i+500;
        
        button.exclusiveTouch = YES;
        
//        button.imageEdgeInsets = UIEdgeInsetsMake(2, 23, 15, 0);
//        button.titleEdgeInsets = UIEdgeInsetsMake(30, -18, 0, 0);
        
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:button];
        // 点击高亮
        button.showsTouchWhenHighlighted = YES;
        if (i == 0) {
            beforeB = button;
            button.selected = YES;
            iv.image = [UIImage imageNamed:backHlImage[i]];
            l.textColor = [UIColor darkGrayColor];
        }
    }
    
    [self.view addSubview:_tabbarView];
}

- (void)showTabbar:(BOOL)show
{
    if (self.isShowTabbar != show)
    {
        self.isShowTabbar = show;
//        [UIView animateWithDuration:1 animations:^{
//            if (show)
//            {
//                    _tabbarView.top = SceneHeight - _tabbarView.height;
//            }
//            else
//            {
//                _tabbarView.top = SceneHeight;
//            }
//        }];
        
//        [self _raiseView:show];
    
        _tabbarView.hidden = !show;
    }
}



- (void)selectedTab:(UIButton*)button
{
    // 移动选中的小灯
//    float x = button.left + (button.width - _tabbarSlider.width) / 2;
//    
//     if (((AppDelegate*)[UIApplication sharedApplication].delegate).isLogin && button.tag == 2)
//     {
//         
//     }
//    else
//    {
//        [UIView animateWithDuration:0.2f animations:^{
//            _tabbarSlider.left = x;
//        }];
//    }
//    
//    if (button.tag != 2)
//    {
//        self.selectedIndex = button.tag;
//    }
//    else
//    {
//        if (((HYAppDelegate*)[UIApplication sharedApplication].delegate).isLogin)
//        {
//            [self showImagesOnly];
//        }
//        else
//        {
//            self.selectedIndex = 2;
//        }
//    }
    
    if (button.tag == beforeB.tag) {
        return;
    }
    
    self.selectedIndex = button.tag-500;
//    beforeB.selected = NO;
    UIImageView *iv = (UIImageView*)[beforeB viewWithTag:288];
    iv.image = [UIImage imageNamed:backImage[beforeB.tag-500]];
    UILabel *l = (UILabel*)[beforeB viewWithTag:299];
    l.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    iv = (UIImageView*)[button viewWithTag:288];
    iv.image = [UIImage imageNamed:backHlImage[button.tag-500]];
    l = (UILabel*)[button viewWithTag:299];
    l.textColor = [UIColor darkGrayColor];
    
    button.selected = YES;
    beforeB = button;
    
    
}

- (void)selected:(int)index
{
//    if (index == beforeB.tag) {
//        return;
//    }
    
    //    beforeB.selected = NO;
    UIImageView *iv = (UIImageView*)[beforeB viewWithTag:288];
    iv.image = [UIImage imageNamed:backImage[beforeB.tag-500]];
    UILabel *l = (UILabel*)[beforeB viewWithTag:299];
    l.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    UIButton *button = (UIButton*)[_tabbarView viewWithTag:500+index];
    iv = (UIImageView*)[button viewWithTag:288];
    iv.image = [UIImage imageNamed:backHlImage[button.tag-500]];
    l = (UILabel*)[button viewWithTag:299];
    l.textColor = DefaultColor;
    
    button.selected = YES;
    beforeB = button;
    
    
    self.selectedIndex = index;
}



- (void)backHomeAction:(UIButton*)button
{
    self.selectedIndex = 0;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"__func = %s", __func__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers[self.selectedIndex] supportedInterfaceOrientations];
}

-(BOOL)shouldAutorotate
{
    return [self.viewControllers[self.selectedIndex] shouldAutorotate];
}


@end
