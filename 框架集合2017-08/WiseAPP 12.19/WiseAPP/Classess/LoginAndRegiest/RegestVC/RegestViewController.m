//
//  RegestViewController.m
//  WiseAPP
//
//  Created by app on 16/10/16.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "RegestViewController.h"
#import "RegestView.h"
#import "WuGuanRegestViewController.h"
#import "WorkTypeViewController.h"
#import "GetcodeModel.h"
#import "LoginViewController.h"
#import "AgreementViewController.h"
#import "ComparCodeModel.h"

@interface RegestViewController ()<UINavigationControllerDelegate,UITextFieldDelegate>
@property(nonatomic,strong)RegestView*regestView;
@property(nonatomic,strong)NSString*nextType;
@property(nonatomic,strong)NSMutableDictionary*dataDic;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,assign)BOOL popAsLoginFlag;
@property(nonatomic,assign)BOOL flagAgress;
@property(nonatomic,assign)NSInteger codeRequest;
@property(nonatomic,assign)NSInteger selectAgreement;
@property(nonatomic,assign)NSInteger codeInt;
@property(nonatomic,strong)GetcodeModel* getcodeModel;
@property(nonatomic,strong)ComparCodeModel* comparaModel;
@property(nonatomic,assign)NSInteger comparCodeType;

@end

@implementation RegestViewController
-(void)loadView{

    //替换view
    self.regestView =[[RegestView alloc]initWithFrame:UIScreenBpunds];
    self.view = self.regestView;
}

-(void)viewWillAppear:(BOOL)animated{

 self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBarHidden = NO;

    self.comparCodeType =1;
    self.navigationController.delegate = self;
    self.nextType = @"workType";
    self.dataDic =[NSMutableDictionary dictionary];
    self.dataArray =[NSMutableArray array];
    self.selectAgreement = 1;
    self.codeInt = 1;
    self.codeRequest = 1;
    
    self.regestView.userPassword.delegate = self;
    self.regestView.userCode.delegate = self;
    self.regestView.userPsAgain.delegate = self;
    
    self.getcodeModel =[GetcodeModel new];
    self.comparaModel =[ComparCodeModel new];
    [self creatUI];
    
  
}

-(void)creatUI{
    [ [NSNotificationCenter defaultCenter]addObserver:self selector:@selector(compareCode)name:UITextFieldTextDidChangeNotification object:self.regestView.userCode];

    [self.regestView.backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.regestView.typeBtn addTarget:self action:@selector(typeAction:) forControlEvents:(UIControlEventTouchUpInside)];
     [self.regestView.viditionBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:(UIControlEventTouchUpInside)];
     [self.regestView.nextBtn addTarget:self action:@selector(nextPageAction:) forControlEvents:(UIControlEventTouchUpInside)];
     [self.regestView.firstEyeBtn addTarget:self action:@selector(firstEye:) forControlEvents:(UIControlEventTouchUpInside)];
     [self.regestView.secendEyeBtn addTarget:self action:@selector(secentEye:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.regestView.agreeBtn addTarget:self action:@selector(aggressAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.regestView.agreeContentBtn addTarget:self action:@selector(agreeAction:) forControlEvents:(UIControlEventTouchUpInside)];

}
-(void)compareCode{
    if(self.regestView.userCode.text.length ==6){
    [self requestcomparaCode];
    }


}

#pragma mark ===Action==------
//物管家协议
-(void)agreeAction:(UIButton*)sender{
    
    AgreementViewController*agreeVC=[[AgreementViewController alloc]init];
    [self.navigationController pushViewController:agreeVC animated:YES];

}

//-(void)viewDidDisappear:(BOOL)animated{
//    
//    //点击登录离开页面时
//    if (YES == _popAsLoginFlag) {
//        [self.navigationController popToRootViewControllerAnimated:NO];
//    }
//    
//    
//}

//返回按钮
-(void)backBtnAction:(UIButton*)sender{
 

   [self.navigationController popViewControllerAnimated:YES];
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        if ([controller isKindOfClass:[ LoginViewController class]]) {
            
           LoginViewController *loginVC =(LoginViewController *)controller;
          [self.navigationController popToViewController:loginVC animated:YES];
        }
    }
    
}

// 类型选择
-(void)typeAction:(UIButton*)sendr{
    
    self.regestView.typeBtn.selected = !self.regestView.typeBtn.selected;
    if (self.regestView.typeBtn.selected == YES) {

  
        self.nextType= @"NoWork";
    }else{
           self.nextType = @"workType";
        
    }
    

    

}
//获取验证码
-(void)getCodeAction:(UIButton*)sender{
    
  if (self.getcodeModel.reultCode  == 101) {
      [self AlerVCtitleString:@"提示" messageString:@"验证码请求失败，或还在有效期" doneString:@"请重新输入"];
     
    } else {
         [self getCodeRequest];
    }
    
}
-(void)getCodeRequest{

    //验证码
    if ([self valiMobile:self.regestView.userPhoneNum.text]) {

        [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"fetch_sms_code"] Token:nil parmpar:@{@"telephone": self.regestView.userPhoneNum.text} succeed:^(id data) {
            //            //通知主线程刷新
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //
                            [self.getcodeModel setValuesForKeysWithDictionary:data];
                      
            
                            if (self.getcodeModel.reultCode != 0) {
                                [self AlerVCtitleString:@"提示" messageString:@"请求验证码失败，请重新请求" doneString:@"请重新输入"];
                            }else if (self.getcodeModel.reultCode == 101){
                            [self AlerVCtitleString:@"提示" messageString:@"验证码在一分内有效，请勿重复请求" doneString:@"请输入验证码"];
                            }
                        });
            //
            
        } failure:^(NSError *error) {
            
        }];
    }else{
        [self AlerVCtitleString:@"提示" messageString:@"手机号格式不对，请重新输入" doneString:@"请重新输入"];
    }

}


//进入下一页面
-(void)nextPageAction:(UIButton*)sendr{
    if(self.regestView.userPhoneNum.text.length !=0){
        
        if (self.comparCodeType ==2) {
              [self comparepassword];
        }else{
        
        [self AlerVCtitleString:@"提示" messageString:@"您的手机号没进行验证，或验证失败，请点击获取验证码，填入验证码进行验证" doneString:@"重新验证"];
        }
        
 
   
    
    }else{
    
    [self AlerVCtitleString:@"提示" messageString:@"手机号码不能为空，请重新输入" doneString:@"请重新输入"];
    }
  }

//获取比较验证码
-(void)requestcomparaCode{

    NSDictionary* param =[NSDictionary dictionary];
    if ([self.getcodeModel.reultMessage isEqualToString:@"成功"]) {
         param =@{@"token":self.getcodeModel.data,@"verify":self.regestView.userCode.text};
    } else {
        //垃圾参数防止崩溃
      param =@{@"token":@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE0NzkxMzU2MTIsIm5iZiI6MTQ3OTEzNTYxMywiZXhwIjoxNDc5MTM1NjczLCJkYXRhIjp7ImNvZGUiOiIyMTU2NDUifX0.ULQ7spRGvduzjPDBceCZaZyzCcgfpzAQdtzMGplA3JE",@"verify":self.regestView.userCode.text};
     NSLog(@"999");
    }

    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manger.requestSerializer setValue:self.getcodeModel.data forHTTPHeaderField:@"token"];
    
    //NSString*url=@"http://118.178.88.132:8000/api/fetch_sms_code/verification";
   
    
    [manger POST:[self urlRequestChildreurl:@"fetch_sms_code/verification"]  parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
   
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [self.comparaModel setValuesForKeysWithDictionary:responseObject];
        
            if (self.comparaModel.resultCode ==0) {
                
                self.comparCodeType =2;
                
            }else if (self.comparaModel.resultCode ==1){
            
           [self AlerVCtitleString:@"提示" messageString:@"验证失败，请重新填写" doneString:@"请重新输入"];
            
            }
            
        });

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
        
    }];
    
  
    
}
//!!!!!!!
//-(void)comparacode{
//
//    //判断是否请求验证码
//    //请求需要改为0
//    if( [self.comparaModel.resultMessage isEqualToString:@"成功"]){
//        [self comparepassword];
//        
//    }else if([self.comparaModel.resultMessage isEqualToString:@"错误信息"]){
//   [self AlerVCtitleString:@"提示" messageString:@"验证码错误，请重新填写" doneString:@"请重新输入"];
//        // [self comparepassword];
//
//    }
//}


-(void)comparepassword{
//    //判断两次密码不一致
    if ([self.regestView.userPassword.text isEqual:self.regestView.userPsAgain.text]&&![self.regestView.userPassword.text isEqual: @" "]) {
        [self aggrement];
        }else{
            [self AlerVCtitleString:@"提示" messageString:@"两次密码不一致" doneString:@"请重新输入"];
        }


}
-(void)aggrement{

    //同意协议
    if (self.selectAgreement==0) {
        //根据type判断
        if([self.nextType isEqualToString:@"workType"]){
            
            WorkTypeViewController*workVC=[[WorkTypeViewController alloc]init];
            workVC.wgPhoneNum = self.regestView.userPhoneNum.text;
            workVC.wgPassword = self.regestView.userPsAgain.text;
            
            [self.navigationController pushViewController:workVC animated:YES];
        }else{
            WuGuanRegestViewController*wuguanVC =[[WuGuanRegestViewController alloc]init];
            wuguanVC.wgPhoneNum = self.regestView.userPhoneNum.text;
            wuguanVC.wgPassword = self.regestView.userPsAgain.text;
            [self.navigationController pushViewController:wuguanVC animated:YES];
        }
    }else{
        [self AlerVCtitleString:@"提示" messageString:@"请同意物管家协议" doneString:@"请重新输入"];
    }

}


//看密码
-(void)firstEye:(UIButton*)sender{
    self.regestView.firstEyeBtn.selected = !self.regestView.firstEyeBtn.selected;
    if (self.regestView.firstEyeBtn.selected == YES) {
        self.regestView.userPassword.secureTextEntry = NO;
    }else{
        self.regestView.userPassword.secureTextEntry = YES;
    }
}

-(void)secentEye:(UIButton*)sender{


    self.regestView.secendEyeBtn.selected =  ! self.regestView.secendEyeBtn.selected;
    
    if (self.regestView.secendEyeBtn.selected == YES) {
       self.regestView.userPsAgain.secureTextEntry = NO;
    }else{
       self.regestView.userPsAgain.secureTextEntry = YES;
    }
    


}
//同意协议
-(void)aggressAction:(UIButton*)ssender{
    YSTLogFunc
    self.regestView.agreeBtn.selected  = !self.regestView.agreeBtn.selected;
    
    if (self.regestView.agreeBtn.selected == YES) {
        self.selectAgreement = 0;
    }else{
       self.selectAgreement = 1;
     
    }


}



#pragma mark - UINavigationControllerDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  
    [self.regestView.userCode resignFirstResponder];
    [self.regestView.userPassword resignFirstResponder];
    [self.regestView.userPsAgain resignFirstResponder];

    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.regestView endEditing:YES];
}

-(void)AlerVCtitleString:(NSString*)title messageString:(NSString*)message doneString:(NSString*)doneString{
    
    UIAlertController*alerVC= [UIAlertController alertControllerWithTitle:title message:message preferredStyle:( UIAlertControllerStyleAlert)];
    UIAlertAction*al= [UIAlertAction actionWithTitle:doneString style:(UIAlertActionStyleDefault) handler:nil];
    [alerVC addAction:al];
    [self presentViewController:alerVC animated:YES completion:nil];
    
}
//判断手机号码格式是否正确  正则表达式
-(BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
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
