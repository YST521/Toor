//
//  PriceCollectionViewCell.m
//  YouxiniFood
//
//  Created by 何青 on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "PriceCollectionViewCell.h"

#define Color1 UIColorFromRGB(0x00dafa)

@implementation PriceCollectionViewCell

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

-(void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    for (UIView *v in self.contentView.subviews) {
        [v removeFromSuperview];
    }
    
    UIView *v   = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 18, 13)];
    v.backgroundColor = Color1;
    v.layer.cornerRadius = 3;
    v.clipsToBounds = YES;
    [self.contentView addSubview:v];
    
    UILabel *contentLable = [[UILabel alloc]initWithFrame:CGRectMake(v.right +5, 10, self.frame.size.width -v.width - 35, 30)];
    contentLable.text = @"充饭卡";
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
    
    CGFloat w = (self.frame.size.width - 60)/3;
    CGFloat h = w*0.9;
    CGFloat bottom = 0.0 ;
    for (int i = 0; i<_titleArr.count; i++) {
        UIButton *btn = [self createCustomBtnWithFrame:CGRectMake(20+(w+10)*(i%3), contentLable.bottom + 5 + (h+8)*(i/3),w, h) title:_titleArr[i] bgColor:[UIColor whiteColor] titleColor:[UIColor darkGrayColor] titleFont:16];
        bottom = btn.bottom;
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == _selectIndex) {
            btn.backgroundColor = UIColorFromRGB(0xfffd9e) ;
        }
        [self.contentView addSubview:btn];
    }
    
    _priceTf = [[UITextField alloc] initWithFrame:CGRectMake(20, bottom + 10, self.frame.size.width - 40, 40)];
    _priceTf.placeholder = @"请输入充值金额";
    _priceTf.keyboardType = UIKeyboardTypePhonePad;
    _priceTf.borderStyle = UITextBorderStyleRoundedRect;
    _priceTf.delegate = self;
    _priceTf.font = [UIFont systemFontOfSize:14];
    if (_selectIndex != _titleArr.count -1) {
        _priceTf.hidden = YES;
    }else{
        _priceTf.hidden = NO;
    }
    [self.contentView addSubview:_priceTf];
    
}

- (void)clickBtnAction:(UIButton *)sender{
    if (sender.tag == _titleArr.count-1) {
        [_priceTf becomeFirstResponder];
    }
    if ([self.delegate respondsToSelector:@selector(didSelectPriceWithIndex:)]) {
        [self.delegate didSelectPriceWithIndex:sender.tag - 10];
    }
}


- (UIButton *)createCustomBtnWithFrame:(CGRect)frame title:(NSString *)title bgColor:(UIColor *)bgColor titleColor:(UIColor *)titleColor titleFont:(NSInteger)font{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:bgColor];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.titleLabel.numberOfLines = 0;
    button.layer.cornerRadius = ButtonLayerCornerRadius;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.clipsToBounds = YES;
    return button;
}



@end
