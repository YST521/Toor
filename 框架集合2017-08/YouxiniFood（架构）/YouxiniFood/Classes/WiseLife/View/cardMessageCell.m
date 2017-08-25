//
//  cardMessageCell.m
//  YouxiniFood
//
//  Created by 何青 on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "cardMessageCell.h"

@implementation cardMessageCell


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

- (void)refreshUIWithArr:(NSArray *)titleArr withMessageArr:(NSArray*)messageArr withTSArr:(NSArray *)tsArr btnSelect:(BOOL)select{
    for (UIView *v in self.contentView.subviews) {
        [v removeFromSuperview];
    }
    
    _accountLable = [self createLableWithFrame:CGRectMake(20, 15, 65, 30) WithTitle:messageArr[0] WithFont:14 WithTextAlignment:NSTextAlignmentLeft WithTitleColor:[UIColor grayColor] withBgColor:[UIColor whiteColor]];
    [self.contentView addSubview:_accountLable];
    
    _accountTf = [[UITextField alloc] initWithFrame:CGRectMake(_accountLable.right +2, 15, self.frame.size.width - 175, 30)];
    _accountTf.keyboardType = UIKeyboardTypePhonePad;
    _accountTf.font = [UIFont systemFontOfSize:14];
    _accountTf.delegate = self;
    _accountTf.placeholder = tsArr[0];
    [self.contentView addSubview:_accountTf];
    
    _typeBtn = [[UIButton alloc] initWithFrame:CGRectMake(_accountTf.right +2, 15, 60, 30)];
    _typeBtn.layer.cornerRadius = ButtonLayerCornerRadius;
    _typeBtn.clipsToBounds = YES;
    _typeBtn.layer.borderColor = [UIColor grayColor].CGColor;
    _typeBtn.layer.borderWidth = LineWidth;
    _typeBtn.selected =  select;
    [_typeBtn setTitle:@"工号充值" forState:UIControlStateNormal];
    [_typeBtn setTitle:@"手机充值" forState:UIControlStateSelected];
    [_typeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _typeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_typeBtn addTarget:self action:@selector(selectTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_typeBtn];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(20, _accountLable.bottom + 2, self.frame.size.width - 40, 0.3)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    
    
    _numLable = [self createLableWithFrame:CGRectMake(20, line.bottom + 5, 65, 30) WithTitle:messageArr[1] WithFont:14 WithTextAlignment:NSTextAlignmentLeft WithTitleColor:[UIColor grayColor] withBgColor:[UIColor whiteColor]];
    [self.contentView addSubview:_numLable];
    
    _numTf = [[UITextField alloc] initWithFrame:CGRectMake(_numLable.right +2, _numLable.top, self.frame.size.width - 105, 30)];
    _numTf.keyboardType = UIKeyboardTypePhonePad;
    _numTf.font = [UIFont systemFontOfSize:14];
    _numTf.delegate = self;
    _numTf.placeholder = tsArr[1];
    [self.contentView addSubview:_numTf];
    
    line = [[UILabel alloc] initWithFrame:CGRectMake(20, _numLable.bottom + 2, self.frame.size.width - 40, 0.3)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    
    _messageLable = [self createLableWithFrame:CGRectMake(20, line.bottom + 5, 65, 30) WithTitle:messageArr[2] WithFont:14 WithTextAlignment:NSTextAlignmentLeft WithTitleColor:[UIColor grayColor] withBgColor:[UIColor whiteColor]];
    [self.contentView addSubview:_messageLable];
    
    _messageTf = [[UITextField alloc] initWithFrame:CGRectMake(_messageLable.right +2, _messageLable.top, self.frame.size.width - 105, 30)];
    _messageTf.keyboardType = UIKeyboardTypePhonePad;
    _messageTf.font = [UIFont systemFontOfSize:14];
    _messageTf.delegate = self;
    _messageTf.placeholder = tsArr[2];
    [self.contentView addSubview:_messageTf];
    
    if (titleArr.count == 3) {
        _accountTf.text = titleArr[0];
        _numTf.text = titleArr[1];
        _messageTf.text = titleArr[2];
    }
    
}

- (void)selectTypeAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(typeBtnDidSelectWithtype:)]) {
        [self.delegate typeBtnDidSelectWithtype:sender.selected];
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

@end
