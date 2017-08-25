//
//  ChangeZhifuPwController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "ChangeZhifuPwController.h"
#import "InputPasswordBordView.h"
#import "ChangNewCodeController.h"

@interface ChangeZhifuPwController ()<UITextFieldDelegate,PassWordViewDelegate>{
    InputPasswordBordView *wclV;
    UILabel *alertLa ;
}



@end

@implementation ChangeZhifuPwController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self cratUI];
}

- (void)cratUI{
    
    alertLa = [[UILabel alloc]init];
    alertLa.frame = CGRectMake( 30, 30, SceneWidth-40, 40);
    alertLa.textColor = [UIColor colorWithHexStringg:@"#999999"];
    alertLa.text = @"请输入旧的支付密码，已验证身份";
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
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    [self.view endEditing:YES];
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
    
    if ([intputSreing isEqualToString:@"123456"]) {
        
         [passWord resignFirstResponder];
        
        ChangNewCodeController *newVC =[[ChangNewCodeController alloc]init];
        
        [self.navigationController pushViewController:newVC  animated:YES];
        
    }else{
        [self alertViewTitle:@"确定" alretContent:@"输入密码错误，请重新输入！"];
    }
    
   }

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(InputPasswordBordView *)passWord {
    NSLog(@"-------密码开始输入");
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
