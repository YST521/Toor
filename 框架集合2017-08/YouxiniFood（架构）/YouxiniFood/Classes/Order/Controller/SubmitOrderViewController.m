//
//  SubmitOrderViewController.m
//  YouxiniFood
//
//  Created by 何青 on 2017/8/7.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "SubmitOrderViewController.h"
#import "PayOrderViewController.h"

@interface SubmitOrderViewController ()
{
    UILabel *_discountLable,*_PriceLable;
    UIButton *_commitBtn;
}
@end

@implementation SubmitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提交订单";
    [self initUI];
}

- (void)initUI{
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, SceneHeight- 55, SceneWidth, 0.5)];
    line.backgroundColor =  UIColorFromRGB(0x999999);
    [self.view addSubview:line];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, line.bottom, SceneWidth, 55)];
    bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:bgView];
    
    _discountLable = [self createLableWithFrame:CGRectMake(15, 0, 80, 54) WithTitle:@"已优惠3元" WithFont:14 WithTextAlignment:NSTextAlignmentCenter WithTitleColor:UIColorFromRGB(0x666666) withBgColor:[UIColor clearColor]];
    [bgView addSubview:_discountLable];
    
    _commitBtn = [self createCustomBtnWithFrame:CGRectMake(SceneWidth - 120, 0, 120, 54) title:@"提交订单" bgColor:GoldColor titleColor:[UIColor darkGrayColor] titleFont:15];
    [_commitBtn addTarget:self action:@selector(clickCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView  addSubview:_commitBtn];
    
    _PriceLable = [self createLableWithFrame:CGRectMake(_commitBtn.left - 100, 0, 100, 54) WithTitle:@"合计29元" WithFont:14 WithTextAlignment:NSTextAlignmentCenter WithTitleColor:UIColorFromRGB(0x666666) withBgColor:[UIColor clearColor]];
    [bgView addSubview:_PriceLable];
    
}

- (void)clickCommitBtn:(UIButton *)sender{
    PayOrderViewController *vc = [PayOrderViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
