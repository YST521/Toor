//
//  PayLimitCell.m
//  YouxiniFood
//
//  Created by 何青 on 2017/8/7.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "PayLimitCell.h"

@interface PayLimitCell ()
{
    UILabel *hourLable,*minLable,*secLable;
}
@end

@implementation PayLimitCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = CardLayerCornerRadius;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.3;
        self.layer.masksToBounds = YES;
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.frame.size.width, 30)];
        lb.text = @"支付剩余时间";
        lb.font = [UIFont systemFontOfSize:18];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor blackColor];
        [self.contentView addSubview:lb];
        
        hourLable = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 95)/2, lb.bottom+5, 25, 30)];
        hourLable.backgroundColor = [UIColor blackColor];
        hourLable.textColor = [UIColor whiteColor];
        hourLable.text = @"06";
        hourLable.font = [UIFont systemFontOfSize:14];
        hourLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:hourLable];
        
        UILabel *fuhao  = [[UILabel alloc] initWithFrame:CGRectMake(hourLable.right, lb.bottom+5, 10, 30)];
        fuhao.textColor = [UIColor darkGrayColor];
        fuhao.font = [UIFont systemFontOfSize:14];
        fuhao.text = @":";
        fuhao.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:fuhao];
        
        minLable  = [[UILabel alloc] initWithFrame:CGRectMake(fuhao.right, lb.bottom+5, 25, 30)];
        minLable.backgroundColor = [UIColor blackColor];
        minLable.textColor = [UIColor whiteColor];
        minLable.text = @"23";
        minLable.font = [UIFont systemFontOfSize:14];
        minLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:minLable];
        
        fuhao = [[UILabel alloc] initWithFrame:CGRectMake(minLable.right, lb.bottom+5, 10, 30)];
        fuhao.textColor = [UIColor darkGrayColor];
        fuhao.font = [UIFont systemFontOfSize:14];
        fuhao.text = @":";
        fuhao.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:fuhao];
        
        secLable = [[UILabel alloc] initWithFrame:CGRectMake(fuhao.right, lb.bottom+5, 25, 30)];
        secLable.backgroundColor = [UIColor blackColor];
        secLable.textColor = [UIColor whiteColor];
        secLable.font = [UIFont systemFontOfSize:14];
        secLable.text = @"23";
        secLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:secLable];
        
    }
    return self;
}

@end
