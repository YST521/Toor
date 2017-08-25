
//
//  ForgetTwoViewController.m
//  YouxiniFood
//
//  Created by 何青 on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "ForgetTwoViewController.h"
#import "CommonMethods.h"

@interface ForgetTwoViewController ()<UITextFieldDelegate>
{
    UITextField *psw1;
    UITextField *psw2;
}
@end

@implementation ForgetTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置登录密码";
    [self initUI];
}


- (void)initUI{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SceneWidth, 45)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *Lable1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 45)];
    Lable1.text = @"1、验证手机";
    Lable1.font  = [UIFont systemFontOfSize:14];
    Lable1.textColor = [UIColor grayColor];
    [bgView addSubview:Lable1];
    
    UILabel *Lable2 = [[UILabel alloc] initWithFrame:CGRectMake(Lable1.right+5, 0, 20, 45)];
    Lable2.text = @">>";
    Lable2.font  = [UIFont systemFontOfSize:14];
    Lable2.textColor = [UIColor grayColor];
    [bgView addSubview:Lable2];
    
    UILabel *Lable3 = [[UILabel alloc] initWithFrame:CGRectMake(Lable2.right+5, 0, 80, 45)];
    Lable3.text = @"2、设置密码";
    Lable3.font  = [UIFont systemFontOfSize:14];
    Lable3.textColor = NaTitleColor;
    [bgView addSubview:Lable3];
    
    UIView *v  = [[UIView alloc] initWithFrame:CGRectMake(0, bgView.bottom + 8, SceneWidth, 45)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
    psw1 = [[UITextField alloc] initWithFrame:CGRectMake( 20, 5, SceneWidth-40, 35)];
    psw1.placeholder = @"请设置密码（字母+数字，6位以上）";
    psw1.keyboardType = UIKeyboardTypeDefault;
    psw1.secureTextEntry = YES;
    psw1.delegate = self;
    psw1.font = [UIFont systemFontOfSize:14];
    [v addSubview:psw1];
    
    UIView *line  = [[UIView alloc] initWithFrame:CGRectMake(0, v.bottom, SceneWidth, LineWidth)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:line];
    
    v  = [[UIView alloc] initWithFrame:CGRectMake(0, line.bottom, SceneWidth, 45)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
    psw2 = [[UITextField alloc] initWithFrame:CGRectMake( 20, 5, SceneWidth-40, 35)];
    psw2.placeholder = @"请重复密码";
    psw2.keyboardType = UIKeyboardTypeDefault;
    psw2.secureTextEntry = YES;
    psw2.delegate = self;
    psw2.font = [UIFont systemFontOfSize:14];
    [v addSubview:psw2];
    
    UIButton *loginBtn = [self createCustomBtnWithFrame:CGRectMake(20, v.bottom + 30, SceneWidth- 40 , 40) title:@"修改完成" bgColor:[UIColor whiteColor] titleColor:[UIColor darkGrayColor] titleFont:16];
    loginBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    loginBtn.layer.borderWidth = 0.3;
    loginBtn.layer.cornerRadius = CardLayerCornerRadius;
    loginBtn.clipsToBounds = YES;
    [loginBtn addTarget:self action:@selector(clickLoginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}

- (void)clickLoginBtnAction:(UIButton *)sender{
    
    if (![CommonMethods judgePassWordLegal:psw1.text] ) {
        psw1.text = nil;
        psw2.text = nil;
        [psw1 becomeFirstResponder];
        [self showTipInfo:@"密码格式不正确，请重新输入!"];
        return;
    }
    
    if (![psw1.text isEqualToString:psw2.text]) {
        psw2.text = nil;
        [psw2 becomeFirstResponder];
        [self showTipInfo:@"两次输入的密码不一致!"];
        return;
    }
    [self showLoadView];
    WeakSelf;
    [APIHelper requestWithUrl:@"/app/resetpassword" pramas:@{@"password":psw1.text} CompletionBlock:^(BaseApiResult *result) {
        [wSelf closeLoadView];
        if (result.rspResult == 1) {
            NSDictionary *userDic = @{@"phone":_phoneStr,@"psw":psw1.text};
            [[NSNotificationCenter defaultCenter] postNotificationName:UserChangePswNotification object:userDic];
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        }else{
            [wSelf showTipInfo:result.message];
        }
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
