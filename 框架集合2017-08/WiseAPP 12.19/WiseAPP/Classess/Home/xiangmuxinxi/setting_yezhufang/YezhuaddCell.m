//
//  YezhuaddCell.m
//  WiseAPP
//
//  Created by yst911521 on 2016/12/10.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "YezhuaddCell.h"
#import "YezhuModel.h"
@implementation YezhuaddCell
-(void)getValueModel:(YezhuModel *)model cellIndex:(NSIndexPath *)indexPath UPpage:(NSInteger)nextPageType dataArray:(NSMutableArray*)dataArray{
    if ([self.rightLa.text isEqualToString:@"去设置"]) {
       self.rightLa.textColor =textBlueColor;
    } else {
      self.rightLa.textColor =textColorPlace;
    }
    
    if (nextPageType ==1) {
        
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
           self.rightLa.text =[NSString stringWithFormat:@"%@",model.info[@"height"]];;
            
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
           self.leftLa.text =@"手机号码";
          self.rightLa.text =[NSString stringWithFormat:@"%@",model.info[@"phone"]];;
            
        }else if (indexPath.row ==8){
           self.leftLa.text =@"其它";
          self.rightLa.text =model.info[@"remarks"];
            
        }
        
    }else{
        //        cell.leftLa.textColor =textCententColor;
        //         cell.rightLa.textColor = textBlueColor;
       self.leftLa.text = dataArray[indexPath.row];
    }


}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI{
    
    self.leftLa =[[UILabel alloc]init];
    self.leftLa.frame = CGRectMake(10, self.contentView.height/4, 80, 20);
    [self.contentView addSubview:self.leftLa];
    self.leftLa.textColor=textColorPlace;
    
    self.rightLa=[[UILabel alloc]init];
    self.rightLa.frame = CGRectMake(self.contentView.width-100, self.leftLa.y, 60, 20);
    self.rightLa.text = @"去设置";
    [self.contentView addSubview:self.rightLa];
    
    self.rightImage =[UIButton buttonWithType:(UIButtonTypeCustom)];
   self.rightImage .frame = CGRectMake(self.contentView.width-30, PROPORTION_HIGHT(15), PROPORTION_WIDTH(8), PROPORTION_HIGHT(15));
    [self.rightImage setBackgroundImage:[UIImage imageNamed:@"icon_right"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:self.rightImage];
    
    
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.leftLa.frame = CGRectMake(10, self.contentView.height/4, SCREEN_WIDTH/2, 20);
    self.rightLa.frame = CGRectMake(self.contentView.width-100, self.leftLa.y, 60, 20);
    
    
    self.rightImage .frame = CGRectMake(self.contentView.width-30, PROPORTION_HIGHT(15), PROPORTION_WIDTH(8), PROPORTION_HIGHT(15));
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
