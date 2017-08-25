//
//  ShowCardMessage.m
//  WiseAPP
//
//  Created by app on 16/10/17.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "ShowCardMessage.h"
#import "WorkTypeMessageController.h"
#import "IDCardModel.h"

@implementation ShowCardMessage

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self addView];
    }

    return  self;
}

-(void)addView{
    
    self.backgroundColor= popBGColore;
    
    UIView*bgview= [[UIView alloc]init ];
    if (SCREEN_WIDTH<370) {
        
        bgview.frame = CGRectMake(PROPORTION_WIDTH(45/2), PROPORTION_HIGHT(64), SCREEN_WIDTH-PROPORTION_WIDTH(45), PROPORTION_HIGHT(490));
        }else{
          bgview.frame= CGRectMake(PROPORTION_WIDTH(45/2), PROPORTION_HIGHT(64), SCREEN_WIDTH-PROPORTION_WIDTH(45), PROPORTION_HIGHT(450));    }

    bgview.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgview];
    
    self.userImage=[[UIImageView alloc]init];
    self.userImage.frame = CGRectMake(PROPORTION_WIDTH(115), PROPORTION_HIGHT(20), PROPORTION_WIDTH(100), PROPORTION_HIGHT(100));
    self.userImage.backgroundColor=[UIColor greenColor];
    self.userImage.layer.cornerRadius = self.userImage.width/2;
    self.userImage.layer.masksToBounds=YES;
    [bgview addSubview:self.userImage];
    
    UIColor*midColor=textCententColor
    UIColor*rightColor=textColorPlace;
    
    UIImageView*iconName=[self iconImage:@"iconfont-wode" imageFrame:CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(self.userImage.frame)+10, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20))];
    [bgview addSubview:iconName];
    
    UILabel*nameLabel=[self midLAbel:CGRectMake(CGRectGetMaxX(iconName.frame)+10, iconName.y, 40, 20) title:@"姓名" textcolor:midColor  textfont:16 ];
   //nameLabel.backgroundColor=[UIColor redColor];
    [bgview addSubview:nameLabel];
  
    self.userName =[self midLAbel:CGRectMake(CGRectGetMaxX(nameLabel.frame)+10, iconName.y, 100, 20) title:@"姓名" textcolor:rightColor  textfont:16 ];
    //self.userName.backgroundColor=[UIColor redColor];
    [bgview addSubview:self.userName];
    //性别
    UIImageView*iconGender=[self iconImage:@"iconfont-wode" imageFrame:CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(self.userName.frame)+10, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20))];
    [bgview addSubview:iconGender];
    
    UILabel*genderLabel=[self midLAbel:CGRectMake(CGRectGetMaxX(iconGender.frame)+10, iconGender.y, 40, 20) title:@"性别" textcolor:midColor  textfont:16 ];
    //nameLabel.backgroundColor=[UIColor redColor];
    [bgview addSubview:genderLabel];
    
    self.userGender =[self midLAbel:CGRectMake(CGRectGetMaxX(genderLabel.frame)+10, iconGender.y, 100, 20) title:@"姓名" textcolor:rightColor  textfont:16 ];
    //self.userName.backgroundColor=[UIColor redColor];
    [bgview addSubview:self.userGender];
//名族
    UIImageView*iconNation=[self iconImage:@"iconfont-wode" imageFrame:CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(self.userGender.frame)+10, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20))];
    [bgview addSubview:iconNation];
    
    UILabel*nationLabel=[self midLAbel:CGRectMake(CGRectGetMaxX(iconNation.frame)+10, iconNation.y, 40, 20) title:@"民族" textcolor:midColor  textfont:16 ];
   // nameLabel.backgroundColor=[UIColor redColor];
    [bgview addSubview:nationLabel];
    
    self.userNation =[self midLAbel:CGRectMake(CGRectGetMaxX(nationLabel.frame)+10, iconNation.y, 100, 20) title:@"姓名" textcolor:rightColor  textfont:16 ];
 
    [bgview addSubview:self.userNation];
    //出生
    UIImageView*iconDate=[self iconImage:@"iconfont-wode" imageFrame:CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(self.userNation.frame)+10, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20))];
    //iconDate.backgroundColor=[UIColor grayColor];
    [bgview addSubview:iconDate];
    
    UILabel*dateLabel=[self midLAbel:CGRectMake(CGRectGetMaxX(iconDate.frame)+10, iconDate.y, 40, 20) title:@"出生" textcolor:midColor  textfont:16 ];

    [bgview addSubview:dateLabel];
    
    self.userDate =[self midLAbel:CGRectMake(CGRectGetMaxX(dateLabel.frame)+10, iconDate.y, 100, 20) title:@"姓名" textcolor:rightColor  textfont:16 ];
    [bgview addSubview:self.userDate];
    
    //住址
    UIImageView*iconAdress=[self iconImage:@"iconfont-wode" imageFrame:CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(iconDate.frame)+10, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20))];
    //iconAdress.backgroundColor=[UIColor blackColor];
    [bgview addSubview:iconAdress];
    
    UILabel*adressLabel=[self midLAbel:CGRectMake(CGRectGetMaxX(iconAdress.frame)+10, iconAdress.frame.origin.y, 40, 20) title:@"住址" textcolor:midColor  textfont:16 ];
   // adressLabel.backgroundColor=[UIColor yellowColor];
    [bgview addSubview:adressLabel];
    
    self.userAdress =[self midLAbel:CGRectMake(CGRectGetMaxX(adressLabel.frame)+5, iconAdress.y, 140, 20) title:@"姓名" textcolor:rightColor  textfont:16 ];
  
    [bgview addSubview:self.userAdress];
    
//    //身份证号
    UIImageView*iconNum=[self iconImage:@"iconfont-wode" imageFrame:CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(self.userAdress.frame)+10, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20))];
   // iconNum.backgroundColor=[UIColor blueColor];
    [bgview addSubview:iconNum];
//
    UILabel*numLabel=[self midLAbel:CGRectMake(CGRectGetMaxX(iconNum.frame)+10, iconNum.y, 100, 20) title:@"身份证号" textcolor:midColor  textfont:16 ];
    //numLabel.backgroundColor=[UIColor greenColor];
    [bgview addSubview:numLabel];
    
    self.userIDnum =[self midLAbel:CGRectMake(CGRectGetMaxX(numLabel.frame)+10, iconNum.y, 100, 20) title:@"姓名" textcolor:rightColor  textfont:16 ];
        [bgview addSubview:self.userIDnum];
//
//    //签证机关
    UIImageView*iconVisa=[self iconImage:@"iconfont-wode" imageFrame:CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(self.userIDnum.frame)+10, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20))];
    [bgview addSubview:iconVisa];
    
    UILabel*visaLabel=[self midLAbel:CGRectMake(CGRectGetMaxX(iconVisa.frame)+10, iconVisa.y, 100, 20) title:@"签证机关" textcolor:midColor  textfont:16 ];
    //visaLabel.backgroundColor=[UIColor redColor];
    [bgview addSubview:visaLabel];
    
    self.userVisa =[self midLAbel:CGRectMake(CGRectGetMaxX(visaLabel.frame)+5, iconVisa.y, 100, 20) title:@"姓名" textcolor:rightColor  textfont:16 ];
    [bgview addSubview:self.userVisa];
//
//    //有效日期
    UIImageView*iconVisadate=[self iconImage:@"iconfont-wode" imageFrame:CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(self.userVisa.frame)+10, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20))];
    [bgview addSubview:iconVisadate];
    
    UILabel*visaDateLabel=[self midLAbel:CGRectMake(CGRectGetMaxX(iconVisadate.frame)+10, iconVisadate.y, 80, 20) title:@"有效日期" textcolor:midColor  textfont:16 ];
    //visaDateLabel.backgroundColor=[UIColor redColor];
    [bgview addSubview:visaDateLabel];
    
    self.userVisaDate =[self midLAbel:CGRectMake(CGRectGetMaxX(visaDateLabel.frame)+10, iconVisadate.y, 120, 20) title:@"姓名" textcolor:rightColor  textfont:16 ];
    [bgview addSubview:self.userVisaDate];
    
    self.backBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.backBtn.frame = CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(self.userVisaDate.frame)+20, (bgview.width-PROPORTION_WIDTH(16)*2-10)/2, STANDARD_HEIGHT);
    KUIbutton(self.backBtn);
    KUIbuttonClick(self.backBtn);
    [self.backBtn setTitle:@"重拍" forState:(UIControlStateNormal)];
    [bgview addSubview:self.backBtn];
    
    self.doneBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.doneBtn.frame=CGRectMake(CGRectGetMaxX(self.backBtn.frame)+10, self.backBtn.y, self.backBtn.width, self.backBtn.height);
    KUIbutton(self.doneBtn);
    KUIbuttonClick(self.doneBtn);
    [self.doneBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
    [bgview addSubview:self.doneBtn];
    self.hidden = NO;
    //自适应
    self.userAdress.adjustsFontSizeToFitWidth =YES;
    self.userIDnum.adjustsFontSizeToFitWidth = YES;
    self.userVisaDate.adjustsFontSizeToFitWidth = YES;
    
    
    }

   -(UIImageView*)iconImage:(NSString*)imgeName imageFrame:(CGRect)frame {
    
    UIImageView*imageTitle=[[UIImageView alloc]initWithFrame:frame];
    imageTitle.image=[UIImage imageNamed:imgeName];
    
    return  imageTitle;
}
-(UILabel*)midLAbel:(CGRect)frame title:(NSString*)title textcolor:(UIColor*)color textfont:(NSInteger)font{

    UILabel*Label=[[UILabel alloc]initWithFrame:frame];
    Label.text = title;
    Label.font =[UIFont systemFontOfSize:font];
    Label.textColor= color;
     // Label.textColor= [UIColor redColor];
 

    return Label;
}



@end
