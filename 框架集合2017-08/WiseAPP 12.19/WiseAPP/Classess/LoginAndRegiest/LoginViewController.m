//
//  LoginViewController.m
//  WiseAPP
//
//  Created by app on 16/10/12.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "LoginViewController.h"
#import "CustonTextfile.h"
#import "LoginView.h"
#import "MainTabBarController.h"
#import "RegestViewController.h"
#import "FindPasswordViewController.h"
#import "RootUINavigationController.h"
#import "LoginrequestModel.h"




@interface LoginViewController ()<UINavigationControllerDelegate,UITextFieldDelegate>

@property(nonatomic,strong)LoginView*LoginView;
@property(nonatomic,strong)NSArray* requestArray;
@property(nonatomic,strong)LoginrequestModel* model;
@end

@implementation LoginViewController

-(void)loadView{
    self.LoginView=[[LoginView alloc]initWithFrame:UIScreenBpunds];
    self.view = self.LoginView;


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;

}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.model = [LoginrequestModel new];
    [self creatUIAction];
}



-(void)creatUIAction{
    
    //记住密码
    [self.LoginView.menmoryBtn addTarget:self action:@selector(menmoryBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //忘记密码
    
    [self.LoginView.remberBtn addTarget:self action:@selector(remberBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //看密码
    [self.LoginView.eyeBtn  addTarget:self action:@selector(eyeactiobAction:) forControlEvents:(UIControlEventTouchUpInside)];

    //登陆
    [self.LoginView.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //注册
    [self.LoginView.regestBtn addTarget:self action:@selector(regestBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.LoginView.phoneNum.delegate=self;
    self.LoginView.password.delegate = self;
    
    
}
//登陆点击事件
-(void)loginAction:(UIButton*)sender{
    //1 判断是否为空
    if (self.LoginView.phoneNum.text.length != 0 ) {
    
        [self phoneType];
       // [self request];
    }else{
        [self AlerVCtitleString:@"提示" messageString:@"您的账号不能为空，请重新输入" doneString:@"重新输入"];
    }
    
    

    
    

}
-(void)phoneType{
    //        //2 判断格式是否对
    if ([self valiMobile:self.LoginView.phoneNum.text]){
        //        //3 判断是否有此账号
        NSDictionary*param =@{@"username": self.LoginView.phoneNum.text,
                              @"password": self.LoginView.password.text
                              };
    }
    

//NSString*url= [self urlRequestChildreurl:@"login"];
//
//[RequestManger PostRequestUrl:url Token:nil parmpar:param succeed:^(id data) {
//            
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self.model setValuesForKeysWithDictionary:data];
//            
//if(/* DISABLES CODE */ [self.model.resultMessage isEqualToString:@"成功"]){
    MainTabBarController*manTabbar=[[MainTabBarController alloc]init];
    [[UIApplication sharedApplication] keyWindow].rootViewController =manTabbar;
                                //存储token和 type
//     [[LoginMessageManger loginMessageSingleManger].loginMangerDic setObject:data[@"data"][@"token"] forKey:@"loginToken"];
//    [[LoginMessageManger loginMessageSingleManger].loginMangerDic setObject:data[@"data"][@"type"] forKey:@"loginType"];
//    
////    NSLog(@"********FDDDDDDD********%@",data);
//            
//        }else{
//    [self AlerVCtitleString:@"提示" messageString:@"你的账号密码不一致，请重新输入" doneString:@"确定"];
//                            }
//            
//                        });
//            
//        } failure:^(NSError *error) {
//            
//        }];
//        
//    }else{
//            [self AlerVCtitleString:@"提示" messageString:@"您输入的账号格式不对，请重新输入" doneString:@"重新输入"];
//            }
//    


}

//设置启动图时间
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
        [NSThread sleepForTimeInterval:5.0];//设置启动页面时间
    
    return YES;
}



//注册
-(void)regestBtnAction:(UIButton*)sender{
    RegestViewController*regestVC=[[RegestViewController alloc]init];
    [self.navigationController pushViewController:regestVC animated:YES];
 }

-(void)menmoryBtnAction:(UIButton*)sender{
    
    self.LoginView.menmoryBtn.selected = !self.LoginView.menmoryBtn.selected;
    NSUserDefaults*defaults =[NSUserDefaults standardUserDefaults];

    if (self.LoginView.menmoryBtn.selected == YES) {
        
        //记住密码
        [defaults setObject:self.LoginView.phoneNum.text forKey:@"name"];
        [defaults setObject:self.LoginView.password.text   forKey:@"passWord"];
        
    
    }else{
      //删除密码
        [defaults removeObjectForKey:@"name"];
        [defaults removeObjectForKey:@"passWord"];



            }


}

-(void)remberBtnAction:(UIButton*)sender{

    FindPasswordViewController*findVC=[[FindPasswordViewController alloc]init];
    [self.navigationController pushViewController:findVC animated:YES];


}
-(void)eyeactiobAction:(UIButton*)sender{
    
    self.LoginView.eyeBtn.selected = !self.LoginView.eyeBtn.selected;
    if (self.LoginView.eyeBtn.selected == YES) {
        self.LoginView.password.secureTextEntry = NO;
    }else{
    self.LoginView.password.secureTextEntry = YES;
    }
    
    
}

#pragma mark - UINavigationControllerDelegate

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];

}

//键盘回收
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.LoginView.phoneNum resignFirstResponder];
    [self.LoginView.password resignFirstResponder];



    return YES;
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

-(void)AlerVCtitleString:(NSString*)title messageString:(NSString*)message doneString:(NSString*)doneString{
    
    UIAlertController*alerVC= [UIAlertController alertControllerWithTitle:title message:message preferredStyle:( UIAlertControllerStyleAlert)];
    UIAlertAction*al= [UIAlertAction actionWithTitle:doneString style:(UIAlertActionStyleDefault) handler:nil];
    [alerVC addAction:al];
    [self presentViewController:alerVC animated:YES completion:nil];
    
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
