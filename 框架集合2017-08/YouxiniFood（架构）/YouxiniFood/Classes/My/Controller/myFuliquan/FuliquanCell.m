//
//  FuliquanCell.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "FuliquanCell.h"

@implementation FuliquanCell{

    UIView*bgView;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatViewUI];
    }
    return self;
    
}

-(void)creatViewUI{
    
    self.backgroundColor =[UIColor groupTableViewBackgroundColor];
    
    bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(20, 10, SceneWidth-40, 115);
    bgView.backgroundColor =[UIColor whiteColor];
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 0.3;
    bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:bgView];
    
    self.titleLa =[[UILabel alloc]init];
    self.titleLa.frame = bgView.bounds;
    [bgView addSubview:self.titleLa];
    
    //
    self.titleLa.textAlignment = NSTextAlignmentCenter;
    self.titleLa.text = @"66666666666666元";
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
