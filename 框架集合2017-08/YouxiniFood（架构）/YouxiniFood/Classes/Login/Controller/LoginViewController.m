//
//  LoginViewController.m
//  YouxiniFood
//
//  Created by yst911521 on 2017/7/26.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginAlterView.h"
#import "LogContentVC.h"

@interface LoginViewController ()<loginViewDelegate>
{
    LoginAlterView *_loginView;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight)];
    imgView.image = [UIImage imageNamed:@"bg_denglu"];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    [self.view addSubview:imgView];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, SceneHeight-50, SceneWidth, 0.3)];
    line.backgroundColor = NaTitleColor;
    [self.view addSubview:line];
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SceneHeight - 49, SceneWidth, 49)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    CGFloat buttonW = SceneWidth / 3;
    NSArray *titleArr = @[@"订餐.吃饭",@"智慧生活",@"我的"];
    NSArray *imgArr = @[@"icon_dingcan_xuanzhong",@"icon_zihuishenghuo",@"icon_wode"];
    for (int i = 0; i<3; i++) {
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(buttonW*i,bgView.height - 15, buttonW, 13)];
        lb.textColor = NaTitleColor;
        lb.text = titleArr[i];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont systemFontOfSize:10];
        [bgView addSubview:lb];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(buttonW*i, 8, 25, 25)];
        imgView.image = [UIImage imageNamed:imgArr[i]];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [bgView addSubview:imgView];
        imgView.centerX = lb.centerX;
        
        UIButton *loginBtn = [[UIButton alloc] initWithFrame: CGRectMake(buttonW*i, 0, buttonW, 49)];
        loginBtn.backgroundColor = [UIColor clearColor];
        [loginBtn addTarget:self action:@selector(clickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:loginBtn];
    }
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 80, 150)];
    loginBtn.backgroundColor = [UIColor clearColor];
    loginBtn.center = self.view.center;
    [loginBtn addTarget:self action:@selector(clickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)clickLoginBtn:(UIButton *)sender {
    
    LogContentVC *vc = [LogContentVC new];
    [self.navigationController pushViewController:vc animated:YES];
//    _loginView = [[LoginAlterView alloc] initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight)];
//    _loginView.delegate = self;
//    [_loginView showInView:self.view];
}

#pragma mark - loginViewDelegate
- (void)loginAlterView:(LoginAlterView *)loginView didClickForgetButtonWithPhone:(NSString *)phone{
    NSLog(@"忘记密码-------------phone = %@",phone);
}

- (void)loginAlterView:(LoginAlterView *)loginView didClickLoginButtonWithPhone:(NSString *)phone WithPassword:(NSString *)password{
    if(phone.length == 0){
        [self showTipInfo:@"请输入电话号码"];
        return;
    }
    if(password.length == 0){
        [self showTipInfo:@"请输入密码"];
        return;
    }
    NSLog(@"登录-------------phone = %@，password = %@",phone,password);
   
}

- (void)loginAlterView:(LoginAlterView *)loginView didClickRegisteButtonWithPhone:(NSString *)phone WithPassword:(NSString *)password WithYzm:(NSString *)yzmStr WithDePassword:(NSString *)dePsw{
    if(phone.length == 0){
        [self showTipInfo:@"请输入电话号码"];
        return;
    }
    if(yzmStr.length == 0){
        [self showTipInfo:@"请输入验证码"];
        return;
    }
    if(password.length == 0){
        [self showTipInfo:@"请输入密码"];
        return;
    }
    if(dePsw.length == 0){
        [self showTipInfo:@"请确认您的密码"];
        return;
    }
    if(![dePsw isEqualToString:password]){
        [self showTipInfo:@"两次输入密码不一致"];
        return;
    }
    NSLog(@"注册-------------phone = %@,password = %@,yzmStr = %@,dePsw = %@",phone,password,yzmStr,dePsw);
}

- (void)loginAlterView:(LoginAlterView *)loginView didClickYzmButtonWithPhone:(NSString *)phone{
    if(phone.length == 0){
        [self showTipInfo:@"请输入电话号码"];
        return;
    }
    NSLog(@"验证码-------------phone = %@",phone);
}


@end
