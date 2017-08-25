//
//  GangweiAddViewController.m
//  WiseAPP
//
//  Created by app on 16/11/1.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "GangweiAddViewController.h"
#import "GangweiPeixunView.h"
#import "WSImagePickerView.h"
#import "GangweiModel.h"
#import "GangweipeixunViewController.h"

@interface GangweiAddViewController ()<UITextViewDelegate>
@property(nonatomic,strong)GangweiPeixunView* gangweiAddView;

@property (nonatomic, strong) WSImagePickerView *pickerView;
@property(nonatomic,strong)UIView* photoView;
@end

@implementation GangweiAddViewController

-(void)loadView{
    self.gangweiAddView=[[GangweiPeixunView alloc]initWithFrame:UIScreenBpunds];
    self.view =self.gangweiAddView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"岗位培训设置";
        self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    [self setupPickerView];
    if (self.gangweiUppgType ==1) {
        self.gangweiAddView.produceFile.text = self.model.trainingname;
        self.gangweiAddView.contentFile.text =self.model.trainingcontent;
    }
    [self textViewDelegate];
}

//保存
-(void)saveAction:(UIButton*)sender{
   // [self showImage];
    if (self.gangweiUppgType==1) {
        [self UpdateData];
    }else{
        [self gangweiTitle];
    
    }
    
}
-(void)gangweiTitle{

    if ([self.gangweiAddView.produceFile.text isEqualToString:@" "]|| self.gangweiAddView.produceFile.text.length ==0) {
        [self AlerVCtitleString:@"提示" messageString:@"岗位培训标题不能为空" doneString:@"确定"];
        
    } else {
        
        [self gangwenContent];
    }

}

-(void)gangwenContent{
    if ([self.gangweiAddView.contentFile.text isEqualToString: @"例如：1. 微笑"]) {
         [self AlerVCtitleString:@"提示" messageString:@"培训内容不能为空" doneString:@"确定"];
    } else {
        
    

    if ([self.gangweiAddView.contentFile.text isEqualToString:@" "]||self.gangweiAddView.contentFile.text.length==0 ) {
        [self AlerVCtitleString:@"提示" messageString:@"培训内容不能为空" doneString:@"确定"];
    } else {
        [self UploadData];
    }
    }

}
//跳转
-(void)turnPage{
    
    //dispatch_async(dispatch_get_main_queue(), ^{
    for (UIViewController* controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[GangweipeixunViewController class]]) {
            GangweipeixunViewController* yezhuShowVC =(GangweipeixunViewController*)controller;
            [self.navigationController popToViewController:yezhuShowVC animated:YES];
        }
    }
    
    // });
    
    
}

-(void)UpdateData{
    //项目ID
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    //上传参数
 

    [param setObject:ID forKey:@"projectid"];
    [param setObject:@(self.model.gangweipeixunID) forKey:@"id"];
    [param setObject:self.gangweiAddView.produceFile.text forKey:@"trainingname"];
     [param setObject:self.gangweiAddView.contentFile.text forKey:@"trainingcontent"];

  

    NSArray *array = [_pickerView getPhotos];
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
    
    [manger POST:[self urlRequestChildreurl:@"jobtrainingUpdate"] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
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
        NSLog(@"岗位培训%@",responseObject);
        //页面跳转
        [self turnPage];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //隐藏指示器
        [MBProgressHUD hideHUDForView:nil animated:YES];
        
    }];
}
-(void)UploadData{
   
    //项目ID
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //账号密码
    [param setObject:ID forKey:@"projectid"];
      [param setObject:@(self.model.gangweipeixunID) forKey:@"id"];
    [param setObject:self.gangweiAddView.produceFile.text forKey:@"trainingname"];
    [param setObject:self.gangweiAddView.contentFile.text forKey:@"trainingcontent"];
    
     NSArray *array = [_pickerView getPhotos];
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
    
    [manger POST:[self urlRequestChildreurl:@"jobtrainingAdd"] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
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
#pragma mark - UITextViewDelegate
-(void)textViewDelegate{
    
    self.gangweiAddView.contentFile.text=@"例如：1. 微笑";
    self.gangweiAddView.contentFile.delegate=self;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"例如：1. 微笑";
        
        textView.textColor = textColorPlace;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"例如：1. 微笑"]){
        textView.text=@"";
        
        textView.textColor=[UIColor blackColor];
    }
    
}

- (void)setupPickerView {
    self.photoView =[[UIView alloc]init];
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
    [self.gangweiAddView.addImageView addSubview:pickerView];
    self.pickerView = pickerView;
    
    //refresh superview height
    [pickerView refreshImagePickerViewWithPhotoArray:nil];
}
-(void)showImage{
    NSArray *array = [_pickerView getPhotos];
    NSLog(@"%@",array);
//    [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"共选择了%@张照片",@(array.count)] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
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
