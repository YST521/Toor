//
//  UserMessageImageCell.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/2.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "UserMessageImageCell.h"

@implementation UserMessageImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}


- (void)creatUI{
    

    
    self.userImageV = [[UIImageView alloc]init];
    self.userImageV.frame = CGRectMake(10, 0, 60, 60);
    self.userImageV.centerY =40;
    [self.userImageV xw_roundedCornerWithCornerRadii:CGSizeMake(30, 30) cornerColor:[UIColor whiteColor] corners:(UIRectCornerAllCorners) borderColor:[UIColor whiteColor] borderWidth:0.3];
    [self.contentView addSubview:self.userImageV];
    
    self.contentLa = [[UILabel alloc]init];
    self.contentLa.frame = CGRectMake(90, 30, SceneWidth-130, 20);
   
    self.contentLa.font =[UIFont systemFontOfSize:14];
    self.contentLa.textColor =[UIColor colorWithHexStringg:@"#999999"];
    self.contentLa.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview: self.contentLa];
    
    self.rightImageV = [[UIImageView alloc]init];
    self.rightImageV.frame = CGRectMake( SceneWidth-25, 32.5, 8, 15);
  
    self.rightImageV.image =[UIImage imageNamed:@"icon_xianghou"];
    [self.contentView addSubview:self.rightImageV];
    
    
    //
//    self.titleLa.text = @"工厂名称";
    self.contentLa.text = @"修改图像";
    //    self.rightImageV.backgroundColor =[UIColor greenColor];
    self.userImageV.image =[UIImage imageNamed:@"bg_touxiang"];
//    self.contentView.backgroundColor =[UIColor greenColor];
    
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
