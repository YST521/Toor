//
//  JiaojiebanAddViewController.m
//  WiseAPP
//
//  Created by app on 16/11/1.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "JiaojiebanAddViewController.h"
#import "JIaojiebanView.h"
#import "WSImagePickerView.h"
#import "JiaojiebanModel.h"
#import "JiaojiebanViewController.h"


@interface JiaojiebanAddViewController ()<UITextViewDelegate>
@property(nonatomic,strong)JIaojiebanView*jiaojieView;

@property (nonatomic, strong) WSImagePickerView *pickerView;

@end

@implementation JiaojiebanAddViewController
-(void)loadView{
    self.jiaojieView=[[JIaojiebanView alloc]initWithFrame:UIScreenBpunds];
    self.view = self.jiaojieView;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    
    [self textViewDelegate];
        [self setupPickerView];
    if (self.nextPageType==1) {
        self.jiaojieView.produceFile.text =self.model.mattername;
        self.jiaojieView.contentFile .text = self.model.matter;
       
    }
    
}

#pragma mark - UITextViewDelegate
-(void)textViewDelegate{
    
    self.jiaojieView.contentFile.text=@"1.对讲机交接";
    self.jiaojieView.contentFile.delegate=self;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"1.对讲机交接";
       
        textView.textColor = textColorPlace;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"1.对讲机交接"]){
        textView.text=@"";
      
        textView.textColor=[UIColor blackColor];
    }

}

- (void)setupPickerView {


    //imagePickerView parameter settings
    WSImagePickerConfig *config = [WSImagePickerConfig new];
    config.itemSize = CGSizeMake(80, 80);
    config.photosMaxCount = 9;
    
    WSImagePickerView *pickerView = [[WSImagePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0) config:config];
    //Height changed with photo selection
    __weak typeof(self) weakSelf = self;
    pickerView.viewHeightChanged = ^(CGFloat height) {
        //weakSelf.photoViewHieghtConstraint.constant = height;
        [weakSelf.view setNeedsLayout];
        [weakSelf.view layoutIfNeeded];
    };
    pickerView.navigationController = self.navigationController;
    [self.jiaojieView.photoView addSubview:pickerView];
    self.pickerView = pickerView;
    
    //refresh superview height
    [pickerView refreshImagePickerViewWithPhotoArray:nil];
}

-(void)saveAction:(UIButton*)sender{
    
    NSArray *array = [_pickerView getPhotos];
    //[NSString stringWithFormat:@"共选择了%@张照片",@(array.count)]
    if (self.nextPageType ==1) {
        if(array.count <4){

            [self updateData];
                  }else{
            [self AlerVCtitleString:@"提示" messageString:@"最多只能上传三张图片" doneString:@"请重新选择"];
        }

    } else {
        if(array.count <4){
            NSLog(@"AAAAAASSSS%@",array);
            
            [self titlCon];
            
        }else{
            [self AlerVCtitleString:@"提示" messageString:@"最多只能上传三张图片" doneString:@"请重新选择"];
            
        }

    }
    
    
    
}
//条件限制
-(void)titlCon{

    if (self.jiaojieView.produceFile.text.length ==0 || [self.jiaojieView.produceFile.text isEqualToString:@" "]) {
        [self AlerVCtitleString:@"提示" messageString:@"标题不能为空" doneString:@"确定"];
    } else {
        [self contentFile];
    }

}
-(void)contentFile{
    if ([self.jiaojieView.contentFile.text isEqualToString:@"1.对讲机交接"]) {
         [self AlerVCtitleString:@"提示" messageString:@"交接班内容不能为空" doneString:@"确定"];
    } else {
        
    
    if (self.jiaojieView.contentFile.text.length== 0 || [self.jiaojieView.contentFile.text isEqualToString:@" "]) {
         [self AlerVCtitleString:@"提示" messageString:@"交接班内容不能为空" doneString:@"确定"];
    } else {
        if (self.nextPageType==1) {
            [self updateData];
        } else {
               [self UpLoadData];
        }
     
    }
    }
}


-(void)updateData{
    NSArray *array = [_pickerView getPhotos];
    //NSLog(@"%@-----%@",  [NSString stringWithFormat:@"共选择了%@张照片",@(array.count)],array);
    //项目ID
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];

        //上传参数
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        //账号密码
        [param setObject:ID forKey:@"projectid"];
        [param setObject:@(self.model.jiaojiebanID) forKey:@"id"];
        [param setObject:self.jiaojieView.produceFile.text forKey:@"mattername"];
        [param setObject:self.jiaojieView.contentFile.text forKey:@"matter"];
    
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    //打开指示器
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manger.requestSerializer setValue: self.tokenString forHTTPHeaderField:@"token"];
    [manger.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    manger.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",
    @"image/png",@"application/octet-stream",@"text/json", nil];
    
    [manger POST:[self urlRequestChildreurl:@"precautionUpdate"] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSInteger imgCount = 0;
        if (array.count != 0) {
            for (UIImage *image in array) {
                
                NSData * imageData = UIImageJPEGRepresentation(image, 0.2);
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                
                formatter.dateFormat = @"yyyyMMddHHmmssSSS";
                
                NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
                
                
                [formData appendPartWithFileData:imageData name:@"image[]" fileName:fileName mimeType:@"image/png"];
                imgCount++;
                
            }
        }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [MBProgressHUD hideHUDForView:nil animated:YES];
        //页面跳转
       [self turnPage];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //隐藏指示器
        [MBProgressHUD hideHUDForView:nil animated:YES];
        
        
    }];


}
-(void)UpLoadData{
    NSArray *array = [_pickerView getPhotos];

    NSLog(@"%@-----%@",  [NSString stringWithFormat:@"共选择了%@张照片",@(array.count)],array);

    //项目ID
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
     NSMutableDictionary *param = [NSMutableDictionary dictionary];

        //上传参数
        [param setObject:ID forKey:@"projectid"];
        [param setObject:self.jiaojieView.produceFile.text forKey:@"mattername"];
        [param setObject:self.jiaojieView.contentFile.text forKey:@"matter"];
   //一次传三组
//    NSInteger imgCount = 0;
//            if (array.count != 0) {
//                for (UIImage *image in array) {
//    
//                    NSData * imageData = UIImageJPEGRepresentation(image, 0.5);
//    
//                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    
//                    formatter.dateFormat = @"yyyyMMddHHmmssSSS";
//    
//                    NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
//    
//                   // [formData appendPartWithFileData:imageData name:@"image[]" fileName:fileName mimeType:@"image/png"];
//                    [RequestManger UPLoadImageUrl:[self urlRequestChildreurl:@"precautionAdd"] parmar:param token:self.tokenString imageData:imageData imageName:@"image[]" imageFileName:fileName mimeType:@"image/jpg" succeed:^(id data) {
//                        NSLog(@"图片上传 %@",data);
//                        for (NSArray*array in [data allValues]) {
//                            
//                            NSLog(@"图片上传 %@",array);
//                            
//                        }
//                        
//                    } failure:^(NSError *error) {
//                        
//                    }];
//
//    
//                    imgCount++;
//                    
//                }
//            }
    //打开指示器
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manger.requestSerializer setValue: self.tokenString forHTTPHeaderField:@"token"];
    [manger.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    manger.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",
                                                       @"text/html",
                                                       @"image/jpeg",
                                                       @"image/png",
                                                       @"application/octet-stream",
                                                       @"text/json", nil];
    
    [manger POST:[self urlRequestChildreurl:@"precautionAdd"] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSInteger imgCount = 0;
                    if (array.count != 0) {
                        for (UIImage *image in array) {
        
                            NSData * imageData = UIImageJPEGRepresentation(image, 0.2);
        
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
                            formatter.dateFormat = @"yyyyMMddHHmmssSSS";
        
NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
                            
                            
    [formData appendPartWithFileData:imageData name:@"image[]" fileName:fileName mimeType:@"image/png"];
        imgCount++;
        
                        }
                    }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [MBProgressHUD hideHUDForView:nil animated:YES];

        //页面跳转
            [self turnPage];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //隐藏指示器
        [MBProgressHUD hideHUDForView:nil animated:YES];
        
        
    }];



}
//跳转
-(void)turnPage{
    
        for (UIViewController* controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[JiaojiebanViewController class]]) {
                JiaojiebanViewController* yezhuShowVC =(JiaojiebanViewController*)controller;
                [self.navigationController popToViewController:yezhuShowVC animated:YES];
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
