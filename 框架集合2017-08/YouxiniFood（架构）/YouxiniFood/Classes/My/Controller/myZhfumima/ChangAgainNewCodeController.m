//
//  ChangAgainNewCodeController.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/3.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "ChangAgainNewCodeController.h"
#import "MyZhifumimaController.h"

#import "InputPasswordBordView.h"

@interface ChangAgainNewCodeController ()<UITextFieldDelegate,PassWordViewDelegate>{
    InputPasswordBordView *wclV;
    UILabel *alertLa ;
    
    UIButton * doneBtn;
}



@end

@implementation ChangAgainNewCodeController


- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"修改密码";
    [self cratUI];
    
    
   }

- (void)cratUI{
    
    alertLa = [[UILabel alloc]init];
    alertLa.frame = CGRectMake(30, 30, SceneWidth-40, 40);
    alertLa.textColor = [UIColor colorWithHexStringg:@"#999999"];
    alertLa.text = @"请再次填写确认";
    alertLa.numberOfLines = 2;
    alertLa.font =[UIFont systemFontOfSize:16];
    [self.view addSubview:alertLa];
    
    //密码框
    wclV = [[InputPasswordBordView alloc]init];
    
    
    if (SceneWidth>320) {
        wclV.frame = CGRectMake(0, 0, SceneWidth/3*2, (SceneWidth/3*2)/6);
        wclV.center = CGPointMake(SceneWidth/2, 120);
        wclV.squareWidth = (SceneWidth/3*2)/ 6;
    } else {
        wclV.frame = CGRectMake(0, 0, SceneWidth/4*3, ( SceneWidth/4*3)/6);
        wclV.center = CGPointMake(SceneWidth/2, 100);
        wclV.squareWidth = (SceneWidth/4*3)/ 6;
    }
    
    wclV.backgroundColor=[UIColor greenColor];
    [self.view addSubview:wclV];
    wclV.passWordNum = 6;
    
    //进入页面自动弹出键盘
    [wclV becomeFirstResponder];
    
    wclV.pointRadius = 6;
    wclV.pointColor = [UIColor blackColor];
    wclV.rectColor =[UIColor lightGrayColor];
    wclV.pointColor = [UIColor blackColor];
    //    wclV.textStore = @"123456";
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
- (void)doneBtnClickAction:(UIButton*)sender{

//    MyZhifumimaController *myZhifuVC =[[MyZhifumimaController alloc]init];
//
//    [self.navigationController pushViewController:myZhifuVC animated:YES];
    //跳转回支付密码修改页面
    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 4] animated:YES];
   
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
    
    if ([self.userNewPassword isEqualToString:intputSreing]) {
       
        
    }else{
        [self alertViewTitle:@"确定" alretContent:@"两次输入密码不相同，请重新输入！"];
    }

    
}

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(InputPasswordBordView *)passWord {
    NSLog(@"-------密码开始输入");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
