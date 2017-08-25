//
//  LikeTableViewCell.m
//  YouxiniFood
//
//  Created by 何青 on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "LikeTableViewCell.h"

@implementation LikeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (IS_IPHONE5 || IS_IPHONE4S) {
        _titleLb.font = [UIFont systemFontOfSize:14];
        _addressLable.font = [UIFont systemFontOfSize:12];
    }else if (IS_IPHONE6){
        _titleLb.font = [UIFont systemFontOfSize:15];
        _addressLable.font = [UIFont systemFontOfSize:13];
    }else{
        _titleLb.font = [UIFont systemFontOfSize:16];
        _addressLable.font = [UIFont systemFontOfSize:14];
    }
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"￥50" attributes:attribtDic];
    _discountLable.attributedText = attribtStr;
    _priceLable.text = @"￥86.23";
}

- (void)setIsTwo:(BOOL)isTwo{
    _isTwo = isTwo;
    if (_isTwo) {
        _surplusLable.hidden = NO;
        _topHeight.constant = 25;
        _buyBtn.hidden = NO;
    }else{
        _surplusLable.hidden = YES;
        _topHeight.constant = 0;
        _buyBtn.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

- (IBAction)buyAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(LikeTableViewCelldidSelectClickBuyBtn:)]) {
        [self.delegate LikeTableViewCelldidSelectClickBuyBtn:_index];
    }
}
@end
