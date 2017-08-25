//
//  YezhushowTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/11/21.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "YezhushowTableViewCell.h"
#import "YezhuModel.h"

@implementation YezhushowTableViewCell
-(void)getValueModel:(YezhuModel *)model cellIndex:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
      self.leftLa.text =@"姓名";
       self.rightLa.text =model.name ;
    }else if (indexPath.row ==1){
        self.leftLa.text =@"性别";
        NSString*sex =[NSString stringWithFormat:@"%@",model.info[@"sex"]];
        if ([sex isEqualToString:@"1"]) {
            self.rightLa.text = @"男";
        } else {
           self.rightLa.text = @"女";
        }
        
        
    }else if (indexPath.row ==2){
      self.leftLa.text =@"年龄";
       self.rightLa.text =[NSString stringWithFormat:@"%@",model.info[@"age"]];
        
    }else if (indexPath.row ==3){
       self.leftLa.text =@"身高";
       self.rightLa.text =[NSString stringWithFormat:@"%@",model.info[@"height"]];
        
    }else if (indexPath.row ==4){
       self.leftLa.text =@"职务";
        self.rightLa.text =model.info[@"job"];
        
    }else if (indexPath.row ==5){
       self.leftLa.text =@"工作时间";
       self.rightLa.text =[NSString stringWithFormat:@"%@",model.info[@"workinghours"]];;
        
    }else if (indexPath.row ==6){
     self.leftLa.text =@"车牌号";
       self.rightLa.text =[NSString stringWithFormat:@"%@",model.info[@"numberplates"]];;
        
    }else if (indexPath.row ==7){
        self.leftLa.text =@"电话号码";
       self.rightLa.text =model.info[@"phone"];
        
    } else if (indexPath.row ==8){
     self.leftLa.text =@"其它";
       self.rightLa.text =model.info[@"remarks"];
        
    }


}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;

}
-(void)addView{

    self.leftLa = [[UILabel alloc]init];
    self.leftLa.frame=CGRectMake(10, STANDRD_H_20_y, 100, 20);
    //self.leftLa.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.leftLa];
    
    self.rightLa=[[UILabel alloc]init];
    self.rightLa.frame =CGRectMake(CGRectGetMaxX(self.leftLa.frame)+10, STANDRD_H_20_y, self.contentView.width-130, PROPORTION_HIGHT(20));
    //self.rightLa.backgroundColor=[UIColor greenColor];
    [self.contentView addSubview:self.rightLa];
    self.rightLa.textAlignment =NSTextAlignmentRight;
    self.leftLa.textColor =textCententColor;
    self.rightLa.textColor=textColorPlace;
    self.leftLa.font=[UIFont systemFontOfSize:16];
    self.rightLa.font=[UIFont systemFontOfSize:16];
    
//    self.rightImage =[[UIImageView alloc]init];
//    UIImage*image=[UIImage imageNamed:@"icon_right"];
//    self.rightImage.frame =CGRectMake(CGRectGetMaxX(self.rightLa.frame)+2, STANDRD_H_20_y, image.size.width, image.size.height);
//   // self.rightImage.backgroundColor=[UIColor redColor];
//    self.rightImage.image =image;
//    [self addSubview:self.rightImage];
    

}
-(void)layoutSubviews{
    [super layoutSubviews];

     self.leftLa.frame=CGRectMake(10, STANDRD_H_20_y, 80, 20);
    self.rightLa.frame =CGRectMake(SCREEN_WIDTH-130, STANDRD_H_20_y, 100, PROPORTION_HIGHT(20));
    //UIImage*image=[UIImage imageNamed:@"icon_right"];
    //self.rightImage.frame =CGRectMake(CGRectGetMaxX(self.rightLa.frame)+5, STANDRD_H_20_y, PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
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
