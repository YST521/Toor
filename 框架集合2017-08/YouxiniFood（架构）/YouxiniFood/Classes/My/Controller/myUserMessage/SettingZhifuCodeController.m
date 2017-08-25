//
//  SettingZhifuCodeController.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/2.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "SettingZhifuCodeController.h"
#import "InputPasswordBordView.h"
#import "AgainZhifuCodeController.h"


@interface SettingZhifuCodeController ()<PassWordViewDelegate>{

    InputPasswordBordView *wclV;
    UILabel *alertLa ;
}

@end

@implementation SettingZhifuCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"设置支付密码"];
    
    [self cratUI];
}

- (void)cratUI{
    
    alertLa = [[UILabel alloc]init];
    alertLa.frame = CGRectMake(20, 84, SceneWidth-40, 40);
    alertLa.textColor = [UIColor colorWithHexStringg:@"#999999"];
    alertLa.text = @"请设置支付密码，建议与银行卡取款密码相同";
    alertLa.numberOfLines = 2;
    alertLa.font =[UIFont systemFontOfSize:16];
    [self.view addSubview:alertLa];

    //密码框
    wclV = [[InputPasswordBordView alloc]init];
    //进入页面自动弹出键盘
    [wclV becomeFirstResponder];
    wclV.frame = CGRectMake(0, 0, SceneWidth/3*2, (SceneWidth/3*2)/6);
    if (SceneWidth>320) {
        wclV.center = CGPointMake(SceneWidth/2, 180);
    } else {
        wclV.center = CGPointMake(SceneWidth/2, 160);
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
  
  
    AgainZhifuCodeController *aginVC =[[AgainZhifuCodeController alloc]init];
    aginVC.firstPWStr = intputSreing;
    [self.navigationController pushViewController:aginVC animated:YES];
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
