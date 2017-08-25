//
//  FlashSaleCell.m
//  YouxiniFood
//
//  Created by 何青 on 2017/8/7.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "FlashSaleCell.h"
#import "UIImageView+WebCache.h"

@interface FlashSaleCell()
{
    NSInteger  _row;
    UIView *titleView;
}
@end

@implementation FlashSaleCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = CardLayerCornerRadius;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.3;
        self.layer.masksToBounds = YES;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    titleView  = [[UIView alloc] initWithFrame:CGRectMake(15, 10, 18, 13)];
    titleView.backgroundColor = GoldColor;
    titleView.layer.cornerRadius = 3;
    titleView.clipsToBounds = YES;
    [self.contentView addSubview:titleView];
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(titleView.right + 5, 15, 70, 30)];
    _titleLable.text = @"限时抢购";
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
    
    _limitLable = [[UILabel alloc] initWithFrame:CGRectMake(_titleLable.right, 15, 60, 30)];
    _limitLable.text = @"距离结束";
    _limitLable.textColor = UIColorFromRGB(0x666666);
    if (IS_IPHONE5 || IS_IPHONE4S) {
        _limitLable.font = [UIFont systemFontOfSize:12];
        _limitLable.width = 50;
    }else if (IS_IPHONE6){
        _limitLable.font = [UIFont systemFontOfSize:13];
        _limitLable.width = 60;
    }else{
        _limitLable.font = [UIFont systemFontOfSize:14];
        _limitLable.width = 70;
    }
    [self.contentView addSubview:_limitLable];
    
    _hourLable = [[UILabel alloc] initWithFrame:CGRectMake(_limitLable.right, 15, 18, 20)];
    _hourLable.backgroundColor = [UIColor blackColor];
    _hourLable.textColor = [UIColor whiteColor];
    _hourLable.text = @"06";
    _hourLable.font = [UIFont systemFontOfSize:12];
    _hourLable.centerY = _titleLable.centerY;
    _hourLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_hourLable];

    _fuhao1 = [[UILabel alloc] initWithFrame:CGRectMake(_hourLable.right, 15, 5, 20)];
    _fuhao1.textColor = [UIColor darkGrayColor];
    _fuhao1.font = [UIFont systemFontOfSize:12];
    _fuhao1.text = @":";
    _fuhao1.textAlignment = NSTextAlignmentCenter;
    _fuhao1.centerY = _titleLable.centerY;
    [self.contentView addSubview:_fuhao1];

    _minLable = [[UILabel alloc] initWithFrame:CGRectMake(_fuhao1.right, 15, 18, 20)];
    _minLable.backgroundColor = [UIColor blackColor];
    _minLable.textColor = [UIColor whiteColor];
    _minLable.text = @"23";
    _minLable.font = [UIFont systemFontOfSize:12];
    _minLable.centerY = _titleLable.centerY;
    _minLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_minLable];
    
    _fuhao2 = [[UILabel alloc] initWithFrame:CGRectMake(_minLable.right, 15, 5, 20)];
    _fuhao2.textColor = [UIColor darkGrayColor];
    _fuhao2.font = [UIFont systemFontOfSize:12];
    _fuhao2.text = @":";
    _fuhao2.centerY = _titleLable.centerY;
    _fuhao2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_fuhao2];

    _secLable = [[UILabel alloc] initWithFrame:CGRectMake(_fuhao2.right, 15, 18, 20)];
    _secLable.backgroundColor = [UIColor blackColor];
    _secLable.textColor = [UIColor whiteColor];
    _secLable.font = [UIFont systemFontOfSize:12];
    _secLable.text = @"23";
    _secLable.textAlignment = NSTextAlignmentCenter;
    _secLable.centerY = _titleLable.centerY;
    [self.contentView addSubview:_secLable];

    _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, 15, 60, 30)];
    [_moreBtn setTitle:@"更多>>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_moreBtn addTarget:self action:@selector(clickMoreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreBtn];
    
    CGFloat w = (self.frame.size.width - 32)/3;
    CGFloat h = w*0.8;
    
    for (int i = 0; i<3; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8+(w+8)*i, _titleLable.bottom, w, h)];
        imgView.image = [UIImage imageNamed:@"food"];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.layer.masksToBounds  = YES;
        imgView.tag = 100+i;
        [self.contentView addSubview:imgView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageTap:)];
        [imgView addGestureRecognizer:tap];
        imgView.userInteractionEnabled = YES;
        
        UILabel *foodLable = [[UILabel alloc] initWithFrame:CGRectMake(8+(w+8)*i, imgView.bottom+2, w, 20)];
        foodLable.font = [UIFont systemFontOfSize:12];
        foodLable.textColor = UIColorFromRGB(0x666666);
        foodLable.text = @"重庆小面";
        foodLable.tag = 200+i;
        foodLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:foodLable];

        UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectMake(8+(w+8)*i, foodLable.bottom , w/2, 20)];
        priceLable.font = [UIFont systemFontOfSize:14];
        priceLable.textColor = UIColorFromRGB(0xff0000);
        priceLable.text = @"12";
        priceLable.tag = 300+i;
        priceLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:priceLable];
        
        UILabel *discountLable = [[UILabel alloc] initWithFrame:CGRectMake(8+w/2+(w+8)*i, foodLable.bottom, w/2, 20)];
        discountLable.font = [UIFont systemFontOfSize:10];
        discountLable.textColor = UIColorFromRGB(0x999999);
        discountLable.text = @"15";
        discountLable.tag = 400+i;
        discountLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:discountLable];
        
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"￥15" attributes:attribtDic];
        discountLable.attributedText = attribtStr;
        priceLable.text = @"￥12";
    }    
}

- (void)refreshUIWithImgArr:(NSArray *)imgArr title:(NSString *)title withFoodNameArr:(NSArray *)nameArr withPrice:(NSArray *)priceArr withDiscount:(NSArray *)discountArr withRow:(NSInteger)row{
    if (row == 2) {
        titleView.backgroundColor = UIColorFromRGB(0x000000);
    }else if (row == 3){
        titleView.backgroundColor = UIColorFromRGB(0xfe5b4f);
    }else if (row == 4){
        titleView.backgroundColor = UIColorFromRGB(0x00dbf4);
    }else if (row == 5){
        titleView.backgroundColor = UIColorFromRGB(0xf4a20d);
    }
    if ([title isEqualToString:@"限时抢购"]) {
        _limitLable.hidden = NO;
        _hourLable.hidden = NO;
        _minLable.hidden = NO;
        _secLable.hidden = NO;
        _fuhao1.hidden = NO;
        _fuhao2.hidden = NO;
    }else{
        _limitLable.hidden = YES;
        _hourLable.hidden = YES;
        _minLable.hidden = YES;
        _secLable.hidden = YES;
        _fuhao1.hidden = YES;
        _fuhao2.hidden = YES;
    }
    _row = row;
    _titleLable.text = title;
    
}

- (void)clickMoreBtnAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(clickMoreBtnWithRow:)]) {
        [self.delegate clickMoreBtnWithRow:_row];
    }
}

- (void)clickImageTap:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(clickImageViewWithIndex:WithRow:)]) {
        [self.delegate clickImageViewWithIndex:tap.view.tag-100 WithRow:_row];
    }
}

@end
