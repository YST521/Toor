//
//  MenuCollectionViewCell.m
//  YouxiniFood
//
//  Created by 何青 on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MenuCollectionViewCell.h"
#import "CustomBtn.h"

@implementation MenuCollectionViewCell
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

- (void)setContentArr:(NSArray *)contentArr{
    _contentArr = contentArr;
    for (UIView *v in self.contentView.subviews) {
        [v removeFromSuperview];
    }
    
   UIView *titleView  = [[UIView alloc] initWithFrame:CGRectMake(15, 10, 18, 13)];
    titleView.backgroundColor = _titleViewColor;
    titleView.layer.cornerRadius = 3;
    titleView.clipsToBounds = YES;
    [self.contentView addSubview:titleView];
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(titleView.right + 5, 15, self.frame.size.width -titleView.width - 35, 30)];
    _titleLable.text = @"饭堂菜品";
    _titleLable.textColor = UIColorFromRGB(0x999999);
    if (IS_IPHONE5 || IS_IPHONE4S) {
        _titleLable.font = [UIFont systemFontOfSize:14];
    }else if (IS_IPHONE6){
        _titleLable.font = [UIFont systemFontOfSize:15];
    }else{
        _titleLable.font = [UIFont systemFontOfSize:16];
    }
    [self.contentView addSubview:_titleLable];
    titleView.centerY = _titleLable.centerY;
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, _titleLable.bottom, self.frame.size.width-30, 0.5)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    
    CGFloat width = (self.frame.size.width-20)/4;
    CGFloat height = width *0.8;
    for (int i =0 ; i<contentArr.count; i++) {
        CustomBtn *btn = [CustomBtn buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10+width*(i%4), line.bottom+5+height*(i/4), width-1, height-5);
        [btn setImage:[UIImage imageNamed:_iconArr[i]] forState:UIControlStateNormal];
        [btn setTitle:contentArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x655a5a) forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
}

- (void)selectAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(selectMenuWithIndex:)]) {
        [self.delegate selectMenuWithIndex:sender.tag - 100];
    }
}

- (void)setIconArr:(NSArray *)iconArr{
    _iconArr = iconArr;
}
@end
