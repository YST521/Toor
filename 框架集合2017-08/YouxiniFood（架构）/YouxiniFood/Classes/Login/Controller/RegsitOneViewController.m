//
//  RegsitOneViewController.m
//  YouxiniFood
//
//  Created by 何青 on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "RegsitOneViewController.h"
#import "RegisteTwoViewController.h"
#import "APIHelper.h"

@interface RegsitOneViewController ()<UITextFieldDelegate>
{
    UITextField *phoneTf;
    UITextField *yzmTf;
    UIButton *yzmBtn;
    NSTimer *timer;
}
@end

@implementation RegsitOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"快速注册";
    [self initUI];
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
    
    UIButton *nextBtn = [self createCustomBtnWithFrame:CGRectMake(20, v.bottom + 30, SceneWidth- 40 , 40) title:@"下一步" bgColor:[UIColor whiteColor] titleColor:[UIColor darkGrayColor] titleFont:16];
    nextBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    nextBtn.layer.borderWidth = 0.3;
    nextBtn.layer.cornerRadius = CardLayerCornerRadius;
    nextBtn.clipsToBounds = YES;
    [nextBtn addTarget:self action:@selector(clickNextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
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
    [APIHelper   requestWithUrl:@"/app/sendregmsg" pramas:@{@"mobile":phoneTf.text} CompletionBlock:^(BaseApiResult *result) {
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
    
    RegisteTwoViewController *vc = [RegisteTwoViewController new];
    vc.phoneStr = phoneTf.text;
    vc.yzmStr = yzmTf.text;
    [self.navigationController pushViewController:vc animated:YES];
}




@end
