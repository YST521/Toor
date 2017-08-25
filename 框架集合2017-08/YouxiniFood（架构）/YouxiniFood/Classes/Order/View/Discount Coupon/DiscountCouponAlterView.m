//
//  DiscountCouponAlterView.m
//  YouxiniFood
//
//  Created by 何青 on 2017/8/4.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "DiscountCouponAlterView.h"

@implementation DiscountCouponAlterView

- (instancetype _Nullable )initWithTitle:(nullable NSString *)title withContentText:(NSString *)content withCouponDic:(NSDictionary *)couponDic
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight)]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 100, SceneWidth-60, 100)];
        bgView.backgroundColor = [UIColor redColor];
        bgView.image = [UIImage imageNamed:@"bg_tanchuanbeijing"];
        bgView.contentMode = UIViewContentModeScaleAspectFill;
        bgView.layer.cornerRadius = 6;
        bgView.layer.masksToBounds = YES;
        bgView.userInteractionEnabled = YES;
        [self addSubview:bgView];
        
        UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, bgView.width, 40)];
        labTitle.textAlignment = NSTextAlignmentCenter;
        labTitle.text = title;
        labTitle.textColor = [UIColor blackColor];
        [bgView addSubview:labTitle];
        
        UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(bgView.width-40, 0, 40, 40)];
        [cancleBtn setImage:[UIImage imageNamed:@"icon_guanbi"] forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:cancleBtn];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_youhuijuan_xiao"]];
        imgView.frame = CGRectMake(10, labTitle.bottom , bgView.width - 20, (bgView.width - 20)*0.38);
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.layer.masksToBounds = YES;
        [bgView addSubview:imgView];
        
        UIImageView *redimg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 31, 35)];
        redimg.image = [UIImage imageNamed:@"red_youhui"];
        redimg.contentMode = UIViewContentModeScaleAspectFill;
        redimg.layer.masksToBounds = YES;
        [imgView addSubview:redimg];
        
        UILabel *countLable = [self createLableWithFrame:CGRectMake(15, 0, 31, 30) WithTitle:@"剩余99张" WithFont:10 WithTextAlignment:NSTextAlignmentCenter WithTitleColor:[UIColor whiteColor] withBgColor:[UIColor clearColor]];
        [imgView  addSubview:countLable];
        
        UILabel *discountLable = [self createLableWithFrame:CGRectMake(0, 0, imgView.width/3, imgView.height) WithTitle:@"9折" WithFont:25 WithTextAlignment:NSTextAlignmentCenter WithTitleColor:[UIColor blackColor] withBgColor:[UIColor clearColor]];
        [imgView addSubview:discountLable];
        
        UILabel *nameLable = [self createLableWithFrame:CGRectMake(discountLable.right, (imgView.height-50)/2, imgView.width/3*2, 30) WithTitle:@"点餐打折优惠券" WithFont:20 WithTextAlignment:NSTextAlignmentCenter WithTitleColor:[UIColor blackColor] withBgColor:[UIColor clearColor]];
        [imgView addSubview:nameLable];
        
        UILabel *dateLable = [self createLableWithFrame:CGRectMake(discountLable.right, nameLable.bottom, imgView.width/3*2,20) WithTitle:@"有效期至2017/08/28" WithFont:14 WithTextAlignment:NSTextAlignmentCenter WithTitleColor:[UIColor grayColor] withBgColor:[UIColor clearColor]];
        [imgView addSubview:dateLable];

        UILabel *contentLable = [[UILabel alloc] initWithFrame:CGRectMake(10, imgView.bottom+5, bgView.width- 20, 20)];
        contentLable.font = [UIFont systemFontOfSize:12];
        contentLable.textColor = [UIColor grayColor];
        contentLable.numberOfLines = 0;
        contentLable.layer.cornerRadius = ButtonLayerCornerRadius;
        contentLable.layer.masksToBounds = YES;
        contentLable.backgroundColor = [UIColor whiteColor];
        contentLable.attributedText = [self getAttributedStringWithString:content lineSpace:3];
        CGSize size = [contentLable.text sizeWithFont:contentLable.font constrainedToSize:CGSizeMake(bgView.width-20, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        contentLable.height = size.height+20;
        [bgView  addSubview:contentLable];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(10, contentLable.bottom +10, bgView.width - 20, 40);
        [btn setTitle:@"立即领取" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.cornerRadius =ButtonLayerCornerRadius;
        btn.layer.masksToBounds = YES;
        btn.tag = 1;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
        
        bgView.height = btn.bottom+20;
        bgView.top = SceneHeight/2 - bgView.height/2;

    }
    return self;

}

-(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}


- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.98, 0.98, 0.98)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    [self.layer addAnimation:animation forKey:nil];
}

- (void)cancel{
    [self cancleAction:nil];
    [self removeFromSuperview];
}

- (void)cancleAction:(UIButton*)btn
{
    if ([_delegate respondsToSelector:@selector(discountCouponAlterViewCancel:)]) {
        [_delegate discountCouponAlterViewCancel:self];
    }
    if ([_delegate respondsToSelector:@selector(discountCouponAlterView:clickedButtonAtIndex:)]) {
        [_delegate discountCouponAlterView:self clickedButtonAtIndex:0];
    }
}

- (void)clickBtnAction:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(discountCouponAlterView:clickedButtonAtIndex:)]) {
        [_delegate discountCouponAlterView:self clickedButtonAtIndex:sender.tag];
    }
    [self cancel];
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

@end
