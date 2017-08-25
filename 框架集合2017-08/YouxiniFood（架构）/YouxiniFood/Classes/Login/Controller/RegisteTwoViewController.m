//
//  RegisteTwoViewController.m
//  YouxiniFood
//
//  Created by 何青 on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "RegisteTwoViewController.h"
#import "CommonMethods.h"

@interface RegisteTwoViewController ()<UITextFieldDelegate>
{
    UITextField *pswTf1;
    UITextField *pswTf2;
}
@end

@implementation RegisteTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置登录密码";
    [self initUI];
}

- (void)initUI{
    UIView *v  = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SceneWidth, 45)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
    pswTf1 = [[UITextField alloc] initWithFrame:CGRectMake( 20, 5, SceneWidth-40, 35)];
    pswTf1.placeholder = @"请设置密码（字母+数字，6位以上）";
    pswTf1.keyboardType = UIKeyboardTypeDefault;
    pswTf1.secureTextEntry = YES;
    pswTf1.delegate = self;
    pswTf1.font = [UIFont systemFontOfSize:14];
    [v addSubview:pswTf1];
    
    UIView *line  = [[UIView alloc] initWithFrame:CGRectMake(0, v.bottom, SceneWidth, LineWidth)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:line];
    
    v  = [[UIView alloc] initWithFrame:CGRectMake(0, line.bottom, SceneWidth, 45)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
    pswTf2 = [[UITextField alloc] initWithFrame:CGRectMake( 20, 5, SceneWidth-40, 35)];
    pswTf2.placeholder = @"请重复密码";
    pswTf2.keyboardType = UIKeyboardTypeDefault;
    pswTf2.secureTextEntry = YES;
    pswTf2.delegate = self;
    pswTf2.font = [UIFont systemFontOfSize:14];
    [v addSubview:pswTf2];
    
    UIButton *registBtn = [self createCustomBtnWithFrame:CGRectMake(20, v.bottom + 30, SceneWidth- 40 , 40) title:@"完成注册" bgColor:[UIColor whiteColor] titleColor:[UIColor darkGrayColor] titleFont:16];
    registBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    registBtn.layer.borderWidth = 0.3;
    registBtn.layer.cornerRadius = CardLayerCornerRadius;
    registBtn.clipsToBounds = YES;
    [registBtn addTarget:self action:@selector(clickRegisteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
}

- (void)clickRegisteBtnAction:(UIButton *)sender{
    
    if (![CommonMethods judgePassWordLegal:pswTf1.text] ) {
        pswTf1.text = nil;
        pswTf2.text = nil;
        [pswTf1 becomeFirstResponder];
        [self showTipInfo:@"密码格式不正确，请重新输入!"];
        return;
    }
    
    if (![pswTf1.text isEqualToString:pswTf2.text]) {
        pswTf2.text = nil;
        [pswTf2 becomeFirstResponder];
        [self showTipInfo:@"两次输入的密码不一致!"];
        return;
    }
    [self showLoadView];
    WeakSelf;
    [APIHelper requestWithUrl:@"/app/register" pramas:@{@"password":pswTf1.text,@"vcode":_yzmStr} CompletionBlock:^(BaseApiResult *result) {
        [wSelf closeLoadView];
        if (result.rspResult == 1) {
            NSDictionary *userDic = @{@"phone":_phoneStr,@"psw":pswTf1.text};
            [[NSNotificationCenter defaultCenter] postNotificationName:UserRegisterNotification object:userDic];
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        }else{
            [wSelf showTipInfo:result.message];
        }
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
