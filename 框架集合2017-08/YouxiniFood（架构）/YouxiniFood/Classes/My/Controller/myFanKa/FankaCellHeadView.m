//
//  FankaCellHeadView.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "FankaCellHeadView.h"

@implementation FankaCellHeadView{

    UILabel *yuEYuanLa, *qiyebuzhuLa, *gerenChongzhiLa;

}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {

        [self creatUI];
        
    }
    return self;

}

-(void)creatUI{

    self.backgroundColor = [UIColor whiteColor];
    
    yuEYuanLa = [[UILabel alloc]init];
    yuEYuanLa.frame = CGRectMake(20, 25, SceneWidth/2, 20);
    yuEYuanLa.text = @"饭卡余额（元）";
    yuEYuanLa.font =[UIFont systemFontOfSize:16];
    [self addSubview:yuEYuanLa];
    
    self.DongjieBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.DongjieBtn.backgroundColor = BgColor;
    if (SceneWidth<375) {
           self.DongjieBtn.frame = CGRectMake(SceneWidth/2, yuEYuanLa.originY, 70, 30);
    } else {
           self.DongjieBtn.frame = CGRectMake(SceneWidth/2+40, yuEYuanLa.originY, 70, 30);
    }
 
    [self.DongjieBtn setTitle:@"冻结饭卡" forState:(UIControlStateNormal)];
    [self.DongjieBtn setTitleColor:CellTitleColor forState:(UIControlStateNormal)];
    self.DongjieBtn.titleLabel.font =[UIFont systemFontOfSize:16];;
    self.DongjieBtn.layer.cornerRadius = 3;
    self.DongjieBtn.clipsToBounds = YES;
    [self addSubview:self.DongjieBtn];
    
    //饭卡充值btn
    self.ChongzhiBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.ChongzhiBtn.frame = CGRectMake(SceneWidth-80, yuEYuanLa.originY, 70, 30);
    [ self.ChongzhiBtn setTitle:@"充值饭卡" forState:(UIControlStateNormal)];
    self.ChongzhiBtn.backgroundColor = BgColor;
   [ self.ChongzhiBtn setTitleColor:CellTitleColor forState:(UIControlStateNormal)];
    self.ChongzhiBtn.titleLabel.font =[UIFont systemFontOfSize:16];;
    self.ChongzhiBtn.layer.cornerRadius = 3;
     self.ChongzhiBtn.clipsToBounds = YES;
    [self addSubview:self.ChongzhiBtn];
  
    //余额label
    self.fankaYueLa = [[UILabel alloc]init];
    self.fankaYueLa.frame = CGRectMake(20, CGRectGetMaxY(yuEYuanLa.frame)+15, SceneWidth, 30);
    self.fankaYueLa.font =[UIFont systemFontOfSize:30];
    self.fankaYueLa.textColor =[UIColor colorWithHexStringg:@"#fe5b4f"];
    [self addSubview:self.fankaYueLa];
   
    //企业补助
    qiyebuzhuLa =[[UILabel alloc]init];
    qiyebuzhuLa.frame = CGRectMake(20, CGRectGetMaxY(self.fankaYueLa.frame)+20, SceneWidth/2, 20);
    qiyebuzhuLa.textColor = CellTitleColor;
    qiyebuzhuLa.text = @"企业补助（元）";
    qiyebuzhuLa.font =[UIFont systemFontOfSize:16];
    [self addSubview:qiyebuzhuLa];
    
    //
   gerenChongzhiLa =[[UILabel alloc]init];
     gerenChongzhiLa.frame = CGRectMake(SceneWidth/2+10, CGRectGetMaxY(self.fankaYueLa.frame)+20, SceneWidth/2, 20);
     gerenChongzhiLa.textColor = CellTitleColor;
     gerenChongzhiLa.text = @"个人充值（元）";
     gerenChongzhiLa.font =[UIFont systemFontOfSize:16];
    [self addSubview: gerenChongzhiLa];
    
    // 余额展示
    self.qiyeBuzhuLa =[[UILabel alloc]init];
    self.qiyeBuzhuLa.frame =CGRectMake(20, CGRectGetMaxY(qiyebuzhuLa.frame)+10, qiyebuzhuLa.width, 20);
    self.qiyeBuzhuLa.textColor = CellTitleColor;
//    self.qiyeBuzhuLa.textAlignment = NSTextAlignmentCenter;
    self.qiyeBuzhuLa.font =[UIFont systemFontOfSize:20];
    [self addSubview:self.qiyeBuzhuLa];
    
    self.gerenChongzhiLa =[[UILabel alloc]init];
     self.gerenChongzhiLa.frame =CGRectMake(gerenChongzhiLa.originX, CGRectGetMaxY(qiyebuzhuLa.frame)+10, gerenChongzhiLa.width, 20);
     self.gerenChongzhiLa.textColor = CellTitleColor;
//     self.gerenChongzhiLa.textAlignment = NSTextAlignmentCenter;
    self.gerenChongzhiLa.font =[UIFont systemFontOfSize:20];
    [self addSubview: self.gerenChongzhiLa];
    
    
    //测试字体
    self.fankaYueLa.text = @"100.00";
    self.qiyeBuzhuLa.text = @"50.00";
    self.gerenChongzhiLa.text = @"50.0";
    
    
}

@end
