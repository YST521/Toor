//
//  PopPasswordView.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/4.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "PopPasswordView.h"

@implementation PopPasswordView{

    UIView * popView;
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
     
        [self creatUI];
        
    }
    
    return self;

}

- (void)creatUI{
//    self.backgroundColor =[UIColor colorWithWhite:0.0 alpha:0.4];
    
    popView  = [[UIView alloc]init];
    if (SceneHeight>600) {
        popView.frame = CGRectMake(40, SceneHeight*0.25, SceneWidth-80, SceneHeight*0.3);
    }else{
        popView.frame = CGRectMake(20, SceneHeight*0.25, SceneWidth-40, SceneHeight*0.32);
    }
    popView.backgroundColor = [UIColor whiteColor];
    popView.layer.cornerRadius = 8 ;
    popView.clipsToBounds = YES;
    [self addSubview:popView];
    
    UILabel *titleLa =[[UILabel alloc]init];
    titleLa.frame = CGRectMake(20, 30, popView.width - 30, 20);
    titleLa.text = @"请输入密码";
    titleLa.textAlignment = NSTextAlignmentCenter;
    [popView addSubview:titleLa];
    
    self.pwcloseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
     self.pwcloseBtn.frame = CGRectMake(popView.width-30, 10, 15, 15);
    [ self.pwcloseBtn setBackgroundImage:[UIImage imageNamed:@"icon_guanbi"] forState:(UIControlStateNormal)];
    [popView addSubview: self.pwcloseBtn];
    
    //密码框
   self.InpPw = [[InputPasswordBordView alloc]init];
//   self.InpPw.frame = CGRectMake(0, CGRectGetMaxY(titleLa.frame)+30, popView.width -40, 40);
  self.InpPw.centerX = popView.width/2;
    
    if (SceneWidth>320) {
        self.InpPw.frame = CGRectMake(0, CGRectGetMaxY(titleLa.frame)+30, 40*6, 40);
        self.InpPw.centerX = popView.width/2;
        self.InpPw.squareWidth = 40;
    } else {
        self.InpPw.frame = CGRectMake(0, CGRectGetMaxY(titleLa.frame)+30, 40*6, 40);
           self.InpPw.centerX = popView.width/2;
        self.InpPw.squareWidth = 40;
    }
    
   self.InpPw.backgroundColor=[UIColor greenColor];
    [popView addSubview:self.InpPw];
    self.InpPw.passWordNum = 6;
    //进入页面自动弹出键盘
    [self.InpPw becomeFirstResponder];
    
   self.InpPw.pointRadius = 6;
   self.InpPw.pointColor = [UIColor blackColor];
    self.InpPw.rectColor =[UIColor lightGrayColor];
    self.InpPw.pointColor = [UIColor blackColor];
    //    wclV.textStore = @"123456";
    self.InpPw.delegate =self;
    
    self.pwdoneBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    if (SceneWidth>320) {
        self.pwdoneBtn.frame = CGRectMake(20,popView.height-55, popView.width -40, 45);
    } else {
        self.pwdoneBtn.frame = CGRectMake(20,CGRectGetMaxY(self.inputView.frame)+20, popView.width -40, 30);
    }
    
        self.pwdoneBtn.layer.cornerRadius = 8;
     self.pwdoneBtn.layer.masksToBounds = YES;
    self.pwdoneBtn.layer.borderWidth = 0.5;
    self.pwdoneBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.pwdoneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.pwdoneBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
    [popView addSubview:self.pwdoneBtn];
    
}
#pragma mark - PassWordViewDelegate
/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(InputPasswordBordView *)passWord {
    NSLog(@"======密码改变：%@",passWord.textStore);
}

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(InputPasswordBordView *)passWord inPutStr:(NSString*)intputSreing{
    NSLog(@"+++++++密码输入完成 --%@",intputSreing);
   
}

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(InputPasswordBordView *)passWord {
    NSLog(@"-------密码开始输入");
}







@end
