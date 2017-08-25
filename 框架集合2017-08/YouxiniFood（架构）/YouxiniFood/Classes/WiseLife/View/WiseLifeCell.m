//
//  WiseLifeCell.m
//  YouxiniFood
//
//  Created by 何青 on 2017/7/27.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "WiseLifeCell.h"
#import "CustomBtn.h"



@implementation WiseLifeCell
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
    
    _titleView  = [[UIView alloc] initWithFrame:CGRectMake(15, 20, 18, 13)];
    _titleView.backgroundColor = _titleViewColor;
    _titleView.layer.cornerRadius = 3;
    _titleView.clipsToBounds = YES;
    [self.contentView addSubview:_titleView];
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(_titleView.right + 5, 15, self.frame.size.width -_titleView.width - 35, 30)];
    _titleLable.text = _title;
    NSArray *titArr = [_title componentsSeparatedByString:@"-"];
    NSArray * textArr = @[[NSString stringWithFormat:@"%@-",titArr[0]],titArr[1]];
    NSString * str = [NSString stringWithFormat:@"%@%@",textArr[0],textArr[1]];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    if (IS_IPHONE5 || IS_IPHONE4S) {
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} range:[str rangeOfString:textArr[0]]];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} range:[str rangeOfString:textArr[1]]];
    }else if(IS_IPHONE6_PLUS){
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:16]} range:[str rangeOfString:textArr[0]]];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} range:[str rangeOfString:textArr[1]]];
    }else{
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:15]} range:[str rangeOfString:textArr[0]]];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} range:[str rangeOfString:textArr[1]]];
    }
    _titleLable.attributedText =  attStr;
    
    [self.contentView addSubview:_titleLable];
    _titleView.centerY = _titleLable.centerY;
    
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
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
}

- (void)setIconArr:(NSArray *)iconArr{
    _iconArr = iconArr;
}

- (void)selectAction:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(wiseLifeDidSelectRow:andSection:)]) {
        [self.delegate wiseLifeDidSelectRow:sender.tag - 10 andSection:self.section];
    }
}

@end
