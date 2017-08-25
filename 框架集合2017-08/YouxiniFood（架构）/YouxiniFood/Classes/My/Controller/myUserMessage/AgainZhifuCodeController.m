//
//  AgainZhifuCodeController.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/3.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "AgainZhifuCodeController.h"
#import "AgainZhifuCodeController.h"
#import "MyUserMessageController.h"


@interface AgainZhifuCodeController ()<PassWordViewDelegate>{
    
    InputPasswordBordView *wclV;
    UILabel *alertLa ;
    UIButton  *doneBtn;
    NSString  *againStr;
}

@end

@implementation AgainZhifuCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"设置支付密码"];
    
    [self cratUI];
}

- (void)cratUI{
    
    alertLa = [[UILabel alloc]init];
    alertLa.frame = CGRectMake(0, 0,  SceneWidth/3*2, 40);
    alertLa.center = CGPointMake(SceneWidth/2, 90);
    alertLa.textColor = [UIColor colorWithHexStringg:@"#999999"];
    alertLa.text = @"请再次输入密码";
    alertLa.numberOfLines = 2;
    alertLa.font =[UIFont systemFontOfSize:16];
    [self.view addSubview:alertLa];
    
    //密码框
    wclV = [[InputPasswordBordView alloc]init];
    
    wclV.frame = CGRectMake(0, 0, SceneWidth/3*2, (SceneWidth/3*2)/6);
    if (SceneWidth>320) {
        wclV.center = CGPointMake(SceneWidth/2, 160);
    } else {
        wclV.center = CGPointMake(SceneWidth/2, 140);
    }
    
    wclV.backgroundColor=[UIColor greenColor];
    [self.view addSubview:wclV];
    wclV.passWordNum = 6;
    wclV.squareWidth = (SceneWidth/3*2)/6;
    wclV.pointRadius = 6;
    wclV.pointColor = [UIColor blackColor];
    wclV.rectColor =[UIColor lightGrayColor];
    wclV.pointColor = [UIColor blackColor];
    //    wclV.textStore = @"123456";
    //进入页面自动弹出键盘
    [wclV becomeFirstResponder];
    wclV.delegate =self;
    NSLog(@"*******%@",wclV.textStore);
    
    
    doneBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    doneBtn.frame = CGRectMake(0, 0, wclV.width, 45);
    doneBtn.center = CGPointMake(SceneWidth/2, CGRectGetMaxY(wclV.frame)+50);
    doneBtn.layer.cornerRadius = ButtonLayerCornerRadius;
    doneBtn.clipsToBounds = YES;
   doneBtn.layer.borderWidth = 0.3;
    doneBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
    [doneBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [doneBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
    [doneBtn setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:doneBtn];
    [doneBtn addTarget:self action:@selector(doneBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)doneBtnClickAction:(UIButton*)sender{
  
    if ([self.firstPWStr isEqualToString:againStr]) {
        
//         [self turnUpPage];
        
        //跳转回新增页面
        [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 4] animated:YES];
    }
   
    
}

-(void)turnUpPage{
    
    
    for (UIViewController*collector in self.navigationController.viewControllers) {
        if ([collector isKindOfClass:[MyUserMessageController class]]) {
           MyUserMessageController* messageVC =(MyUserMessageController*)collector;
            [self.navigationController popToViewController:messageVC animated:YES];
        }
    }
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
//    
//    AgainZhifuCodeController *aginVC =[[AgainZhifuCodeController alloc]init];
//    aginVC.firstPWStr = intputSreing;
//    [self.navigationController pushViewController:aginVC animated:YES];
    againStr = intputSreing;
    
    if (![intputSreing isEqualToString:self.firstPWStr]) {
        
        [self alertViewTitle:@"两次密码不一致，请重新设置！" alretContent:@"确定"];
    } else {
       
    }
    
    
}

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(InputPasswordBordView *)passWord {
    NSLog(@"-------密码开始输入");
}


#pragma mark -alertView

- (void)alertViewTitle:(NSString*)alertTitle alretContent:(NSString*)content{
    
    UIAlertController *alertVC =[UIAlertController alertControllerWithTitle:@"提示" message:alertTitle preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *al =[UIAlertAction actionWithTitle:content style:(UIAlertActionStyleDefault) handler:nil];
    [alertVC addAction:al];
    [self presentViewController:alertVC animated:YES completion:nil];
}


@end
