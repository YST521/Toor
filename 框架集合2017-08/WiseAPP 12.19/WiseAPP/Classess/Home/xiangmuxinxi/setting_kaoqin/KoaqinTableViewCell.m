//
//  KoaqinTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/12/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "KoaqinTableViewCell.h"
#import "KaoqinModel.h"
@implementation KoaqinTableViewCell
//-(void)getValueModel:(KaoqinModel *)model cellIndex:(NSIndexPath *)indexPath UPpage:(NSInteger)nextPageType dataArray:(NSMutableArray*)dataArray{
//
//    self.leftLa.text =
//    dataArray[indexPath.row];
//    
//    self.rightBgLa.textColor =textCententColor;
//    //if (nextPageType==1) {
//        
//    
//    if (indexPath.row ==0) {
//      self.rightBgLa.text = model.area;
//        NSLog(@"*******%@", self.rightLa.text);
//    }else if (indexPath.row ==1){
//       self.rightBgLa.text = model.address;
//    
//    }else if (indexPath.row ==2){
//        NSString*atted =[NSString stringWithFormat:@"%d",model.attendance];
//        self.self.rightBgLa.text =atted;
//    }else if (indexPath.row ==3){
//        NSString*atted =[NSString stringWithFormat:@"%d",model.attendancescope];
//       self.rightBgLa.text =atted;
//    }else if (indexPath.row ==4){
//        NSString*atted =[NSString stringWithFormat:@"%d",model.contracttime];
//       self.rightBgLa.text =atted;
//    }else if (indexPath.row==5){
//        
//        NSString*atted =[NSString stringWithFormat:@"%d",model.fingerprinttime];
//        self.rightBgLa.text =atted;
//    }
////    }else{
//       // self.leftLa.text =dataArray[indexPath.row];
//   // }
//    
//
//}
//-(void)getValueModel:(KaoqinModel *)model cellIndex:(NSIndexPath *)indexPath UPpage:(NSInteger)nextPageType dataArray:(NSMutableArray *)dataArray{
//    self.leftLa.text = dataArray[indexPath.row];
//    
//    self.rightBgLa.textColor =textCententColor;
//    if (indexPath.row ==0) {
//        if (nextPageType==1) {
//            self.rightBgLa.text=@"";
//        }else{
//            self.rightBgLa.text = model.area;
//            NSLog(@"*******%@", self.rightLa.text);
//        }
//    }else if (indexPath.row ==1){
//        if (nextPageType==1) {
//            self.rightBgLa.text =@"";
//        }else{
//            self.rightBgLa.text = model.address;
//            //self.addressLa.text =self.model.address;
//        }
//        
//    }else if (indexPath.row ==2){
//        if (nextPageType==1) {
//            self.rightBgLa.text=@"";
//        } else {
//            NSString*atted =[NSString stringWithFormat:@"%d",model.attendance];
//            self.rightBgLa.text =atted;
//        }
//        
//    }else if (indexPath.row ==3){
//        if (nextPageType==1) {
//            self.rightBgLa.text=@"";
//        } else {
//            NSString*atted =[NSString stringWithFormat:@"%d",model.attendancescope];
//            self.rightBgLa.text =atted;
//        }
//        
//    }else if (indexPath.row ==4){
//        if (nextPageType==1) {
//            self.rightBgLa.text=@"";
//        } else {
//            NSString*atted =[NSString stringWithFormat:@"%d",model.contracttime];
//            self.rightBgLa.text =atted;
//        }
//        
//    }else if (indexPath.row==5){
//        if (nextPageType==1) {
//            self.rightBgLa.text=@"";
//        } else {
//            NSString*atted =[NSString stringWithFormat:@"%d",model.fingerprinttime];
//            self.rightBgLa.text =atted;
//        }
//        
//    }
//    
//
//
//}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI{
    
    self.leftLa =[[UILabel alloc]init];
    self.leftLa.frame = CGRectMake(10, self.contentView.height/4, 80, 20);
    //self.leftLa.backgroundColor=[UIColor blueColor];
    [self.contentView addSubview:self.leftLa];
    self.leftLa.textColor=textCententColor;
    
//    self.rightBgLa =[[UILabel alloc]init];
//    self.rightBgLa.frame=CGRectMake(SCREEN_WIDTH/3*2, self.leftLa.y,SCREEN_WIDTH/3-30 , 20);
//  self.rightBgLa.textAlignment =NSTextAlignmentRight;
//    self.rightBgLa.textColor=textColorPlace;
//    [self.contentView addSubview:self.rightBgLa];
    
    self.rightLa=[[UILabel alloc]init];
  self.rightLa.frame = CGRectMake(SCREEN_WIDTH/3*2, self.leftLa.y,SCREEN_WIDTH/3-30 , 20);;
    self.rightLa.text = @"去填写";
    [self.contentView addSubview:self.rightLa];
    self.rightLa.backgroundColor =[UIColor clearColor];;
    self.rightLa.textAlignment =NSTextAlignmentRight;
       self.rightLa.textColor=textBlueColor;
    
   
    
    
    self.rightImage =[[ UIImageView alloc]init];
   self.rightImage .frame = CGRectMake(self.contentView.width-PROPORTION_WIDTH(25), PROPORTION_HIGHT(15), PROPORTION_WIDTH(8), PROPORTION_HIGHT(15));
    [self.rightImage setImage:[UIImage imageNamed:@"icon_right"]];
    [self.contentView addSubview: self.rightImage];
    
    self.rightLa.adjustsFontSizeToFitWidth=YES;
    self.leftLa.adjustsFontSizeToFitWidth=YES;
    
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.leftLa.frame = CGRectMake(10, self.contentView.height/4, SCREEN_WIDTH/2, 20);
     self.rightLa.frame=CGRectMake(SCREEN_WIDTH/3*2, self.leftLa.y,SCREEN_WIDTH/3-30 , 20);
    self.rightImage .frame = CGRectMake(self.contentView.width-PROPORTION_WIDTH(25), PROPORTION_HIGHT(15), PROPORTION_WIDTH(8), PROPORTION_HIGHT(15));
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
