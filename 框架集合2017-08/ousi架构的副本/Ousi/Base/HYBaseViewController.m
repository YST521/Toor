//
//  HYBaseViewController.m
//  17zwd
//
//  Created by D_han on 13-11-2.
//  Copyright (c) 2013年 Hanyun. All rights reserved.
//

#import "HYBaseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "CommonLoadingView.h"
#import "TipView.h"

@interface HYBaseViewController ()
{
    CommonLoadingView *_comLoadView;
    
}
@end

@implementation HYBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.tabBarController.tabBar.hidden = YES;
//        self.hidesBottomBarWhenPushed = YES;
//        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//        self.navigationController.navigationBar.barTintColor = DefaultColor;
    }
    return self;
}


- (void)setTitle:(NSString *)title
{
//    [super setTitle:title];
    
    //    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    
    [titleLabel setText:title];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:19.0f]];
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if (self == [self.navigationController.viewControllers firstObject]) {
//        
//    }
    
//    self.tabBarController.tabBar.hidden = YES;
//    self.hidesBottomBarWhenPushed = YES;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
    
    NSArray *viewControllers = self.navigationController.viewControllers;

    /**
     * 自定义返回按钮
     */
    if (viewControllers.count > 1) {
//        UIButton *navigationLeftButton = [UIFactory createButtonWithImage:@"/nav_more_left.png"
//                                                             hightlighted:nil];
//        navigationLeftButton.frame = CGRectMake(0, 0, 37, 20);
//        navigationLeftButton.showsTouchWhenHighlighted = YES;
//        [navigationLeftButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//        
//        _backItem = [[UIBarButtonItem alloc] initWithCustomView:navigationLeftButton];
//        self.navigationItem.leftBarButtonItem = _backItem;
    }
    
    // 添加右滑手势
    _swipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    _swipGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:_swipGesture];
}


//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    if (self.navigationController.viewControllers.count > 1)
//    {
//        [self.appDelegate.mainVC showTabbar:NO];
//    }
//    else
//    {
//        [self.appDelegate.mainVC showTabbar:YES];
//    }
//}

- (void)showTipInfo:(NSString*)tipInfo
{
    if (! [tipInfo isKindOfClass:[NSString class]]) {
        return;
    }
    BOOL isExist = NO;
    for(UIView* v in self.view.subviews)
    {
        if([v isKindOfClass:[TipView class]])
        {
            TipView* tipView = (TipView*)v;
            [tipView showTipInfo:tipInfo];
            isExist = YES;
            break;
        }
    }
    if(!isExist)
    {
        TipView* tipView = [[TipView alloc] initWithTipInfo:tipInfo];
        [self.view addSubview:tipView];
    }
}


- (void)backAction:(id)button
{
    if (self.navigationController.viewControllers .count > 1)
        [self.navigationController popViewControllerAnimated:YES];
}

- (AppDelegate*)appDelegate
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

- (int)deviceVersion
{
    return [[UIDevice currentDevice].systemVersion intValue];
}



- (void)showLoadView
{
    if(_comLoadView != nil)
    {
        [_comLoadView removeFromSuperview];
        _comLoadView = nil;
    }
    
    CGRect rect = CGRectMake(0, 64, SceneWidth, (SceneHeight - 118));
    NSString* info = @"载入数据中...";
    _comLoadView = [[CommonLoadingView alloc] initWithInfo:rect info:info];
    [self.view addSubview:_comLoadView];
}

- (void)closeLoadView
{
    if(_comLoadView != nil)
    {
        [_comLoadView removeFromSuperview];
        _comLoadView = nil;
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
