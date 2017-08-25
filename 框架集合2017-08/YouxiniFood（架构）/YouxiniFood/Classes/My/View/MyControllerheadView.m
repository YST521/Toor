//
//  MyControllerheadView.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyControllerheadView.h"


@implementation MyControllerheadView
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor=BgColor;
         self.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI{

    self.userAdminView =[[UIView alloc]init];
    self.userAdminView.frame =CGRectMake(0, 0, SceneWidth, 179+50);
    self.userAdminView .backgroundColor= GoldColor;
    [self addSubview:self.userAdminView];
    
    self.yueEFukuanView =[[UIView alloc]init];
    self.yueEFukuanView.frame = CGRectMake(10, 179, SceneWidth-20, 102);
    self.yueEFukuanView.backgroundColor=[UIColor whiteColor];
//    [self.yueEFukuanView xw_roundedCornerWithRadius:4 cornerColor:[UIColor redColor]];
    self.yueEFukuanView.layer.cornerRadius = 8;
    self.yueEFukuanView.backgroundColor = [UIColor whiteColor];
      self.yueEFukuanView.layer.cornerRadius = CardLayerCornerRadius;
     self.yueEFukuanView.layer.borderColor = [UIColor lightGrayColor].CGColor;
     self.yueEFukuanView.layer.borderWidth = 0.3;
     self.yueEFukuanView.clipsToBounds = YES;
    [self addSubview:self.yueEFukuanView];
    
    //userAdmin
    self.adminBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.adminBtn.frame = CGRectMake(SceneWidth-100, 80, 100, 20);
//    self.adminBtn.backgroundColor=[UIColor redColor];
    [self.adminBtn setTitle:@"原型图(测试)" forState:(UIControlStateNormal)];
    [self.adminBtn setTitleColor:NaTitleColor forState:(UIControlStateNormal)];
    self.adminBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.userAdminView addSubview:self.adminBtn];
    
    self.userIamgeView =[[UIImageView alloc]init];
    self.userIamgeView.frame = CGRectMake(0, 0, 80, 80);
    self.userIamgeView.center = CGPointMake(SceneWidth/2, 50+40);
    self.userIamgeView.backgroundColor=[UIColor redColor];
        [self.userIamgeView xw_roundedCornerWithCornerRadii:CGSizeMake(40, 40) cornerColor:GoldColor corners:UIRectCornerAllCorners borderColor:[UIColor grayColor] borderWidth:1];
    self.userIamgeView.image = [UIImage imageNamed:@"bg_touxiang"];
    [self.userAdminView addSubview:self.userIamgeView];
    
    self.userNameLa = [[UILabel alloc]init];
    self.userNameLa.frame =CGRectMake(0, 0, SceneWidth, 40);
    self.userNameLa.center = CGPointMake(SceneWidth/2,CGRectGetMaxY(self.userIamgeView.frame)+10);
    self.userNameLa.textColor = [UIColor colorWithHexStringg:@"#571516"];
    self.userNameLa.font =[UIFont systemFontOfSize:14];
    self.userNameLa.textAlignment =NSTextAlignmentCenter;
    [self.userAdminView addSubview:self.userNameLa];
    
    self.userCompanyLa = [[UILabel alloc]init];
   self.userCompanyLa.frame =CGRectMake(0, 0,SceneWidth, 40);
    self.userCompanyLa.center = CGPointMake(SceneWidth/2,CGRectGetMaxY(self.userNameLa.frame)+2);
    self.userCompanyLa.font =[UIFont systemFontOfSize:14];
    self.userCompanyLa.textAlignment =NSTextAlignmentCenter;
//    self.userCompanyLa.textColor = [UIColor colorWithHexStringg:@"#999999"];
    self.userCompanyLa.textColor=  NaTitleColor;
    [self.userAdminView addSubview:self.userCompanyLa];
   
    //余额 收付款
    self.fankaBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.fankaBtn.frame = CGRectMake(0, 0, self.yueEFukuanView.width/3, self.yueEFukuanView.height);
//    self.fankaBtn.backgroundColor = [UIColor redColor];
    [self.yueEFukuanView addSubview:self.fankaBtn];
    self.fankaLa=[[UILabel alloc]init];
    self.fankaLa.frame= CGRectMake(0, 34, self.fankaBtn.width, 20);
//    self.fankaLa.backgroundColor=[UIColor greenColor];
    self.fankaLa.font =[UIFont systemFontOfSize:16];
   self.fankaLa.textColor=[UIColor colorWithHexStringg:@"#333333"];
    self.fankaLa.textAlignment =NSTextAlignmentCenter;
    [self.fankaBtn addSubview:self.fankaLa];
    
    UILabel*faLa =[[UILabel alloc]init];
    faLa.frame = CGRectMake(0, CGRectGetMaxY(self.fankaLa.frame)+5, self.fankaBtn.width, 20);
    faLa.text = @"饭卡余额";
    faLa.textAlignment =NSTextAlignmentCenter;
    faLa.font =[UIFont systemFontOfSize:14];
    faLa.textColor=[UIColor colorWithHexStringg:@"#999999"];
    [self.fankaBtn addSubview:faLa];
    
    UIView*linefan =[[UIView alloc]init];
    linefan.frame = CGRectMake(self.fankaBtn.width-1, 23, 1, 55);
    linefan.backgroundColor =  [UIColor groupTableViewBackgroundColor];
;
    [self.fankaBtn addSubview:linefan];
    
    
    self.qianbaoBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
     self.qianbaoBtn.frame = CGRectMake(CGRectGetMaxX(self.fankaBtn.frame), 0, self.yueEFukuanView.width/3, self.yueEFukuanView.height);
    //    self.fankaBtn.backgroundColor = [UIColor redColor];
    [self.yueEFukuanView addSubview: self.qianbaoBtn];
    
    self.qianbaoLa=[[UILabel alloc]init];
     self.qianbaoLa.frame= CGRectMake(0, 34, self.fankaBtn.width, 20);
     self.qianbaoLa.font =[UIFont systemFontOfSize:16];
     self.qianbaoLa.textColor= [UIColor colorWithHexStringg:@"#333333"];;
    self.qianbaoLa.textAlignment =NSTextAlignmentCenter;
    [self.qianbaoBtn addSubview: self.qianbaoLa];
    
    UILabel*qianLa =[[UILabel alloc]init];
    qianLa.frame = CGRectMake(0, CGRectGetMaxY( self.qianbaoLa.frame)+5, self.fankaBtn.width, 20);
    qianLa.text = @"钱包余额";
    qianLa.textAlignment =NSTextAlignmentCenter;
    qianLa.font =[UIFont systemFontOfSize:14];
    qianLa.textColor=[UIColor colorWithHexStringg:@"#999999"];
    [self.qianbaoBtn addSubview:qianLa];
    
    UIView*lineqian =[[UIView alloc]init];
    lineqian.frame = CGRectMake(self.qianbaoBtn.width-1, 23, 1, 55);
    lineqian.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.qianbaoBtn addSubview:lineqian];
    
    //收付款
    self.shouFunBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.shouFunBtn.frame = CGRectMake(CGRectGetMaxX(self.qianbaoBtn.frame), 0, self.yueEFukuanView.width/3, self.yueEFukuanView.height);
//         self.shouFunBtn.backgroundColor = [UIColor greenColor];
    [self.yueEFukuanView addSubview: self.shouFunBtn];
    

    UIImageView*qianimageV=[[UIImageView alloc]init];
    qianimageV.frame= CGRectMake(0, 0, 30, 20);
    qianimageV.center = CGPointMake(self.shouFunBtn.width/2, 34+10);
    qianimageV.image = [UIImage imageNamed:@"bg_shoufukuang"];
//    qianimageV.backgroundColor=[UIColor redColor];
    [self.shouFunBtn addSubview: qianimageV];
    
    UILabel*shoufuLa =[[UILabel alloc]init];
    shoufuLa.frame = CGRectMake(0, CGRectGetMaxY( self.qianbaoLa.frame)+2, self.fankaBtn.width, 20);
    shoufuLa.text = @"收付款";
    shoufuLa.textAlignment =NSTextAlignmentCenter;
    shoufuLa.font =[UIFont systemFontOfSize:14];
    shoufuLa.textColor=[UIColor colorWithHexStringg:@"#999999"];
    [self.shouFunBtn addSubview:shoufuLa];

    
    
    //测试数据
    self.userNameLa.text = @"孙悟空";
    self.userCompanyLa.text = @"广东优信无线网络有限公司";
    
    self.fankaLa.text = @"100RMB";
    self.qianbaoLa.text = @"666元";
    
    
}

@end
