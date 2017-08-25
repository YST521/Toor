//
//  WaitFoodCell.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/4.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "WaitFoodCell.h"

@implementation WaitFoodCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
        
    }
    return self;
    
}

-(void)creatUI{
    
    self.backgroundColor =[UIColor yellowColor];
    
    
    self.foodImageV =[[UIImageView alloc]init];
    self.foodImageV.frame = CGRectMake(10, 10, 40, 40);
    self.foodImageV.backgroundColor =[UIColor greenColor];
    [self.contentView addSubview:self.foodImageV];
    
    self.foodNameLa = [[UILabel alloc]init];
    self.foodNameLa.frame = CGRectMake(CGRectGetMaxX(self.foodImageV.frame)+10, 10, SceneWidth/3, 20);
    self.foodNameLa.textColor = [UIColor colorWithHexStringg:@"#333333"];
    self.foodNameLa.font =[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.foodNameLa];
    
    
    self.foodNumLa = [[UILabel alloc]init];
    self.foodNumLa.frame =CGRectMake(CGRectGetMaxX(self.foodImageV.frame)+10, CGRectGetMaxY(self.foodNameLa.frame)+2, SceneWidth/3, 20);
    self.foodNumLa.textColor = [UIColor colorWithHexStringg:@"#333333"];
    self.foodNumLa.font =[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.foodNumLa];
    
    
    self.foodPriceLa =[[UILabel alloc]init];
    self.foodPriceLa.frame = CGRectMake(SceneWidth-100-60, 10, 100, 20);
    self.foodPriceLa.font =[UIFont systemFontOfSize:14];
    self.foodPriceLa.textColor = [UIColor colorWithHexStringg:@"#fe5b4f"];
    [self.contentView addSubview:self.foodPriceLa];
    self.foodPriceLa.textAlignment = NSTextAlignmentRight;
    //    self.foodPriceLa.backgroundColor =[UIColor redColor];
    //
    self.foodNameLa.text = @"农家小炒肉";
    self.foodNumLa.text  = @"x 3";
    self.foodPriceLa.text = @"¥ 99";
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
