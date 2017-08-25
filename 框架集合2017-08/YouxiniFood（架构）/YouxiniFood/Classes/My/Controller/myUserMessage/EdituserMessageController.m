//
//  EdituserMessageController.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/4.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "EdituserMessageController.h"
#import "QRbuttonOrderlPage.h"

@interface EdituserMessageController (){
    UITextField *tf;
}

@end

@implementation EdituserMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:self.naTitle];
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(msgAction:)];
    
    
    tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 74, SceneWidth, 40)];
    tf.backgroundColor = [UIColor whiteColor];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
//    tf.text = [AppData shareInstance].personCell.pyg_user_truename;
    [self.view addSubview:tf];
    
    QRbuttonOrderlPage *qrBtn =[[QRbuttonOrderlPage alloc]init];
    qrBtn.frame = CGRectMake(0, 400, SceneWidth, 60);
//    qrBtn.backgroundColor =[UIColor redColor];
    [self.view addSubview:qrBtn];
    
//    self.titleLa.text = @"早餐取餐码：0356 6666";
//    self.dateLa.text = @"有效期至：2017/07/20 13:00";
//    self.statusLa.text = @"二维码";
    qrBtn.titleLa .text =  @"早餐取餐码：0356 6666";
      qrBtn.dateLa.text = @"有效期至：2017/07/20 13:00";
    qrBtn.statusLa.text = @"二维码";
    
    [qrBtn addTarget:self action:@selector(btnaction) forControlEvents:(UIControlEventTouchUpInside)];
    
    UITextField *tt =[[UITextField alloc]init];
    tt.frame = CGRectMake(0, 600, SceneWidth, 40);
    tt.backgroundColor=[UIColor greenColor];
    [self.view addSubview:tt];
}
-(void)btnaction{
    self.view.backgroundColor=[UIColor greenColor];
}

- (void)msgAction:(UIButton*)button
{
    
    NSLog(@"################--%@",self.naTitle);
    
    if ([self.naTitle isEqualToString:@"修改姓名"]) {
        
        NSLog(@"editName --%@--%@",tf.text,self.title);
        
    }
    if ([self.naTitle isEqualToString:@"修改手机号码"]) {
        
        NSLog(@"editPhoneNum-%@",tf.text);
    }
    
    if ([self.naTitle isEqualToString:@"修改身份证号"]) {
        
        NSLog(@"editid--666-%@",tf.text);
    }
    
    //分区2
    if ([self.naTitle isEqualToString:@"修改工厂名称"]) {
        
        NSLog(@"editid--666-%@",tf.text);
    }
    if ([self.naTitle isEqualToString:@"修改工号"]) {
        
        NSLog(@"修改工号-%@",tf.text);
    }
    if ([self.naTitle isEqualToString:@"修改卡号"]) {
        
        NSLog(@"修改卡号-%@",tf.text);
    }
    
    
    [tf resignFirstResponder];
//    
//    if ([tf.text isEqualToString:@"123456"]) {
//        [self showTipInfo:@"名字没有修改"];
//        return;
//    } else if ([tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
//        [self showTipInfo:@"名字不能为空"];
//        return;
//    } else if (tf.text.length > 15) {
//        [self showTipInfo:@"名字不能长于15个文字"];
//        return;
//    }
//    
//    NSString *text = tf.text;
//    
//    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    text = [text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    
//    [self showLoadView];
//    WeakSelf;
//    [APIHelper requestWithUrl:@"/rest/v1/pyqquanzi/updateUserBaseInfo" pramas:@{@"pyg_user_truename" : text} afCompletionBlock:^(BaseApiResult *result) {
//        [this closeLoadView];
//        [this showTipInfo:result.message];
//        if (result.rspResult == 1) {
//            if ([result.data[@"checkUserBaseInfo"] boolValue]) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"checkUserBaseInfoNOtification" object:nil];
//            }
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [this.navigationController popViewControllerAnimated:YES];
//                [[AppData shareInstance].personCell setPyqData:result.data];
//            });
//        } else {
//            [this showTipInfo:result.message];
//        }
//    }];
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
