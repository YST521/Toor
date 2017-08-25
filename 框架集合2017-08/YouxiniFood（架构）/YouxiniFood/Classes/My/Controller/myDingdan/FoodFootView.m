//
//  FoodFootView.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "FoodFootView.h"
#import "QRbuttonOrderlPage.h"

@implementation FoodFootView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
        
    }
    
    return self;
}
//需要循环创建
- (void)creatUI{
    
    self.backgroundColor =[UIColor yellowColor];
    
  self.qrBtn =[[QRbuttonOrderlPage alloc]init];
    self.qrBtn.frame = CGRectMake(0, 0, SceneWidth-40, 60);
      _qrBtn.backgroundColor =[UIColor cyanColor];
    [self addSubview:self.qrBtn];
    
    //    self.titleLa.text = @"早餐取餐码：0356 6666";
    //    self.dateLa.text = @"有效期至：2017/07/20 13:00";
    //    self.statusLa.text = @"二维码";
   self.qrBtn.titleLa .text =  @"早餐取餐码：0356 6666";
   self.qrBtn.dateLa.text = @"有效期至：2017/07/20 13:00";
   self.qrBtn.statusLa.text = @"二维码";
    
//    [self.qrBtn addTarget:self action:@selector(btnaction) forControlEvents:(UIControlEventTouchUpInside)];
    
   self.qrBtn2 =[[QRbuttonOrderlPage alloc]init];
   self.qrBtn2.frame = CGRectMake(0, CGRectGetMaxY(self.qrBtn.frame), SceneWidth-40, 60);
    //    qrBtn.backgroundColor =[UIColor redColor];
    [self addSubview:self.qrBtn2];
    
    //    self.titleLa.text = @"早餐取餐码：0356 6666";
    //    self.dateLa.text = @"有效期至：2017/07/20 13:00";
    //    self.statusLa.text = @"二维码";
  self.qrBtn2.titleLa .text =  @"早餐取餐码：0356 6666";
   self.qrBtn2.dateLa.text = @"有效期至：2017/07/20 13:00";
   self.qrBtn2.statusLa.text = @"二维码";
    
//     [self.qrBtn addTarget:self action:@selector(btnaction) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.qrBtn2 addTarget:self action:@selector(btnaction) forControlEvents:(UIControlEventTouchUpInside)];
//    
//    self.bgView =[[UIView alloc]init];
//    self.bgView.frame = CGRectMake(0, 0, SceneWidth-40, 40);
//    self.bgView.backgroundColor =[UIColor whiteColor];
//    [self addSubview:self.bgView];
//    
//    self.qucanMaLa =[[UILabel alloc]init];
//    self.qucanMaLa.frame = CGRectMake(10, 0,self.bgView.width*0.75, 20);
//    self.qucanMaLa.textColor = [UIColor colorWithHexStringg:@"#666666"];
//    self.qucanMaLa.font =[UIFont systemFontOfSize:14];
//    [self addSubview:self.qucanMaLa];
//    
//    self.efficientLa =[[UILabel alloc]init];
//     self.efficientLa.frame = CGRectMake(10, CGRectGetMaxY(self.qucanMaLa.frame),self.bgView.width*0.75, 20);
//     self.efficientLa.textColor = [UIColor colorWithHexStringg:@"#666666"];
//     self.efficientLa.font =[UIFont systemFontOfSize:14];
//    [self addSubview: self.efficientLa];
//    
//    self.qrStatusBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.qrStatusBtn.frame = CGRectMake(_bgView.width-80, 0, 60, _bgView.height);
//    [self.qrStatusBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
//    [self.bgView addSubview:self.qrStatusBtn];
//
//    
//    
//    //
//    self.qucanMaLa.text = @"早餐取餐码：0356 6666";
//    self.efficientLa.text = @"有效期至：2017/07/20 13:00";
//    [self.qrStatusBtn setTitle:@"二维码" forState:(UIControlStateNormal)];
    
}
//-(void)btnaction{
//    self.backgroundColor=[UIColor redColor];
//}

@end
