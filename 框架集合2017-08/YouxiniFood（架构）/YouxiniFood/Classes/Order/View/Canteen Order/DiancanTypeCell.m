//
//  DiancanTypeCell.m
//  iFood
//
//  Created by 何青 on 2017/7/26.
//  Copyright © 2017年 何青. All rights reserved.
//

#import "DiancanTypeCell.h"

@implementation DiancanTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : BgColor;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
        self.iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconImgView.clipsToBounds = YES;
        [self.contentView addSubview:self.iconImgView];
        
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 55, 30)];
        self.nameLable.numberOfLines = 0;
        self.nameLable.font = [UIFont systemFontOfSize:14];
        self.nameLable.textColor = [UIColor grayColor];
        self.nameLable.text = @"小吃";
        [self.contentView addSubview:self.nameLable];
    }
    return self;
}


@end
