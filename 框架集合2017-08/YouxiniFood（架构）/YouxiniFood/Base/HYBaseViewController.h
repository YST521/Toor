//
//  HYBaseViewController.h
//  17zwd
//
//  Created by D_han on 13-11-2.
//  Copyright (c) 2013年 Hanyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface HYBaseViewController : UIViewController

@property (nonatomic, retain) UISwipeGestureRecognizer *swipGesture;

- (AppDelegate*)appDelegate;

- (int)deviceVersion;

- (void)backAction:(id)button;

@property (nonatomic, retain) UIBarButtonItem *backItem;


- (void)showLoadView;
- (void)closeLoadView;


- (NSString*)currentTimeYYMM;
- (NSString*)currentTimeyymmdd;
-(void)showTipInfo:(NSString*)tipInfo;
- (UIButton *)createCustomBtnWithFrame:(CGRect)frame title:(NSString *)title bgColor:(UIColor *)bgColor titleColor:(UIColor *)titleColor titleFont:(NSInteger)font;

-(UILabel *)createLableWithFrame:(CGRect)frame WithTitle:(NSString *)title WithFont:(NSInteger)font WithTextAlignment:(NSTextAlignment)textAlignment WithTitleColor:(UIColor*)titleColor withBgColor:(UIColor*)bgColor;

//弹框 alertTitle 确定btn  content 提示内容
- (void)alertViewTitle:(NSString*)alertTitle alretContent:(NSString*)content;
@end
