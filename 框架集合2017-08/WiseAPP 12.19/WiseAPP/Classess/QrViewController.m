//
//  QrViewController.m
//  WiseAPP
//
//  Created by app on 16/10/11.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "QrViewController.h"
#import <AVFoundation/AVFoundation.h>//扫描二维码
#import "UIView+category.h"
#import "QRCodeHandler.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface QrViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIWebViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RecognizeQRCodeDelegate>
@property (nonatomic, weak) AVCaptureSession *session;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *layer;

//显示二维码内容
@property(nonatomic,strong)UILabel*labelv;

//展示二维码内容
@property(nonatomic,strong)UIWebView*webview;

@property (nonatomic, strong) QRCodeHandler *qrCodeHandler;

@end

@implementation QrViewController{
    UIImagePickerController * _imagePicker;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.title = @"扫一扫";
    
   // [self lookAction];
    
    [self addView];
    
    
}
-(void)addView{

    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtomItemAction:)];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH-20, SCREEN_WIDTH-20)];
    imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageView];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(15, imageView.bottom+10, self.view.width-30, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.font = [UIFont systemFontOfSize:14];
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.text=@"将二维码/条形码放入框内，即可自动扫描";
    [self.view addSubview:labIntroudction];
    
    UIButton * retry = [UIButton buttonWithType:UIButtonTypeCustom];
    retry.frame = CGRectMake(30, labIntroudction.bottom+10,SCREEN_WIDTH-30*2, 40);
    [retry setTitle:@"重新扫描" forState:0<<6];
    retry.backgroundColor = [UIColor orangeColor];
    [retry addTarget:self action:@selector(retry:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:retry];
    
    
    self.qrCodeHandler = [[QRCodeHandler alloc] initInView:self.view withCaptureFrame:CGRectMake(20, 90,SCREEN_WIDTH-40, SCREEN_WIDTH-40)];
    self.qrCodeHandler.delegate = self;


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.qrCodeHandler startRunning];
}

- (void)rightBarButtomItemAction:(UIBarButtonItem *)item{
    [self setupImagePickerController];
}

- (void)retry:(UIButton *)btn{
    [self.qrCodeHandler startRunning];
}

#pragma mark -- 扫描二维码代理回调
- (void)qrCodeMessageString:(NSString *)messageString{
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:messageString delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//    [alert show];
    [self loadweb:messageString];
}

#pragma mark -- 识别图中二维码
- (void)recognizedQRCodeOfImage:(UIImage *)image{
    [QRCodeHandler recognizedQRCodeOfImage:image complete:^(NSString *messageString, BOOL success) {
        if (success) {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:messageString delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//            
//          
//            [alert show];
              [self loadweb:messageString];
        }
    }];
}

#pragma mark  -- imagepicker
- (void)setupImagePickerController{
    _imagePicker=[[UIImagePickerController alloc]init];
    _imagePicker.allowsEditing=NO;
    _imagePicker.delegate=self;
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //系统相册
    [self presentViewController:_imagePicker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self recognizedQRCodeOfImage:image];
    }
    _imagePicker = nil;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    _imagePicker = nil;
}


#pragma mark -------原生扫描二维码-------
//读取二维码
-(void)lookAction{
    self.view.backgroundColor = GlobBackGroundColor;
    self.navigationItem.title = @"扫一扫";
    //用来展示扫描结果
    self.labelv=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    self.labelv.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.labelv];
    // 1.创建捕捉会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    
    // 2.添加输入设备(数据从摄像头输入)
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [session addInput:input];
    
    // 3.添加输出数据(示例对象-->类对象-->元类对象-->根元类对象)
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
    
    // 3.1.设置输入元数据的类型(类型是二维码数据)
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // 4.添加扫描图层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    //扫描匡大小
    layer.frame=self.view.bounds;
    //layer.frame = CGRectMake(0, 150, 200, 200);
    //    layer.center=self.view.center;
    
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    
    // 5.开始扫描
    [session startRunning];
    
    
}
#pragma mark - 实现output的回调方法
// 当扫描到数据时就会执行该方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        NSLog(@"%@", object.stringValue);
        self.labelv.text =object.stringValue;
        
        self.webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100)];
        [self.view addSubview:self.webview];
        
        NSURLRequest*request=[NSURLRequest requestWithURL:[NSURL URLWithString:object.stringValue]];
        
        [self.webview loadRequest: request];
        
        self.webview.delegate=self;
        // 停止扫描
        [self.session stopRunning];
        
        // 将预览图层移除
        [self.layer removeFromSuperlayer];
        
        //网络加载扫描结果
        [self loadweb:object.stringValue];
        
    } else {
        NSLog(@"没有扫描到数据");
    }
}

//展示二维码内容
-(void)loadweb:(NSString*)string{
    
    self.webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-100)];
    [self.view addSubview:self.webview];
    
    NSURLRequest*request=[NSURLRequest requestWithURL:[NSURL URLWithString:string]];
    
    [self.webview loadRequest: request];
    
    self.webview.delegate=self;
    
//    UIButton*buttonm = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    buttonm.frame = CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 100);
//    buttonm.backgroundColor = [UIColor redColor];
//    [buttonm setTitle:@"返回" forState:(UIControlStateNormal)];
//    [self.view addSubview:buttonm];
//    [buttonm addTarget:self action:@selector( backAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

//-(void)backAction:(UIButton*)sender{
//
//
//    [self dismissViewControllerAnimated:YES completion:nil];
//}





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
