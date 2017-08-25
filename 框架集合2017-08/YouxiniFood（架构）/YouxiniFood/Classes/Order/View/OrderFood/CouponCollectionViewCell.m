//
//  CouponCollectionViewCell.m
//  YouxiniFood
//
//  Created by 何青 on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "CouponCollectionViewCell.h"

@implementation CouponCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = CardLayerCornerRadius;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.3;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)refreshUI{
    
    for (UIView *v in self.contentView.subviews) {
        [v removeFromSuperview];
    }
    UIView *titleView  = [[UIView alloc] initWithFrame:CGRectMake(15, 10, 18, 13)];
    titleView.backgroundColor = GoldColor;
    titleView.layer.cornerRadius = 3;
    titleView.clipsToBounds = YES;
    [self.contentView addSubview:titleView];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(titleView.right + 5, 15, self.frame.size.width -titleView.width - 35, 30)];
    titleLable.text = @"优惠券";
    titleLable.textColor = UIColorFromRGB(0x999999);
    if (IS_IPHONE5 || IS_IPHONE4S) {
        titleLable.font = [UIFont systemFontOfSize:14];
    }else if (IS_IPHONE6){
        titleLable.font = [UIFont systemFontOfSize:15];
    }else{
        titleLable.font = [UIFont systemFontOfSize:16];
    }
    [self.contentView addSubview:titleLable];
    titleView.centerY = titleLable.centerY;
    
    NSArray *imgArr = @[@"bg_youhuijuan",@"bg_youhuijuan2"];
    CGFloat width  =  (self.frame.size.width-20)/2;
    for (int i = 0; i<2; i++) {
        UIImageView *imgView  = [[UIImageView alloc] initWithFrame:CGRectMake(5+(width+10)*i, titleLable.bottom+2,width, width*0.5)];
        imgView.image = [UIImage imageNamed:imgArr[i]];
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didclickImage:)];
        imgView.tag = 10+i;
        [imgView addGestureRecognizer:tap];
        [self.contentView addSubview:imgView];
    }
}

- (void)didclickImage:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(selectCouponWithIndex:)]) {
        [self.delegate selectCouponWithIndex:tap.view.tag - 10];
    }
}
@end
