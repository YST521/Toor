//
//  MyadminCell.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyadminCell.h"

@implementation MyadminCell
  
  


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    
    return self;
}

-(void) creatUI{
    
    UIImage*bankIamge =[UIImage imageNamed:@"icon_yinghangkaguangli"];
     self.leftIamageV =[[UIImageView alloc]init];
     self.leftIamageV.frame = CGRectMake(20, 10, bankIamge.size.width, bankIamge.size.height);
//     self.leftIamageV.image =bankIamge;
    [self.contentView addSubview:self.leftIamageV];
    
    self.textContentLa =[[UILabel alloc]init];
    self.textContentLa.frame = CGRectMake(CGRectGetMaxX(self.leftIamageV.frame)+10, 10, 200, 20);
    [self.contentView addSubview:self.textContentLa];
    
    self.rightImageV =[[UIImageView alloc]init];
   self.rightImageV.frame = CGRectMake(SceneWidth-30, 10, 8, 15);
   self.rightImageV.image = [UIImage imageNamed:@"icon_xianghou"];
//    self.rightImageV.backgroundColor =[UIColor redColor];
    [self.contentView addSubview:self.rightImageV];


}
-(void)layoutSubviews{
    [super layoutSubviews];
    
//    self.rightImageV.frame = CGRectMake(SceneWidth-30, 10, 5, 5);
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
