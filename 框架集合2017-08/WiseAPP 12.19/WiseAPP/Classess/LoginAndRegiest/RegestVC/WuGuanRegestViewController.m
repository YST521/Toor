//
//  WuGuanRegestViewController.m
//  WiseAPP
//
//  Created by app on 16/10/16.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "WuGuanRegestViewController.h"
#import "WuguanView.h"
#import "MainTabBarController.h"
#import "AFNetworking.h"
#import "WuguanModel.h"

@interface WuGuanRegestViewController ()
@property(nonatomic,strong)WuguanView*wuguanView;
@property(nonatomic,strong)NSMutableArray*array;


@end

@implementation WuGuanRegestViewController
-(void)loadView{

    self.wuguanView=[[WuguanView alloc]initWithFrame:UIScreenBpunds];
    self.view = self.wuguanView;

}
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray array];
    self.navigationItem.title = @"个人信息完善";
    [self addView];
    
}
-(void)addView{

    [self.wuguanView.commitBtn addTarget:self action:@selector(CommitAction:) forControlEvents:(UIControlEventTouchUpInside)];

}

-(void)CommitAction:(UIButton*)sender{
    
    NSDictionary*param =@{@"username": self.wgPhoneNum,
                          @"password": self.wgPassword,
                          @"name":self.wuguanView.wuguanPhNum.text,
                          @"company": self.wuguanView.wuguanCompany.text,
                          @"position":self.wuguanView.wuguanPosition.text,
                          @"email":self.wuguanView.wuguanEmail.text
                          };
   
//block回调
     WuguanModel*model=[WuguanModel new];
//    [MHNetworkManager postReqeustWithURL:@"http://118.178.88.132:8000/api/register/property" params: param successBlock:^(NSDictionary *returnData) {
//        
//  
//        
//        //通知主线程刷新
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//           
//           [model  setValuesForKeysWithDictionary:returnData];
//         
//            NSLog(@"mmm%@www%@www%@ ",returnData,model.resultCode,model.data);
//            //[model.resultCode isEqual: 0 ]
//            if( model.resultCode  == 0) {
//                NSLog(@"UUUUUU%@ --%@",model.resultCode,returnData[@"resultCode"]);
//                MainTabBarController*mainVC=[[MainTabBarController alloc]init];
//                
//                [UIApplication sharedApplication].keyWindow.rootViewController =mainVC ;
//                //
//            }else{
//                
//                
//                [self AlerVCtitleString:@"提示" messageString:@"注册失败，请检查您填写的信息" doneString:@"确定"];
//            }
//            
//        });
//        
//        
//        
//    } failureBlock:^(NSError *error) {
//  
//
//         NSLog(@"qq%@",error);
//    } showHUD:YES];
//    
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"register/property"] Token:nil parmpar:param succeed:^(id data) {
        //通知主线程刷新
                dispatch_async(dispatch_get_main_queue(), ^{
        
        
                   [model  setValuesForKeysWithDictionary:data];
        
                    if( model.resultCode  == 0) {
                        NSLog(@"UUUUUU%@ --%@",model.resultCode,data[@"resultCode"]);
                        MainTabBarController*mainVC=[[MainTabBarController alloc]init];
        
                        [UIApplication sharedApplication].keyWindow.rootViewController =mainVC ;
                        //
                    }else{
        
        
                        [self AlerVCtitleString:@"提示" messageString:@"注册失败，请检查您填写的信息" doneString:@"确定"];
                    }
                    
                });
                
                

        
        
    } failure:^(NSError *error) {
        
    }];

    
    
}

-(void)AlerVCtitleString:(NSString*)title messageString:(NSString*)message doneString:(NSString*)doneString{
    
    UIAlertController*alerVC= [UIAlertController alertControllerWithTitle:title message:message preferredStyle:( UIAlertControllerStyleAlert)];
    UIAlertAction*al= [UIAlertAction actionWithTitle:doneString style:(UIAlertActionStyleDefault) handler:nil];
    [alerVC addAction:al];
    [self presentViewController:alerVC animated:YES completion:nil];
    
}

//-(void)postParmetes:(NSDictionary*)Parameters WithUrl:(NSURL*)url Sucessful:(void (^)(NSDictionary*))Sucessful falure:(void)()


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
