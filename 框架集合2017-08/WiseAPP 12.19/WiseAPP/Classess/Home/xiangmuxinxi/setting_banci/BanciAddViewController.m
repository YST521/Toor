//
//  BanciAddViewController.m
//  WiseAPP
//
//  Created by app on 16/10/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BanciAddViewController.h"
#import "BanCiViewController.h"
#import "BanciAddView.h"
#import "BanciModel.h"
#import "RequestManger.h"
#import "TimeDHViewController.h"


@interface BanciAddViewController ()<UITextFieldDelegate,passTimHMvalue>
@property(nonatomic,strong)BanciAddView* addView;
@end

@implementation BanciAddViewController
-(void)loadView{
    self.addView =[[BanciAddView alloc]initWithFrame:UIScreenBpunds];
    self.view =self.addView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = @"班次设置";
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    
    
    if (self.editorType ==1) {
        
        self.addView.banciName.text = self.banciModel.servicesname;
        self.addView.starTime.text = self.banciModel.starttime;
        self.addView.endTime.text= self.banciModel.endtime;
    }

    self.addView.starTime.delegate=self;
    self.addView.endTime.delegate=self;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    //turn page
    if (textField == self.addView.starTime) {
        TimeDHViewController*daVC=[[TimeDHViewController alloc]init];
        daVC.modalTransitionStyle= UIModalPresentationNone;
        daVC.delegate =self;
        daVC.title = @"开始时间";
        daVC.uppagetype=@"开始时间";
        [self presentViewController:daVC animated:YES completion:nil];
    }else{
        TimeDHViewController*timeVC=[[TimeDHViewController alloc]init];
        timeVC.modalTransitionStyle= UIModalPresentationNone;
        timeVC.delegate =self;
        timeVC.title = @"结束时间";
        timeVC.uppagetype=@"结束时间";
        [self presentViewController:timeVC animated:YES completion:nil];
        
    }


}
-(void)passTime:(NSString *)timeString type:(NSString *)typeString{
    if ([typeString isEqualToString:@"开始时间"]) {
        self.addView.starTime.text =timeString;
       self.addView.starTime.textColor=textCententColor;
        
    } else {
        
        self.addView.endTime.text= timeString;
      self.addView.endTime.textColor =textCententColor;
    }


}

//保存
-(void)saveAction:(UIBarButtonItem*)sender{
    
   
    if (self.editorType ==1) {
        
        [self editorRequest];
          [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self requestTitle];
       
    }

}
//conditons
-(void)requestTitle{
    if ([self.addView.banciName.text isEqualToString:@" "]||self.addView.banciName.text.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"请输入班次名称" doneString:@"确定"];
    } else {
        [self requestTime];
    }

}
-(void)requestTime{

    if ([self.addView.starTime.text isEqualToString:@""]||self.addView.starTime.text.length==0||[self.addView.endTime.text isEqualToString:@" "]||self.addView.endTime.text.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"请输入班次开始结束时间" doneString:@"确定"];
    } else {
        [self addData];
    }

}

//编辑
-(void)editorRequest{
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:ID forKey:@"projectid"];
      [param setObject:@(self.banciModel.banciID) forKey:@"id"];
    [param setObject:self.addView.banciName.text forKey:@"servicesname"];
    [param setObject:self.addView.starTime.text forKey:@"starttime"];
    [param setObject:self.addView.endTime.text forKey:@"endtime"];
    
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"serviceUpdate"] Token:self.tokenString parmpar:param succeed:^(id data) {
        if (data[@"resultCode"] ==0) {
             [self turnpage];
        }
      
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)addData{
      NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
   //上传参数
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
      
        [param setObject:ID forKey:@"projectid"];
        [param setObject:self.addView.banciName.text forKey:@"servicesname"];
        [param setObject:self.addView.starTime.text forKey:@"starttime"];
        [param setObject:self.addView.endTime.text forKey:@"endtime"];
    
    [RequestManger PostRequestUrl:@"http://118.178.88.132:8000/api/serviceAdd" Token:self.tokenString parmpar:param succeed:^(id data) {
        for (NSArray*array in [data allValues]) {
            
            NSLog(@"班次添加数据:%@",array);
        }
  
            [self turnpage];
    

    } failure:^(NSError *error) {
        
    }];

}
//编辑完成跳转到首页
-(void)turnpage{

    for (UIViewController*controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[BanCiViewController class]]) {
            BanCiViewController*bancVC=(BanCiViewController*)controller;
            [self.navigationController popToViewController:bancVC animated:YES];
        }
    }

}


//原生请求
//-(void)request{
//    NSLog(@"BBBBBB%@",self.addView.banciName.text);
//      NSString* tokenString=  [[LoginMessageManger loginMessageSingleManger].loginMangerDic objectForKey:@"loginToken"];
//    // 1.设置请求路径
//    NSURL *URL=[NSURL URLWithString:[self urlRequestChildreurl:@"serviceAdd"]];//不需要传递参数
// 
//   //    2.创建请求对象
//       NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
//       request.timeoutInterval=5.0;//设置请求超时为5秒
//       request.HTTPMethod=@"POST";//设置请求方法
//    [request addValue:tokenString forHTTPHeaderField:@"token"];
//    //账号密码
//       //设置请求体
//      //NSString *param=[NSString stringWithFormat:@"projectid=%@&servicesname=%@&starttime=%@&endtime=%@",@"1",self.addView.banciName.text,self.addView.starTime.text,self.addView.endTime.text];
//    //projectid=1&servicesname=&starttime=&endtime=
//       NSString *param=[NSString stringWithFormat:@"projectid=%@&servicesname=%@&starttime=%@&endtime=%@",@"1",@"早班",@"08:00",@"20:00"];
//    NSLog(@"----%@",param);//projectid=1&servicesname=ww&starttime=08:00&endtime=20:00
//  //把拼接后的字符串转换为data，设置请求体
//      request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSURLSession*session=[NSURLSession sharedSession];
//    NSURLSessionTask*task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
//        
//        NSLog(@"AAAAA%@",[dic allValues]);
//    } ];
//   
//    [task resume];
//    
//}
//-(void)requestManger{
//    //上传参数
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    //账号密码
//    [param setObject:@"1" forKey:@"projectid"];
//    //[param setObject:@"Id" forKey:@"2222"];
//    [param setObject:@"早班" forKey:@"servicesname"];
//    [param setObject:@"08.00" forKey:@"starttime"];
//    [param setObject:@"20.00" forKey:@"endtime"];
//
//    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"serviceAdd"] Token:self.tokenString parmpar:param succeed:^(id data) {
//        for (NSArray*array in [data allValues]) {
//                                    NSLog(@"88888999999%@",array);
//                                }
//         [self.navigationController popViewControllerAnimated:YES];
//    } failure:^(NSError *error) {
//        
//    }];
//
//
//}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.addView.banciName resignFirstResponder];

    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

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
