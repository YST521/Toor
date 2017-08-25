//
//  HYBaseNavigationController.m
//  17zwd
//
//  Created by D_han on 13-11-2.
//  Copyright (c) 2013年 Hanyun. All rights reserved.
//

#import "HYBaseNavigationController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface HYBaseNavigationController ()

@end

@implementation HYBaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarController.tabBar.hidden = YES;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.tabBarController.tabBar.hidden = YES;
//    self.hidesBottomBarWhenPushed = YES;
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = DefaultColor;

//    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SceneWidth, 20)];
//    statusView.backgroundColor = DefaultColor;
//    [self.view addSubview:statusView];    
    
//    self.navigationBar.clipsToBounds = YES;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    // 添加右滑手势
//    _swipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)];
//    _swipGesture.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.view addGestureRecognizer:_swipGesture];
}

- (UIViewController*)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

- (void)swipAction:(UISwipeGestureRecognizer*)gesture
{
    if (self.viewControllers.count > 1)
    {
        if (gesture.direction == UISwipeGestureRecognizerDirectionRight)
        {
            [self popViewControllerAnimated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

-(BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

@end
