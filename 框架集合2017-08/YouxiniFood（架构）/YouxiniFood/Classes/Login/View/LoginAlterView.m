//
//  LoginAlterView.m
//  YouxiniFood
//
//  Created by 何青 on 2017/7/27.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "LoginAlterView.h"

@interface LoginAlterView()<UITextFieldDelegate>
{
    UILabel *sclLable;
    UIButton *loginBtn,*registBtn,*yzmBtn;
    UIScrollView *scrollView;
    UITextField *phoneTf,*yzmTf,*pswTf,*psw2Tf;//注册
    UITextField *loginPhoneTf,*loginPswTf;
    UIButton *nextBtn,*_registBtn,*_loginBtn,*_forgetBtn;
}
@end

@implementation LoginAlterView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self initUI];
    }
    return self;
}

- (UIButton *)createCustomBtnWithFrame:(CGRect)frame title:(NSString *)title bgColor:(UIColor *)bgColor titleColor:(UIColor *)titleColor titleFont:(NSInteger)font{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:bgColor];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.layer.cornerRadius = ButtonLayerCornerRadius;
    button.clipsToBounds = YES;
    return button;
}

- (void)initUI{
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight)];
    _contentView.transform = CGAffineTransformMakeScale(0, 0);
    [self addSubview:_contentView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(40, 0, SceneWidth - 80, (SceneWidth - 80)*1.2)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = CardLayerCornerRadius;
    bgView.clipsToBounds = YES;
    bgView.center = _contentView.center;
    [_contentView addSubview:bgView];
    
    UIButton *closeBtn = [self createCustomBtnWithFrame:CGRectMake(bgView.width-50, 0, 40, 30) title:@"关闭" bgColor:[UIColor whiteColor] titleColor:[UIColor darkGrayColor] titleFont:13];
    [closeBtn addTarget:self action:@selector(clickCloseAction:) forControlEvents:UIControlEventTouchUpInside];
//    [closeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [bgView addSubview:closeBtn];
    
    registBtn = [self createCustomBtnWithFrame:CGRectMake(20, 20, (bgView.width-40)/2, 30) title:@"注册" bgColor:[UIColor whiteColor] titleColor:[UIColor lightGrayColor] titleFont:15];
    [registBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [registBtn addTarget:self action:@selector(clickRegist:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:registBtn];
    
    loginBtn = [self createCustomBtnWithFrame:CGRectMake(registBtn.right, 20, (bgView.width-40)/2, 30) title:@"登录" bgColor:[UIColor whiteColor]  titleColor:[UIColor lightGrayColor] titleFont:15];
    loginBtn.selected = YES;
    [loginBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [loginBtn addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:loginBtn];
    
    UILabel *line  = [[UILabel alloc] initWithFrame:CGRectMake(8, loginBtn.bottom, bgView.width-16, 1)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgView addSubview:line];
    
    sclLable = [[UILabel alloc] initWithFrame:CGRectMake(0, loginBtn.bottom, 60, 2)];
    sclLable.centerX = loginBtn.centerX;
    sclLable.backgroundColor = [UIColor darkGrayColor];
    [bgView addSubview:sclLable];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, sclLable.bottom, bgView.width, bgView.height - 52)];
    scrollView.contentSize = CGSizeMake(scrollView.width *3, 0);
    scrollView.scrollEnabled = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces  = YES;
    [scrollView setContentOffset:CGPointMake(scrollView.width*2, 0) animated:YES];
    [bgView addSubview:scrollView];
    
    for (int i = 0; i<3; i++) {
        if ( i == 0) {
            phoneTf = [[UITextField alloc] initWithFrame:CGRectMake(20, 30, scrollView.width-40, 30)];
            phoneTf.placeholder = @"请输入手机号码";
            phoneTf.keyboardType = UIKeyboardTypePhonePad;
            phoneTf.borderStyle = UITextBorderStyleRoundedRect;
            phoneTf.delegate = self;
            phoneTf.font = [UIFont systemFontOfSize:14];
            [scrollView addSubview:phoneTf];
            
            yzmTf = [[UITextField alloc] initWithFrame:CGRectMake(20, phoneTf.bottom + 20, phoneTf.width/3*2-10, 30)];
            yzmTf.placeholder = @"验证码";
            yzmTf.keyboardType = UIKeyboardTypePhonePad;
            yzmTf.borderStyle = UITextBorderStyleRoundedRect;
            yzmTf.delegate = self;
            yzmTf.font = [UIFont systemFontOfSize:14];
            [scrollView addSubview:yzmTf];
            
            yzmBtn =   [self createCustomBtnWithFrame:CGRectMake(yzmTf.right+5, yzmTf.top, bgView.width-yzmTf.width-45, 30) title:@"发送验证码" bgColor:[UIColor lightGrayColor] titleColor:[UIColor darkGrayColor] titleFont:12];
            [yzmBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
            [yzmBtn addTarget:self action:@selector(clickYzmBtn:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:yzmBtn];
            
            nextBtn = [self createCustomBtnWithFrame:CGRectMake(40, yzmBtn.bottom+40, bgView.width- 80, 30) title:@"下一步" bgColor:GoldColor titleColor:[UIColor darkGrayColor] titleFont:14];
            [nextBtn addTarget:self action:@selector(clickNextBtn:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:nextBtn];
            
        }else if (i == 1){
        
            pswTf = [[UITextField alloc] initWithFrame:CGRectMake(scrollView.width + 20, 30, scrollView.width-40, 30)];
            pswTf.placeholder = @"请设置密码(字母+数字,6位以上)";
            pswTf.keyboardType = UIKeyboardTypeDefault;
            pswTf.borderStyle = UITextBorderStyleRoundedRect;
            pswTf.secureTextEntry = YES;
            pswTf.delegate = self;
            pswTf.font = [UIFont systemFontOfSize:14];
            [scrollView addSubview:pswTf];
            
            psw2Tf = [[UITextField alloc] initWithFrame:CGRectMake(scrollView.width + 20, pswTf.bottom + 20, scrollView.width-40, 30)];
            psw2Tf.placeholder = @"请重复密码";
            psw2Tf.keyboardType = UIKeyboardTypeDefault;
            psw2Tf.borderStyle = UITextBorderStyleRoundedRect;
            psw2Tf.secureTextEntry = YES;
            psw2Tf.delegate = self;
            psw2Tf.font = [UIFont systemFontOfSize:14];
            [scrollView addSubview:psw2Tf];
            
            _registBtn = [self createCustomBtnWithFrame:CGRectMake(scrollView.width + 40, psw2Tf.bottom +40, bgView.width- 80, 30) title:@"完成注册" bgColor:GoldColor titleColor:[UIColor darkGrayColor] titleFont:14];
            [_registBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:_registBtn];
            
            
        }else{
            loginPhoneTf = [[UITextField alloc] initWithFrame:CGRectMake(scrollView.width*2 + 20, 30, scrollView.width-40, 30)];
            loginPhoneTf.placeholder = @"请输入手机号码";
            loginPhoneTf.keyboardType = UIKeyboardTypeNumberPad;
            loginPhoneTf.borderStyle = UITextBorderStyleRoundedRect;
            loginPhoneTf.delegate = self;
            loginPhoneTf.text = @"18173719361";
            loginPhoneTf.font = [UIFont systemFontOfSize:14];
            [scrollView addSubview:loginPhoneTf];
            
            loginPswTf = [[UITextField alloc] initWithFrame:CGRectMake(scrollView.width*2 + 20, loginPhoneTf.bottom + 20, scrollView.width-40, 30)];
            loginPswTf.placeholder = @"请输入密码";
            loginPswTf.keyboardType = UIKeyboardTypeDefault;
            loginPswTf.borderStyle = UITextBorderStyleRoundedRect;
            loginPswTf.secureTextEntry = YES;
            loginPswTf.delegate = self;
            loginPswTf.text = @"123456";
            loginPswTf.font = [UIFont systemFontOfSize:14];
            [scrollView addSubview:loginPswTf];
            
            _loginBtn = [self createCustomBtnWithFrame:CGRectMake(scrollView.width*2 + 40, loginPswTf.bottom +40, bgView.width- 80, 30) title:@"登录" bgColor:GoldColor titleColor:[UIColor darkGrayColor] titleFont:14];
            [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:_loginBtn];
            
            _forgetBtn = [self createCustomBtnWithFrame:CGRectMake(scrollView.width*2 + 40, _loginBtn.bottom +20, bgView.width- 80, 30) title:@"忘记密码?" bgColor:[UIColor whiteColor] titleColor:[UIColor darkGrayColor] titleFont:14];
            [_forgetBtn addTarget:self action:@selector(forgetBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:_forgetBtn];
        }
    }
}

//点击关闭
- (void)clickCloseAction:(UIButton *)sender{
    [self dismiss];
}

//点击登录按钮
- (void)clickLogin:(UIButton *)sender{
    sender.selected =YES;
    registBtn.selected = NO;
    [scrollView setContentOffset:CGPointMake(scrollView.width, 0) animated:NO];
    [scrollView setContentOffset:CGPointMake(scrollView.width*2, 0) animated:YES];
    [UIView animateWithDuration:0.5f animations:^{
        sclLable.centerX = loginBtn.centerX;
    }];
}

//点击注册按钮
- (void)clickRegist:(UIButton *)sender{
    sender.selected =YES;
    loginBtn.selected = NO;
    [scrollView setContentOffset:CGPointMake(scrollView.width, 0) animated:NO];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [UIView animateWithDuration:0.5f animations:^{
        sclLable.centerX = registBtn.centerX;
    }];
}

//点击获取验证码
- (void)clickYzmBtn:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(loginAlterView:didClickYzmButtonWithPhone:)]) {
        [self.delegate loginAlterView:self didClickYzmButtonWithPhone:phoneTf.text];
    }
}

//注册
- (void)registerAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(loginAlterView:didClickRegisteButtonWithPhone:WithPassword:WithYzm:WithDePassword:)]) {
        [self.delegate loginAlterView:self didClickRegisteButtonWithPhone:phoneTf.text WithPassword:pswTf.text WithYzm:yzmTf.text WithDePassword:psw2Tf.text];
    }
}

//点击下一步
- (void)clickNextBtn:(UIButton *)sender{
    [scrollView setContentOffset:CGPointMake(scrollView.width, 0) animated:YES];
}

//登录
- (void)loginAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(loginAlterView:didClickLoginButtonWithPhone:WithPassword:)]) {
        [self.delegate loginAlterView:self didClickLoginButtonWithPhone:loginPhoneTf.text WithPassword:loginPswTf.text];
    }
}

//忘记密码
- (void)forgetBtnAction:(UIButton *)sender{
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(loginAlterView:didClickForgetButtonWithPhone:)]) {
        [self.delegate loginAlterView:self didClickForgetButtonWithPhone:loginPhoneTf.text];
    }
}


- (void)showInView:(UIView *)view {
    [view addSubview:self];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismiss {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        _contentView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}



@end
