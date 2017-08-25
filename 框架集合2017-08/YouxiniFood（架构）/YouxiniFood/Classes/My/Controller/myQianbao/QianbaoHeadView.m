//
//  QianbaoHeadView.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "QianbaoHeadView.h"

@implementation QianbaoHeadView{

    UILabel *yuEYuanLa,*qiyebuzhuLa,* gerenChongzhiLa;
}


-(instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame]) {
        
        [self creatUI];
        
    }
    return  self;
}

- (void)creatUI{

    yuEYuanLa = [[UILabel alloc]init];
    yuEYuanLa.frame = CGRectMake(20, 25, SceneWidth/2, 20);
    yuEYuanLa.text = @"饭卡余额（元）";
    yuEYuanLa.font =[UIFont systemFontOfSize:16];
    [self addSubview:yuEYuanLa];
    
    //余额label
    self.moneryNumLa = [[UILabel alloc]init];
    self.moneryNumLa.frame = CGRectMake(20, CGRectGetMaxY(yuEYuanLa.frame)+15, SceneWidth, 30);
   self.moneryNumLa.font =[UIFont systemFontOfSize:30];
    self.moneryNumLa.textColor =[UIColor colorWithHexStringg:@"#fe5b4f"];
    [self addSubview:self.moneryNumLa];
    
    //企业补助
    qiyebuzhuLa =[[UILabel alloc]init];
    qiyebuzhuLa.frame = CGRectMake(20, CGRectGetMaxY(self.moneryNumLa.frame)+20, SceneWidth/2, 20);
    qiyebuzhuLa.textColor = CellTitleColor;
    qiyebuzhuLa.text = @"企业补助（元）";
    qiyebuzhuLa.font =[UIFont systemFontOfSize:16];
    [self addSubview:qiyebuzhuLa];
    
    //
    gerenChongzhiLa =[[UILabel alloc]init];
    gerenChongzhiLa.frame = CGRectMake(SceneWidth/2+10, CGRectGetMaxY(self.moneryNumLa.frame)+20, SceneWidth/2, 20);
    gerenChongzhiLa.textColor = CellTitleColor;
    gerenChongzhiLa.text = @"个人充值（元）";
    gerenChongzhiLa.font =[UIFont systemFontOfSize:16];
    [self addSubview: gerenChongzhiLa];
    
    // 余额展示
    self.qiyeNumLa =[[UILabel alloc]init];
    self.qiyeNumLa.frame =CGRectMake(20, CGRectGetMaxY(qiyebuzhuLa.frame)+10, qiyebuzhuLa.width, 20);
    self.qiyeNumLa.textColor = CellTitleColor;
    //    self.qiyeBuzhuLa.textAlignment = NSTextAlignmentCenter;
    self.qiyeNumLa.font =[UIFont systemFontOfSize:20];
    [self addSubview:self.qiyeNumLa];
    
    self.gerenNumLa =[[UILabel alloc]init];
   self.gerenNumLa.frame =CGRectMake(gerenChongzhiLa.originX, CGRectGetMaxY(qiyebuzhuLa.frame)+10, gerenChongzhiLa.width, 20);
    self.gerenNumLa.textColor = CellTitleColor;
    //     self.gerenChongzhiLa.textAlignment = NSTextAlignmentCenter;
    self.gerenNumLa.font =[UIFont systemFontOfSize:20];
    [self addSubview: self.gerenNumLa];
    
    
    //测试字体
    self.moneryNumLa.text = @"100.00";
    self.qiyeNumLa.text = @"50.00";
   self.gerenNumLa.text = @"50.0";
    
}

@end
