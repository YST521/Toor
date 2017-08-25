//
//  QRbuttonOrderlPage.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/4.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "QRbuttonOrderlPage.h"

@implementation QRbuttonOrderlPage

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
        
    }
    return self;
}

- (void)creatUI{
    
    self.backgroundColor =[UIColor whiteColor];
    UIView*line =[[UIView alloc]init];
    line.frame = CGRectMake(0, 0, SceneWidth, 0.5);
    line.backgroundColor = LineColor;
    [self addSubview:line];

    self.titleLa =[[UILabel alloc]init];
    self.titleLa.frame = CGRectMake(0, 10,(SceneWidth-60)*0.7, 20);
    self.titleLa.textColor = [UIColor colorWithHexStringg:@"#666666"];
   self.titleLa.font =[UIFont systemFontOfSize:16];
    [self addSubview:self.titleLa];
    
    self.dateLa =[[UILabel alloc]init];
    self.dateLa.frame = CGRectMake(0, CGRectGetMaxY(self.titleLa.frame)+5,(SceneWidth-60)*0.8, 20);
    self.dateLa.textColor = [UIColor colorWithHexStringg:@"#999999"];
    self.dateLa.font =[UIFont systemFontOfSize:14];
    [self addSubview: self.dateLa];
    
    self.statusLa =[[UILabel alloc]init];
     self.statusLa.frame = CGRectMake((SceneWidth-60)-50, 0, 50, 60);
    self.statusLa.font =[UIFont systemFontOfSize:16];
    self.statusLa.textAlignment = NSTextAlignmentCenter;
    self.statusLa.textColor =[UIColor blackColor];

    [self addSubview:self.statusLa];
    
    
    
    //
//    self.statusLa.backgroundColor =[UIColor yellowColor];
    self.titleLa.text = @"早餐取餐码：0356 6666";
    self.dateLa.text = @"有效期至：2017/07/20 13:00";
   self.statusLa.text = @"二维码";
}

@end
