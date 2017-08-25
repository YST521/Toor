//
//  LimitCollectionViewCell.m
//  YouxiniFood
//
//  Created by 何青 on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "LimitCell.h"
#import "UIImageView+WebCache.h"
#define Color1 UIColorFromRGB(0x00dafa)
#define Color2 UIColorFromRGB(0xfec106)
#define Color3 UIColorFromRGB(0xd4ec40)

@implementation LimitCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = CardLayerCornerRadius;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.3;
    self.layer.masksToBounds = YES;
    if (IS_IPHONE5 || IS_IPHONE4S) {
        _titleLable.font = [UIFont systemFontOfSize:14];
        _limitTitle.font = [UIFont systemFontOfSize:12];
    }else if (IS_IPHONE6){
        _titleLable.font = [UIFont systemFontOfSize:15];
        _limitTitle.font = [UIFont systemFontOfSize:13];
    }else{
        _titleLable.font = [UIFont systemFontOfSize:16];
        _limitTitle.font = [UIFont systemFontOfSize:14];
    }
    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
//    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
//
//    [_foodImgView1 addGestureRecognizer:tap1];
//    [_foodImgView2 addGestureRecognizer:tap2];
//    [_foodImgView3 addGestureRecognizer:tap3];
}

- (void)refreshUI:(NSArray *)imgArr withContentArr:(NSArray *)contentArr withPriceArr:(NSArray *)priceArr withDiscount:(NSArray *)discountArr withTitle:(NSString *)title{
    if (_currentRow == 2) {
        _titleView.backgroundColor = [UIColor blackColor];
    }else if (_currentRow == 3){
        _titleView.backgroundColor = [UIColor redColor];
    }else if (_currentRow == 4){
        _titleView.backgroundColor = Color1;
    }else if (_currentRow == 5){
        _titleView.backgroundColor = Color2;
    }
    if ([title isEqualToString:@"限时抢购"]) {
        _limitTitle.hidden = NO;
        _hourLable.hidden = NO;
        _minLable.hidden = NO;
        _secLable.hidden = NO;
        _fuhaoLable1.hidden = NO;
        _fuhaoLable2.hidden = NO;
    }else{
        _limitTitle.hidden = YES;
        _hourLable.hidden = YES;
        _minLable.hidden = YES;
        _secLable.hidden = YES;
        _fuhaoLable1.hidden = YES;
        _fuhaoLable2.hidden = YES;
    }
    _titleLable.text = title;
    
}

- (void)clickTap:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(clickImageViewWithIndex:WithRow:)]) {
        [self.delegate clickImageViewWithIndex:tap.view.tag-200 WithRow:_currentRow];
    }
}

- (IBAction)btnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickMoreBtnWithRow:)]) {
        [self.delegate clickMoreBtnWithRow:_currentRow];
    }
    NSLog(@"点击了更多");
}
@end
