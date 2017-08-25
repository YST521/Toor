//
//  FindPasswordViewController.m
//  WiseAPP
//
//  Created by app on 16/10/16.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "FindView.h"
#import "ChangePasswordSucessView.h"
#import "LoginViewController.h"
#import "FindModel.h"

@interface FindPasswordViewController ()
@property(nonatomic,strong)FindView*findView;
@property(nonatomic,strong)ChangePasswordSucessView*sucessView;
@property(nonatomic,strong)FindModel* findModel;
@property(nonatomic,assign)NSInteger comparCode;

@end

@implementation FindPasswordViewController
-(void)loadView{
    self.findView=[[FindView alloc]initWithFrame:UIScreenBpunds];
    self.view = self.findView;


}
-(void)viewWillAppear:(BOOL)animated{
    
   self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
self.navigationItem.title = @"重置密码";
    self.findModel=[FindModel new];
    [self addView];
}
-(void)addView{
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(comparCodeResult) name:UITextFieldTextDidChangeNotification object:self.findView.validitionCode];

    [self.findView.getCodeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.findView.firstBtneye addTarget:self action:@selector(firstActin:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.findView.secendBtneye addTarget:self action:@selector(secendEyeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.findView.commitButton addTarget:self action:@selector(commitAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

//获取验证码
-(void)getCodeAction:(UIButton*)sender{



    NSMutableDictionary* parm=[NSMutableDictionary dictionary];
    [parm setObject:self.findView.find_phoneNum.text forKey:@"telephone"];
    
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"fetch_sms_code"] Token:nil parmpar:parm succeed:^(id data) {
//        FindModel*model =[FindModel new];
        [self.findModel setValuesForKeysWithDictionary:data];
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)comparCodeResult{
    if (self.findView.validitionCode.text.length ==6) {
        [self requestcomparaCode];
    }
    
    


}
//获取比较验证码
-(void)requestcomparaCode{
    
    
    NSDictionary* param =[NSDictionary dictionary];
    if ([self.findModel.reultMessage isEqualToString:@"成功"]) {
        param =@{@"token":self.findModel.data,@"verify":self.findView.validitionCode.text};
    } else {
        //垃圾参数防止崩溃
        param =@{@"token":@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE0NzkxMzU2MTIsIm5iZiI6MTQ3OTEzNTYxMywiZXhwIjoxNDc5MTM1NjczLCJkYXRhIjp7ImNvZGUiOiIyMTU2NDUifX0.ULQ7spRGvduzjPDBceCZaZyzCcgfpzAQdtzMGplA3JE",@"verify":self.findView.validitionCode.text};
       
    }
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manger.requestSerializer setValue:self.findModel.data forHTTPHeaderField:@"token"];
    
    //NSString*url=@"http://118.178.88.132:8000/api/fetch_sms_code/verification";
    
    NSLog(@"---%@",self.findModel.data);
    
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"fetch_sms_code/verification"] Token:nil parmpar:param succeed:^(id data) {
        NSLog(@"******%@",data);
        
        if (data[@"resultCode"] == 0) {
            
            self.comparCode=1;
        } else {
             [self AlerVCtitleString:@"提示" messageString:@"验证失败，请重新填写" doneString:@"请重新输入"];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

//提交
-(void)commitAction:(UIButton*)sender{
    if (self.findView.find_phoneNum.text.length ==11) {
        if (self.comparCode==1) {
            //判断是否修改成功
            if (/* DISABLES CODE */ (YES)) {
                
                self.sucessView=[[ChangePasswordSucessView alloc]initWithFrame:UIScreenBpunds];
                [self.findView addSubview:self.sucessView];
                
                [self.sucessView.loginButton addTarget:self action:@selector(loginBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            } else {
                [self AlerVCtitleString:@"提示" messageString:@"密码修改失败，请重新修改" doneString:@"重新验证"];
                
            }
            
            
            //修改密码
            // [self editorPassword];
        }else{
            [self AlerVCtitleString:@"提示" messageString:@"手机验证码，比对错误或未进行验证" doneString:@"重新验证"];
            
        }
    } else {
         [self AlerVCtitleString:@"提示" messageString:@"手机号码不能为空或者格式错误，请输入手机号码" doneString:@"重新输入"];
    }
   

   
}

-(void)firstActin:(UIButton*)sender{
self.findView.firstBtneye.selected =  !self.findView.firstBtneye.selected;
    if (self.findView.firstBtneye.selected == YES) {
        self.findView.firstPassword.secureTextEntry = NO;
    } else {
        self.findView.firstPassword.secureTextEntry = YES;
    }
}

-(void)secendEyeAction:(UIButton*)sender{

    self.findView.secendPassword.selected = !self.findView.secendPassword.selected;
    if (self.findView.secendPassword.selected == YES) {
        self.findView.secendPassword.secureTextEntry = NO;
    }else{
        self.findView.secendPassword.secureTextEntry = YES;
    }



}

//修改完密码跳转到登陆密码
-(void)loginBtnAction:(UIButton*)sender{
    
    [self.navigationController popViewControllerAnimated:YES];

}
//修改密码接口
-(void)editorPassword{



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
