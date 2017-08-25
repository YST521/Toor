//
//  ForgetViewController.m
//  YouxiniFood
//
//  Created by 何青 on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "ForgetViewController.h"
#import "ForgetTwoViewController.h"

@interface ForgetViewController ()<UITextFieldDelegate>
{
    UITextField *phoneTf;
    UITextField *yzmTf;
    UIButton *yzmBtn;
    NSTimer *timer;
}
@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"忘记密码";
    [self initUI];

}

- (void)initUI{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SceneWidth, 45)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *Lable1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 45)];
    Lable1.text = @"1、验证手机";
    Lable1.font  = [UIFont systemFontOfSize:14];
    Lable1.textColor = NaTitleColor;
    [bgView addSubview:Lable1];
    
    UILabel *Lable2 = [[UILabel alloc] initWithFrame:CGRectMake(Lable1.right+5, 0, 20, 45)];
    Lable2.text = @">>";
    Lable2.font  = [UIFont systemFontOfSize:14];
    Lable2.textColor = [UIColor grayColor];
    [bgView addSubview:Lable2];
    
    UILabel *Lable3 = [[UILabel alloc] initWithFrame:CGRectMake(Lable2.right+5, 0, 80, 45)];
    Lable3.text = @"2、设置密码";
    Lable3.font  = [UIFont systemFontOfSize:14];
    Lable3.textColor = [UIColor grayColor];
    [bgView addSubview:Lable3];
    
    UIView *v  = [[UIView alloc] initWithFrame:CGRectMake(0, bgView.bottom + 8, SceneWidth, 45)];
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
    
    yzmTf = [[UITextField alloc] initWithFrame:CGRectMake( 20, 5, SceneWidth-110, 35)];
    yzmTf.placeholder = @"验证码";
    yzmTf.keyboardType = UIKeyboardTypePhonePad;
    yzmTf.delegate = self;
    yzmTf.font = [UIFont systemFontOfSize:14];
    [v addSubview:yzmTf];
    
    yzmBtn = [self createCustomBtnWithFrame:CGRectMake(yzmTf.right + 10, 10, 70, 25) title:@"发送验证码" bgColor:[UIColor whiteColor] titleColor:NaTitleColor titleFont:12];
    yzmBtn.layer.borderColor = NaTitleColor.CGColor;
    yzmBtn.layer.borderWidth = 0.3;
    yzmBtn.layer.cornerRadius = CardLayerCornerRadius;
    yzmBtn.clipsToBounds = YES;
    [yzmBtn addTarget:self action:@selector(clickYzmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:yzmBtn];
    
    UIButton *loginBtn = [self createCustomBtnWithFrame:CGRectMake(20, v.bottom + 30, SceneWidth- 40 , 40) title:@"下一步" bgColor:[UIColor whiteColor] titleColor:[UIColor darkGrayColor] titleFont:16];
    loginBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    loginBtn.layer.borderWidth = 0.3;
    loginBtn.layer.cornerRadius = CardLayerCornerRadius;
    loginBtn.clipsToBounds = YES;
    [loginBtn addTarget:self action:@selector(clickNextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    timer.fireDate = [NSDate distantFuture];
    
}


static int num = 60;

- (void)timerAction:(NSTimer*)tmr
{
    [yzmBtn setTitle:[NSString stringWithFormat:@"%d秒后获取", num--] forState:UIControlStateNormal];
    if (num == 0) {
        yzmBtn.enabled = YES;
        [yzmBtn setTitle:@"获取" forState:UIControlStateNormal];
        timer.fireDate = [NSDate distantFuture];
        
        yzmBtn.width = 50;
        yzmBtn.right = SceneWidth-5;
    }
}

- (void)clickYzmBtnAction:(UIButton *)sender{
    NSError *err = nil;
    
    NSString *patternTel = @"^1[0-9]{10}$";
    NSRegularExpression *TelExp = [NSRegularExpression regularExpressionWithPattern:patternTel options:NSRegularExpressionCaseInsensitive error:&err];
    NSTextCheckingResult * isMatchTel = [TelExp firstMatchInString:phoneTf.text options:0 range:NSMakeRange(0, [phoneTf.text length])];
    if (! isMatchTel) {
        [self showTipInfo:@"请输入正确的手机号"];
        return;
    }
    
    [self showLoadView];
    WeakSelf;
    [APIHelper   requestWithUrl:@"/app/sendforgetpwdmsg" pramas:@{@"mobile":phoneTf.text} CompletionBlock:^(BaseApiResult *result) {
        [wSelf closeLoadView];
        if (result.rspResult == 1) {
            num = 60;
            yzmBtn.enabled = NO;
            yzmBtn.width = 80;
            yzmBtn.right = SceneWidth-5;
            timer.fireDate = [NSDate date];
        }else{
            [wSelf showTipInfo:result.message];
        }
    }];
}

- (void)clickNextBtnAction:(UIButton *)sender{
    if ([yzmTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [self showTipInfo:@"请输入验证码"];
        return;
    }
    
    [self showLoadView];
    WeakSelf;
    [APIHelper requestWithUrl:@"/app/validateforgetpwdmsg" pramas:@{@"vcode":yzmTf.text} CompletionBlock:^(BaseApiResult *result) {
        [wSelf closeLoadView];
        if (result.rspResult == 1) {
            ForgetTwoViewController *vc = [ForgetTwoViewController new];
            vc.phoneStr = phoneTf.text;
            vc.codeStr = yzmTf.text;
            [wSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [wSelf showTipInfo:result.message];
        }
    }];
   
}



@end
