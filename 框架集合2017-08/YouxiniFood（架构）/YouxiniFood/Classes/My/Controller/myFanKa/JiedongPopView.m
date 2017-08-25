//
//  JiedongPopView.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/4.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "JiedongPopView.h"

@implementation JiedongPopView{
    UIView *popView;
    UIView *BGv;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
   
    
    BGv =[[UIView alloc]init];
    BGv.frame = [UIScreen mainScreen].bounds;
    BGv.backgroundColor =[UIColor colorWithWhite:0.0 alpha:0.4];
    [self addSubview:BGv];
    
    popView  = [[UIView alloc]init];
    if (SceneHeight>600) {
        popView.frame = CGRectMake(40, SceneHeight*0.25, SceneWidth-80, SceneHeight*0.3);
    }else{
        popView.frame = CGRectMake(20, SceneHeight*0.25, SceneWidth-40, SceneHeight*0.32);
    }
    popView.backgroundColor = [UIColor whiteColor];
    popView.layer.cornerRadius = 8 ;
    popView.clipsToBounds = YES;
    [BGv addSubview:popView];
    
    UILabel *titleLa =[[UILabel alloc]init];
    titleLa.frame = CGRectMake(20, 30, popView.width - 40, 20);
    titleLa.text = @"温馨提示";
    titleLa.textAlignment = NSTextAlignmentCenter;
    [popView addSubview:titleLa];
    
    self.closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.closeBtn.frame = CGRectMake(popView.width-30, 10, 15, 15);
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"icon_guanbi"] forState:(UIControlStateNormal)];
    [popView addSubview:self.closeBtn];
    
    self.contentLa =[[UILabel alloc]init];
    if (SceneHeight>600) {
        self.contentLa.frame = CGRectMake(20, CGRectGetMaxY(self.closeBtn.frame)+30, popView.width -40, 60);
    }else{
        self.contentLa.frame = CGRectMake(20, CGRectGetMaxY(self.closeBtn.frame)+30, popView.width -40, 40);
    }
    self.contentLa.text = @"饭卡已冻结，解冻请联系管理人员！";
    self.contentLa.numberOfLines = 2;
    self.contentLa.textColor =[UIColor colorWithHexStringg:@"#666666"];
    self.contentLa.textAlignment = NSTextAlignmentCenter;
    [popView addSubview:self.contentLa];
    
    
    
    self.jdoneBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
     self.jdoneBtn.frame = CGRectMake(20, CGRectGetMaxY(self.contentLa.frame)+40, popView.width-40 , 45);
    self.jdoneBtn.layer.cornerRadius = 8;
    self.jdoneBtn.layer.masksToBounds = YES;
    self.jdoneBtn.layer.borderWidth = 0.5;
    self.jdoneBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.jdoneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.jdoneBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
    [popView addSubview:self.jdoneBtn];
    
//    [self.doneBtn addTarget:self action:@selector(closV) forControlEvents:(UIControlEventTouchUpInside)];
//      [self.closeBtn addTarget:self action:@selector(closV) forControlEvents:(UIControlEventTouchUpInside)];
}

//- (void)closV{
//    self.hidden = YES;
//}


@end
