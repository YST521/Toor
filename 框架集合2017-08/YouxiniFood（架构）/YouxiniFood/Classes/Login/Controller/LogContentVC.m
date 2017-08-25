//
//  LoginContentVC.m
//  YouxiniFood
//
//  Created by 何青 on 2017/7/29.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "LogContentVC.h"
#import "ForgetViewController.h"
#import "RegsitOneViewController.h"
#import "APIHelper.h"

@interface LogContentVC ()<UITextFieldDelegate>
{
    UITextField *phoneTf,*pswTf;
    UIButton *loginBtn;
}
@end

@implementation LogContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveRegisterNotice:) name:UserRegisterNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveRegisterNotice:) name:UserChangePswNotification object:nil];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)initUI{
    
    
    
    UIView *v  = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SceneWidth, 45)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
    phoneTf = [[UITextField alloc] initWithFrame:CGRectMake( 20, 5, SceneWidth-40, 35)];
    phoneTf.placeholder = @"请输入您的手机号码";
    phoneTf.keyboardType = UIKeyboardTypePhonePad;
    phoneTf.delegate = self;
    phoneTf.font = [UIFont systemFontOfSize:14];
    [v addSubview:phoneTf];
    
    UIView *line  = [[UIView alloc] initWithFrame:CGRectMake(0, v.bottom, SceneWidth, LineWidth)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:line];
    
    v  = [[UIView alloc] initWithFrame:CGRectMake(0, line.bottom, SceneWidth, 45)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
    pswTf = [[UITextField alloc] initWithFrame:CGRectMake( 20, 5, SceneWidth-40, 35)];
    pswTf.placeholder = @"请输入登录密码";
    pswTf.keyboardType = UIKeyboardTypeDefault;
    pswTf.secureTextEntry = YES;
    pswTf.delegate = self;
    pswTf.font = [UIFont systemFontOfSize:14];
    [v addSubview:pswTf];
    
    loginBtn = [self createCustomBtnWithFrame:CGRectMake(20, v.bottom + 30, SceneWidth- 40 , 40) title:@"登录" bgColor:[UIColor whiteColor] titleColor:[UIColor darkGrayColor] titleFont:16];
    loginBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    loginBtn.layer.borderWidth = 0.3;
    loginBtn.layer.cornerRadius = CardLayerCornerRadius;
    loginBtn.clipsToBounds = YES;
    [loginBtn addTarget:self action:@selector(clickLoginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *registeBtn = [self createCustomBtnWithFrame:CGRectMake(20, loginBtn.bottom + 10, (SceneWidth - 40)/2, 30) title:@"快速注册" bgColor:[UIColor clearColor] titleColor:[UIColor grayColor] titleFont:14];
    registeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [registeBtn addTarget:self action:@selector(clickRegistBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registeBtn];
    
    UIButton *forgetBtn = [self createCustomBtnWithFrame:CGRectMake(registeBtn.right, loginBtn.bottom + 10, (SceneWidth - 40)/2, 30) title:@"忘记密码" bgColor:[UIColor clearColor] titleColor:[UIColor grayColor] titleFont:14];
    forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgetBtn addTarget:self action:@selector(clickForgetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults] ;
    NSString *phoneStr = [userDefault objectForKey:@"iFoodName"];
    NSString *pswStr = [userDefault objectForKey:@"iFoodPassword"];
    if (phoneStr ) {
        phoneTf.text = phoneStr;
    }
    if (pswStr) {
        pswTf.text = pswStr;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == pswTf) {
        [self clickLoginBtnAction:loginBtn];
    }
    return YES;
}

//跳转到主页
- (void)clickLoginBtnAction:(UIButton *)sender{
    NSError *err = nil;
    NSString *patternTel = @"^1[0-9]{10}$";
    NSRegularExpression *TelExp = [NSRegularExpression regularExpressionWithPattern:patternTel options:NSRegularExpressionCaseInsensitive error:&err];
    NSTextCheckingResult * isMatchTel = [TelExp firstMatchInString:phoneTf.text options:0 range:NSMakeRange(0, [phoneTf.text length])];
    if (! isMatchTel) {
        [self showTipInfo:@"请输入正确的手机号"];
        return;
    }
    if ([pswTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [self showTipInfo:@"请输入密码"];
        return;
    }
    
    WeakSelf;
    [wSelf showLoadView];
    [APIHelper requestWithUrl:@"/app/signin" pramas:@{@"mobile":phoneTf.text,@"password":pswTf.text} CompletionBlock:^(BaseApiResult *result) {
        [wSelf closeLoadView];
        if (result.rspResult == 1) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:phoneTf.text forKey:@"iFoodName"];
            [userDefaults setObject:pswTf.text forKey:@"iFoodPassword"];
            [userDefaults synchronize];
            MainTabBarController*rootTabar= [[MainTabBarController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController = rootTabar;
            [[UIApplication sharedApplication] keyWindow].rootViewController =rootTabar;
        }else{
            [wSelf showTipInfo:result.message];
        }
    }];
  
}

- (void)clickForgetBtn:(UIButton *)sender{
    ForgetViewController *vc = [ForgetViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickRegistBtn:(UIButton *)sender{
    RegsitOneViewController *vc = [RegsitOneViewController new];
    [self.navigationController  pushViewController:vc animated:YES];
}

#pragma mark - UserRegisterNotification
- (void)receiveRegisterNotice:(NSNotification *)not{
    NSLog(@"注册收到的通知:%@",not.object);
    NSDictionary *dic = not.object;
    phoneTf.text = dic[@"phone"];
    pswTf.text = dic[@"psw"];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
