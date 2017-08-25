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
    titleLabel.textColor = NaTitleColor;
    
    [titleLabel setText:title];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        self.navigationController.navigationBar.hidden = NO;
    
  
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    if (self == [self.navigationController.viewControllers firstObject]) {
//        
//    }
    
//    self.tabBarController.tabBar.hidden = YES;
//    self.hidesBottomBarWhenPushed = YES;
    
    self.view.backgroundColor = BgColor;
    
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

- (UIButton *)createCustomBtnWithFrame:(CGRect)frame title:(NSString *)title bgColor:(UIColor *)bgColor titleColor:(UIColor *)titleColor titleFont:(NSInteger)font{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:bgColor];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.layer.cornerRadius = ButtonLayerCornerRadius;
    button.clipsToBounds = YES;
    return button;
}

- (UILabel *)createLableWithFrame:(CGRect)frame WithTitle:(NSString *)title WithFont:(NSInteger)font WithTextAlignment:(NSTextAlignment)textAlignment WithTitleColor:(UIColor*)titleColor withBgColor:(UIColor*)bgColor{
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    lable.backgroundColor = bgColor;
    lable.textAlignment = textAlignment;
    lable.font = [UIFont systemFontOfSize:font];
    lable.text = title;
    lable.numberOfLines = 0;
    lable.textColor = titleColor;
    return lable;
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

#pragma mark -alertView

- (void)alertViewTitle:(NSString*)alertTitle alretContent:(NSString*)content{
    
    UIAlertController *alertVC =[UIAlertController alertControllerWithTitle:@"提示" message:content preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *al =[UIAlertAction actionWithTitle:alertTitle style:(UIAlertActionStyleDefault) handler:nil];
    [alertVC addAction:al];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (NSString*)currentTimeyymmdd{
    
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    //    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    [formatter setDateFormat:@"YYYY-MM-dd" ];
    NSString *DateTime = [formatter stringFromDate:date];
    //    NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
    return DateTime;
}

- (NSString*)currentTimeYYMM{
    
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    //    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    [formatter setDateFormat:@"YYYY-MM" ];
    NSString *DateTime = [formatter stringFromDate:date];
    //    NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
    return DateTime;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
