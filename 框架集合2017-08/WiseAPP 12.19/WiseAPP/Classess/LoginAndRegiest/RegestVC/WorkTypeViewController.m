//
//  WorkTypeViewController.m
//  WiseAPP
//
//  Created by app on 16/10/16.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "WorkTypeViewController.h"
#import "IDCardModel.h"
#import "IDcardView.h"
#import "ShowCardMessage.h"
#import "IdCartdBmodel.h"
#import "WorkTypeMessageController.h"
#import <AVFoundation/AVFoundation.h>

@interface WorkTypeViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(strong,nonatomic)UIImagePickerController *imagePickerController;
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)IDcardView*idCardView;
@property(nonatomic,strong)ShowCardMessage*ShowMessageView;
@property(nonatomic,strong)UIScrollView*scrollView;

@property(strong,nonatomic)UIImageView*IDCardImage;
@property(strong,nonatomic)UIImage*IDCardImageA;
@property(strong,nonatomic)NSDictionary*dictionary;
@property(nonatomic,strong)IDCardModel*showModel;
@property(nonatomic,strong)IdCartdBmodel* showModeModelB;

@property(strong,nonatomic)NSString*imageType;


//自定义相机相关
@property (nonatomic, strong)AVCaptureSession *session;

// AVCaptureDeviceInput对象是输入流
@property (nonatomic, strong)AVCaptureDeviceInput *videoInput;

// 照片输出流对象
@property (nonatomic, strong)AVCaptureStillImageOutput *stillImageOutput;

// 预览图层，来显示照相机拍摄到的画面
@property (nonatomic, strong)AVCaptureVideoPreviewLayer *previewLayer;

// 切换前后镜头的按钮
@property (nonatomic, strong)UIButton *toggleButton;

// 拍照按钮
@property (nonatomic, strong)UIButton *shutterButton;

// 放置预览图层的View
@property (nonatomic, strong)UIView *cameraShowView;

// 用来展示拍照获取的照片
@property (nonatomic, strong)UIImageView *imageShowView;


@end

@implementation WorkTypeViewController



-(void)loadView{
    
    self.idCardView=[[IDcardView alloc]initWithFrame:UIScreenBpunds];
    self.view = self.idCardView;

}
-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //汉王身份证测试
//    [self getMessageAimage:[UIImage imageNamed:@"test.jpg"]];
//    [self getMessageBuiimage:[UIImage imageNamed:@"fanmian.jpg"]];
    
    self.showModel=[IDCardModel new];
    self.showModeModelB =[IdCartdBmodel new];
    
    self.view.userInteractionEnabled=YES;
   self.navigationItem.title = @"个人信息完善";

    self.tableView =[[UITableView alloc]initWithFrame:UIScreenBpunds];
    //self.tableView.backgroundColor=[UIColor greenColor];
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
    
    self.idCardView=[[IDcardView alloc]initWithFrame:UIScreenBpunds];
    [self.tableView addSubview:self.idCardView];
    self.tableView.userInteractionEnabled=YES;
    if (SCREEN_WIDTH<600) {
        
             self.view.height= SCREEN_HEIGHT+100;
                self.tableView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+100);
   
              self.idCardView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+100);
            }else{
                     self.view.height= SCREEN_HEIGHT;
            self.tableView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
                self.idCardView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            }
    
    //拍照页面点击事件
    [self idcardAction];

}

-(void)idcardAction{
    
    self.idCardView.userInteractionEnabled =YES;
    [self.idCardView.playABtn addTarget:self action:@selector(playAbtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.idCardView.playBBtn addTarget:self action:@selector(playBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.idCardView.commitBtn addTarget:self action:@selector(commitSIDAction:) forControlEvents:(UIControlEventTouchUpInside)];
  
    
}

//正面拍照
-(void)playAbtnAction:(UIButton*)sender{
    self.imageType = @"A";
    [self playCamer];

}

//反面拍照
-(void)playBtnAction:(UIButton*)sender{
    if([self.showModel.code isEqualToString:@"0"]){
        self.imageType = @"B";
        [self playCamer];
    }else{
        [self AlerVCtitleString:@"提示" messageString:@"身份证正面识别失败，请重拍" doneString:@"确定"];
    }

 

}
-(void)playCamer{

    self.imagePickerController = [[UIImagePickerController alloc]init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = YES;
    
    // 获取支持的媒体格式
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
//    self.session = [[AVCaptureSession alloc]init];
//    [self.session addInput:<#(AVCaptureInput *)#>];
    
    // 判断是否支持需要设置的sourceType
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        //        self.imagePickerController.showsCameraControls = NO;
        //        UIView*view= [[UIView alloc]initWithFrame:CGRectMake(10, 70, 414, 500)];
        //        view.backgroundColor = [UIColor redColor];
        //        [self.imagePickerController.cameraOverlayView addSubview:view];
        // self.imagePickerController.cameraOverlayView = view;
        // 1、设置图片拾取器上的sourceType
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // 2、设置支持的媒体格式
        _imagePickerController.mediaTypes = @[mediaTypes[0]];
        // 3、其他设置
        // 设置相机模式
        _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        // 设置摄像头：前置/后置
        _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraDeviceRear;
        // 设置闪光模式
        _imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        _imagePickerController.cameraCaptureMode=UIImagePickerControllerCameraDeviceRear;
        //        照相机常用属性
     //       cameraCaptureMode：设置相机模式
        //
        //        UIImagePickerControllerCameraCaptureModePhoto：拍照
        //        UIImagePickerControllerCameraCaptureModeVideo：录制
        //        cameraDevice：更改摄像头
        //
        //        UIImagePickerControllerCameraDeviceFront：前置摄像头
        //        UIImagePickerControllerCameraDeviceRear ：后置摄像头
        //        cameraFlashMode：设置闪关灯模式
        //
        //        UIImagePickerControllerCameraFlashModeOff：关闭闪关灯
        //        UIImagePickerControllerCameraFlashModeAuto：自动模式
        //        UIImagePickerControllerCameraFlashModeOn：打开闪关灯
        
        
        // 4、推送图片拾取器控制器
        if([[[UIDevice
              currentDevice] systemVersion] floatValue]>=8.0) {
            
            self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            
        }
        [self presentViewController:_imagePickerController animated:YES completion:nil];
        
    }else {
        NSLog(@"当前设备不支持拍照");
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                  message:@"当前设备不支持拍照"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                 
                                                          }]];
        //        if([[[UIDevice
        //              currentDevice] systemVersion] floatValue]>=8.0) {
        //
        //            self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
        //}
        
        
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
    

}

//拍照照片选取

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
     }
    //将图片添加到对应的视图上
    if ([self.imageType isEqualToString:@"A"]) {
        self.idCardView.idCardA.image = image;
    
         [self getMessageAimage:image];
     }else if ([self.imageType isEqualToString:@"B"]){
        self.idCardView.idCardB.image = image;
        [self getMessageBuiimage:image];
      }

    [self dismissViewControllerAnimated:YES completion:NULL];
}

//提交
-(void)commitSIDAction:(UIButton*)sender{
    //判断是否有值
    
    if ( [self.showModeModelB.code isEqualToString:@"0"] ) {
        [self getValue];
       
    }else{
        [self AlerVCtitleString:@"提示" messageString:@"身份证正面格式错误" doneString:@"确定"];
        
    }
    
}
-(void)getValue{


    self.view.userInteractionEnabled=YES;
    self.idCardView.commitBtn.userInteractionEnabled =YES;
    self.ShowMessageView =[[ShowCardMessage alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview:self.ShowMessageView];
    
    self.ShowMessageView.showModel  = self.showModel;
    //赋值
    self.ShowMessageView.userName.text =  self.showModel.name;
    self.ShowMessageView.userGender.text =  self.showModel.gender;
    self.ShowMessageView.userNation.text = self.showModel.people;
    NSString*dateString =[NSString stringWithFormat:@"%@%@%@",self.showModel.byear,self.showModel.bmonth,self.showModel.bday];
    
    self.ShowMessageView.userDate.text = dateString;
    self.ShowMessageView.userAdress.text = self.showModel.address;
    self.ShowMessageView.userVisa.text = self.showModeModelB.authority;
    self.ShowMessageView.userVisaDate.text = self.showModeModelB.validdate;
    self.ShowMessageView.userIDnum.text = self.showModel.idnumber;
    
    //image转base64
    UIImage * headImage     = [self baseToImageBString:  self.showModel.headImage];
    self.ShowMessageView.userImage.image =headImage;
    self.idCardView.idCardA.image = [self baseToImageBString:  self.showModel.croppedImage];
    self.ShowMessageView.userVisa.text =self.showModeModelB.authority;
    self.ShowMessageView.userVisaDate.text =self.showModeModelB.validdate;
    self.idCardView.commitBtn.userInteractionEnabled=YES;
    //弹框点击事件
    [self.ShowMessageView.backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.ShowMessageView.doneBtn addTarget:self action:@selector(doneBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
}
//base 转UIimage
-(UIImage*)baseToImageBString:(NSString*)baseString{
    UIImage*getImage=[[UIImage alloc]init];
    if ([baseString isEqualToString:@" "]) {
        [self AlerVCtitleString:@"提示" messageString:@"没有照片，请拍照" doneString:@"拍照"];
    } else {
        NSData *decodedImageData = [[NSData alloc]
                                    
                                    initWithBase64EncodedString:baseString options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
        getImage=decodedImage;
        return decodedImage;
    }
    return getImage;
}
//popAction 弹框展示身份证页面信息点击事件

-(void)backBtnAction:(UIButton*)sender{

    self.ShowMessageView.hidden = YES;
}

-(void)doneBtnAction:(UIButton*)sender{

    if ( [self.showModel.code isEqualToString:@"0"] ) {
       
        [self nextPage];
    }else{
         [self AlerVCtitleString:@"提示" messageString:@"身份证正面格式错误" doneString:@"确定"];
        
              }
    
}
-(void)nextPage{

   WorkTypeMessageController*messageVC=[[WorkTypeMessageController alloc]init];
        messageVC.workPassword = self.wgPassword;
        messageVC.workPhoneName = self.wgPhoneNum;
        
        //身份证信息
        messageVC.modelA =self.showModel;
        messageVC.modelB = self.showModeModelB;
        
        [self.navigationController pushViewController:messageVC animated:YES];
}

//com.shantaoiOS.wise  af66f6fe-7b0a-4a38-8f5e-d9a2a523a171
//	com.yishantaoo   790f14b4-1960-40ca-8cb0-a91df6c2e4bc
//com.yishantaoiOS.WiseAPPP  941a66ca-da28-4b86-870e-a9e49158f3e7
////com.yishantaoiOS.WiseAPPP 941a66ca-da28-4b86-870e-a9e49158f3e7
//com.yishantao   79995570-bb6e-47be-ae7c-4c7145991da3

//com.1130172064.POSTGET  http://api.hanvon.com/rt/ws/v1/ocr/idcard/cropped/recg?key=a23a5fdc-e45b-4434-b7ab-c257eac5a7e3&code=56bc30ea-2229-4891-9c92-8a022f10889f

//a面网络请求
-(void)getMessageAimage:(UIImage*)cardImage{
    
    //postget id:com.1130172064.POSTGET   key  a23a5fdc-e45b-4434-b7ab-c257eac5a7e3
    
//    UIImage*image = [UIImage imageNamed:@"test.jpg"];
   
   //NSData *imageg =UIImagePNGRepresentation(image);
       //NSString *imageString = [[NSString alloc] initWithData:imageDataencoding:NSUTF8StringEncoding];
    //当数据量比较大得时候，这种的data转string会溢出，得到结果为空置，所以要用base64处理。
    
    UIImage*image =  cardImage;
    NSData*imageg = UIImageJPEGRepresentation(image, 0.2);

    NSString *imageString = [imageg base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

   NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"0.0.0.0" forKey:@"uid"];
    [dic setObject:imageString forKey:@"image"];
    NSString *jsonString = [self dictionaryToJson:dic];
    [NetWorkRequestManager requestWithType:POST urlString:@"http://api.hanvon.com/rt/ws/v1/ocr/idcard/cropped/recg?key=af66f6fe-7b0a-4a38-8f5e-d9a2a523a171&code=56bc30ea-2229-4891-9c92-8a022f10889f" parDic:jsonString  finish:^(NSData *data) {
        
        NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dataint: %@",dic);
        for (NSString*str in dic) {
            
            NSLog(@"%@",str);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
         [self.showModel setValuesForKeysWithDictionary:dic];
             if([self.showModel.code isEqualToString:@"0"]){
             
            }else{
                [self AlerVCtitleString:@"提示" messageString:@"身份证正面识别失败，请重拍" doneString:@"确定"];
            }
            
        });
    } error:^(NSError *error) {
        NSLog(@"error : %@", error);
    }];
    
    
    
    
}
//B面网络请求
-(void)getMessageBuiimage:(UIImage*)cardImage{
    
        //postget id:com.1130172064.POSTGET   key  a23a5fdc-e45b-4434-b7ab-c257eac5a7e3
        
        //postget id:com.1130172064.POSTGET   key  a23a5fdc-e45b-4434-b7ab-c257eac5a7e3
        
        //    UIImage*image = [UIImage imageNamed:@"test.jpg"];
        UIImage*image =  cardImage;
        //NSData *imageg =UIImagePNGRepresentation(image);
        NSData*imageg = UIImageJPEGRepresentation(image, 0.2);
        //NSString *imageString = [[NSString alloc] initWithData:imageDataencoding:NSUTF8StringEncoding];
        //当数据量比较大得时候，这种的data转string会溢出，得到结果为空置，所以要用base64处理。
        NSString *imageString = [imageg base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [dic setObject:@"0.0.0.0" forKey:@"uid"];
        [dic setObject:imageString forKey:@"image"];
        NSString *jsonString = [self dictionaryToJson:dic];
        [NetWorkRequestManager requestWithType:POST urlString:@"http://api.hanvon.com/rt/ws/v1/ocr/idcard/cropped/recg?key=af66f6fe-7b0a-4a38-8f5e-d9a2a523a171&code=56bc30ea-2229-4891-9c92-8a022f10889f" parDic:jsonString  finish:^(NSData *data) {
            
            NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"dataint: %@",dic);
            for (NSString*str in dic) {
                
                NSLog(@"%@",str);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.showModeModelB setValuesForKeysWithDictionary:dic];
                NSLog(@"%@---%@",self.showModeModelB,self.showModeModelB.validdate);
            });
      
        } error:^(NSError *error) {
            NSLog(@"error : %@", error);
        }];
        
        
    
}


- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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
