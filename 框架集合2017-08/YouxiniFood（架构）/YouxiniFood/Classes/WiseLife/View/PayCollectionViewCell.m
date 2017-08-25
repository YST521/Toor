//
//  PayCollectionViewCell.m
//  YouxiniFood
//
//  Created by 何青 on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "PayCollectionViewCell.h"
#define Color3 UIColorFromRGB(0xd4ec40)

@implementation PayCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = CardLayerCornerRadius;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.3;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)refreshUI{
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *v   = [[UIView alloc] initWithFrame:CGRectMake(15, 20, 18, 13)];
    v.backgroundColor = Color3;
    v.layer.cornerRadius = 3;
    v.clipsToBounds = YES;
    [self.contentView addSubview:v];
    
    UILabel *contentLable = [[UILabel alloc]initWithFrame:CGRectMake(v.right +5, 15, self.frame.size.width -v.width - 35, 30)];
    contentLable.text = @"支付方式";
    if (IS_IPHONE5 || IS_IPHONE4S) {
        contentLable.font = [UIFont systemFontOfSize:14];
    }else if (IS_IPHONE6){
        contentLable.font = [UIFont systemFontOfSize:15];
    }else{
        contentLable.font = [UIFont systemFontOfSize:16];
    }
    contentLable.textColor = [UIColor grayColor];
    [self.contentView addSubview:contentLable];
    v.centerY = contentLable.centerY;
    
    UILabel *line = [self createLableWithFrame:CGRectMake(15, contentLable.bottom+2, self.frame.size.width - 30,LineWidth) WithTitle:@"" WithFont:15 WithTextAlignment:NSTextAlignmentCenter WithTitleColor:[UIColor whiteColor] withBgColor:[UIColor groupTableViewBackgroundColor]];
    [self.contentView addSubview:line];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, line.bottom+8, 20, 20)];
    imgView.image = [UIImage imageNamed:@"bg_qiyebuzhu"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.clipsToBounds = YES;
    [self.contentView addSubview:imgView];
    UILabel *titleLable = [self createLableWithFrame:CGRectMake(imgView.right+5, line.bottom+8, 100, 20) WithTitle:@"企业补助支付" WithFont:14 WithTextAlignment:NSTextAlignmentLeft WithTitleColor:[UIColor grayColor] withBgColor:[UIColor whiteColor]];
    [self.contentView addSubview:titleLable];
    _bzBtn = [self createCustomBtnWithFrame:CGRectMake(self.frame.size.width - 40, line.bottom+8, 20, 20) title:@"" bgColor:[UIColor whiteColor] titleColor:[UIColor whiteColor] titleFont:12 withSelect:YES];
    _bzBtn.selected = _bzSelect;
    [self.contentView addSubview:_bzBtn];
    titleLable = [self createLableWithFrame:CGRectMake(_bzBtn.left-85, line.bottom+8, 80, 20) WithTitle:@"100元" WithFont:12 WithTextAlignment:NSTextAlignmentRight WithTitleColor:[UIColor grayColor] withBgColor:[UIColor whiteColor]];
    [self.contentView addSubview:titleLable];
    UIButton *bgBtn = [self createCustomBtnWithFrame:CGRectMake(0, line.bottom, self.frame.size.width, 36) title:@"" bgColor:[UIColor clearColor] titleColor:[UIColor clearColor] titleFont:10 withSelect:NO];
    bgBtn.tag = 100;
    [bgBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:bgBtn];
    
    line = [self createLableWithFrame:CGRectMake(15, titleLable.bottom+8, self.frame.size.width - 30,LineWidth) WithTitle:@"" WithFont:15 WithTextAlignment:NSTextAlignmentCenter WithTitleColor:[UIColor whiteColor] withBgColor:[UIColor groupTableViewBackgroundColor]];
    [self.contentView addSubview:line];
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, line.bottom+8, 20, 20)];
    imgView.image = [UIImage imageNamed:@"bg_yuer"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.clipsToBounds = YES;
    [self.contentView addSubview:imgView];
    titleLable = [self createLableWithFrame:CGRectMake(imgView.right+5, line.bottom+8, 100, 20) WithTitle:@"余额支付" WithFont:14 WithTextAlignment:NSTextAlignmentLeft WithTitleColor:[UIColor grayColor] withBgColor:[UIColor whiteColor]];
    [self.contentView addSubview:titleLable];
    _yueBtn = [self createCustomBtnWithFrame:CGRectMake(self.frame.size.width - 40, line.bottom+8, 20, 20) title:@"" bgColor:[UIColor whiteColor] titleColor:[UIColor whiteColor] titleFont:12 withSelect:YES];
    _yueBtn.selected = _yueSelect;
    [self.contentView addSubview:_yueBtn];
    titleLable = [self createLableWithFrame:CGRectMake(_yueBtn.left-85, line.bottom+8, 80, 20) WithTitle:@"50元" WithFont:12 WithTextAlignment:NSTextAlignmentRight WithTitleColor:[UIColor grayColor] withBgColor:[UIColor whiteColor]];
    [self.contentView addSubview:titleLable];
    bgBtn = [self createCustomBtnWithFrame:CGRectMake(0, line.bottom, self.frame.size.width, 36) title:@"" bgColor:[UIColor clearColor] titleColor:[UIColor clearColor] titleFont:10 withSelect:NO];
    bgBtn.tag = 101;
    [bgBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:bgBtn];
    
    line = [self createLableWithFrame:CGRectMake(15, titleLable.bottom+8, self.frame.size.width - 30,LineWidth) WithTitle:@"" WithFont:15 WithTextAlignment:NSTextAlignmentCenter WithTitleColor:[UIColor whiteColor] withBgColor:[UIColor groupTableViewBackgroundColor]];
    [self.contentView addSubview:line];
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, line.bottom+8, 20, 20)];
    imgView.image = [UIImage imageNamed:@"bg_weixin"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.clipsToBounds = YES;
    [self.contentView addSubview:imgView];
    titleLable = [self createLableWithFrame:CGRectMake(imgView.right+5, line.bottom+8, 100, 20) WithTitle:@"微信支付" WithFont:14 WithTextAlignment:NSTextAlignmentLeft WithTitleColor:[UIColor grayColor] withBgColor:[UIColor whiteColor]];
    [self.contentView addSubview:titleLable];
    _wechatBtn = [self createCustomBtnWithFrame:CGRectMake(self.frame.size.width - 40, line.bottom+8, 20, 20) title:@"" bgColor:[UIColor whiteColor] titleColor:[UIColor whiteColor] titleFont:12 withSelect:YES];
    _wechatBtn.selected = _wechatSelect;
    [self.contentView addSubview:_wechatBtn];
    bgBtn = [self createCustomBtnWithFrame:CGRectMake(0, line.bottom, self.frame.size.width, 36) title:@"" bgColor:[UIColor clearColor] titleColor:[UIColor clearColor] titleFont:10 withSelect:NO];
    bgBtn.tag = 102;
    [bgBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:bgBtn];
    
    line = [self createLableWithFrame:CGRectMake(15, titleLable.bottom+8, self.frame.size.width - 30,LineWidth) WithTitle:@"" WithFont:15 WithTextAlignment:NSTextAlignmentCenter WithTitleColor:[UIColor whiteColor] withBgColor:[UIColor groupTableViewBackgroundColor]];
    [self.contentView addSubview:line];
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, line.bottom+8, 20, 20)];
    imgView.image = [UIImage imageNamed:@"bg_zhifubao"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.clipsToBounds = YES;
    [self.contentView addSubview:imgView];
    titleLable = [self createLableWithFrame:CGRectMake(imgView.right+5, line.bottom+8,100, 20) WithTitle:@"支付宝支付" WithFont:14 WithTextAlignment:NSTextAlignmentLeft WithTitleColor:[UIColor grayColor] withBgColor:[UIColor whiteColor]];
    [self.contentView addSubview:titleLable];
    _alipayBtn = [self createCustomBtnWithFrame:CGRectMake(self.frame.size.width - 40, line.bottom+8, 20, 20) title:@"" bgColor:[UIColor whiteColor] titleColor:[UIColor whiteColor] titleFont:12 withSelect:YES];
    _alipayBtn.selected = _alipaySelect;
    [self.contentView addSubview:_alipayBtn];
    bgBtn = [self createCustomBtnWithFrame:CGRectMake(0, line.bottom, self.frame.size.width, 36) title:@"" bgColor:[UIColor clearColor] titleColor:[UIColor clearColor] titleFont:10 withSelect:NO];
    bgBtn.tag = 103;
    [bgBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:bgBtn];
    
}

- (void)clickBtnAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(paycellDidClickBtnWithIndex:)]) {
        [self.delegate paycellDidClickBtnWithIndex:sender.tag];
    }
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

- (UIButton *)createCustomBtnWithFrame:(CGRect)frame title:(NSString *)title bgColor:(UIColor *)bgColor titleColor:(UIColor *)titleColor titleFont:(NSInteger)font withSelect:(BOOL)isSelect{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:bgColor];
    if (isSelect) {
        [button setImage:[UIImage imageNamed:@"bg_weixuanzhong"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"bg_xuanzhong"] forState:UIControlStateSelected];
        [button setContentMode:UIViewContentModeScaleAspectFit];
    }
    return button;
}

@end
