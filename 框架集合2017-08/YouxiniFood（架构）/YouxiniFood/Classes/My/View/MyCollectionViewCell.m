//
//  MyCollectionViewCell.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "CustomBtn.h"


@implementation MyCollectionViewCell{
//NSArray *_contentArr;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = CardLayerCornerRadius;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.3;
        self.clipsToBounds = YES;
       
    }
    return self;
}

- (void)setContentArr:(NSArray *)contentArr{

    _contentArr = contentArr;
        
        NSLog(@"****%@",contentArr);
    for (UIView *v in self.contentView.subviews) {
        [v removeFromSuperview];
    }
    
    _titleView  = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 15, 13)];
    _titleView.backgroundColor = self.squareColor;
//    if (_section ==0) {
//         _titleView.backgroundColor = [UIColor cyanColor];
//    }
//    if (_section ==1) {
//            _titleView.backgroundColor = [UIColor redColor];
//        }
//    if (_section ==2) {
//            _titleView.backgroundColor = [UIColor orangeColor];
//        }
//    if (_section ==3) {
//        _titleView.backgroundColor = [UIColor blackColor];
//    }

    _titleView.layer.cornerRadius = 3;
    _titleView.clipsToBounds = YES;
    [self.contentView addSubview:_titleView];
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, self.frame.size.width - 40, 30)];
    _titleLable.textColor = [UIColor grayColor];
    _titleLable.text = _title;
    _titleLable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLable];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, self.frame.size.width-20, 0.5)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    
    CGFloat width = (self.frame.size.width-20)/4;
    CGFloat height = width *0.8;
    for (int i =0 ; i<_contentArr.count; i++) {
        CustomBtn *btn = [CustomBtn buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10+width*(i%4), 45+height*(i/4), width-1, height-1);
        [btn setImage:[UIImage imageNamed:_iconArr[i]] forState:UIControlStateNormal];
        [btn setTitle:_contentArr[i] forState:UIControlStateNormal];
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
