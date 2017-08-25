//
//  YezhuEditorViewController.m
//  WiseAPP
//
//  Created by app on 16/12/12.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "YezhuEditorViewController.h" //类名与添加调换 此页面为添加页面
#import "YezhufangViewController.h"
#import "POPView.h"
#import "SelectPhotoView.h"
#import "YezhufangMainViewController.h"
#import "YSHYClipViewController.h"
#import "YezhuModel.h"
#import "pinyin.h"
#import "YezhuShowMessageViewController.h"
#import "WorkTimeView.h"
#import "YezhuGenderView.h"
#import "YezhuaddCell.h"
#import "YezhuOtherView.h"
#import "YezhuEditorViewController.h"
#import "YezueditorTableViewCell.h"


@interface YezhuEditorViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ClipViewControllerDelegate,UITextViewDelegate,passTimHMvalue>
{
    UIImagePickerController * imagePicker;
    ClipType clipType;
    CGFloat radius;
}
@property(nonatomic,assign)UITableViewCellEditingStyle myStaly;

@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)UIView*headView;
@property(nonatomic,strong)UIButton*addButton;
@property(nonatomic,strong)UITextField *yezhuTextfile;
@property(nonatomic,strong)UITextField*yezhuGender;
@property(nonatomic,strong)UIImageView*yezhuImage;
@property(nonatomic,strong)UITextField*yezhuPoslition;
@property(nonatomic,strong)UITextField*yezhuWorkTIME;
@property(nonatomic,strong)UITextField *carNumber;
@property(nonatomic,strong)UIButton* rightBtn;
@property(nonatomic,strong)UIImage* headImage;
@property(nonatomic,strong)UIImage* uploadImage;

@property(nonatomic,strong)UIButton* userImageBtn;
@property(nonatomic,strong)POPView* PnameView;
@property(nonatomic,strong)YezhuGenderView* genderView;
@property(nonatomic,strong)POPView* PageView;
@property(nonatomic,strong)POPView* PheightView;
@property(nonatomic,strong)POPView* PositionView;
@property(nonatomic,strong)WorkTimeView* PtimeView;
@property(nonatomic,strong)POPView* PcarNumView;
@property(nonatomic,strong)SelectPhotoView* selectView;
@property(nonatomic,strong)POPView * phoneView;
@property(nonatomic,strong)YezhuOtherView * potherView;
@property(strong,nonatomic)UIImagePickerController *imagePickerController;
@property(nonatomic,assign)NSInteger uploadImageType;
@property(nonatomic,strong)NSString* gender;
@property(nonatomic,strong)TimeDHViewController*timeVC;


@end
static NSString*yezhuCellID =@"yezhuCellID";

@implementation YezhuEditorViewController

//-(NSMutableArray *)dataArray{
//    if (!_dataArray) {
//        _dataArray = [NSMutableArray alloc];
//    }
//    return _dataArray;
//}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"业主方信息设置";
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self addData];
    [self addView];
    
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}
//保存 存入信息
-(void)saveAction:(UIBarButtonItem*)sender{
    

        //修改  此页面为添加页面 最好将编辑页面与此页面分开
       [self uploadData];
     

    
}
//conditions
//-(void)yezhuName{
//    if ([self.PnameView.popTextFile.text isEqualToString:@" "]) {
//        [self AlerVCtitleString:@"提示" messageString:@"姓名不能为空" doneString:@"确定"];
//    } else {
//        [self conyezhuGender];
//
//    }
//
//}
//-(void)conyezhuGender{
//    if ([self.gender isEqualToString:@" "]) {
//
//        [self AlerVCtitleString:@"提示" messageString:@"性别不能为空" doneString:@"确定"];
//    } else {
//
//
//    }
//
//}
-(void)uploadData{
    
    //项目ID
    NSString* ID= [[SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //账号密码
    [param setObject:ID forKey:@"projectsId"];
    [param setObject:self.PnameView.popTextFile.text forKey:@"name"];
    [param setObject:self.PageView.popTextFile.text forKey:@"age"];
    [param setObject:self.PheightView.popTextFile.text forKey:@"height"];
    [param setObject:self.PositionView.popTextFile.text forKey:@"job"];
    
    if([self.gender isEqualToString:@"女"]){
        [param setObject:@(2) forKey:@"sex"];
    }else if ([self.gender isEqualToString:@"男"]){
        [param setObject:@(1) forKey:@"sex"];
        
    }
    
    NSString*hour=[NSString stringWithFormat:@"%@-%@",self.PtimeView.starTimeFile.text,self.PtimeView.endTimeFile.text];
    [param setObject:hour forKey:@"workinghours"];
    
    NSString*carNum =self.PcarNumView.popTextFile.text;
    NSString* car =[self toUpper:carNum];
    [param setObject:car forKey:@"numberplates"];
    
    [param setObject:self.potherView.popTextFile.text forKey:@"remarks"];
    
    [param setObject:self.phoneView.popTextFile.text forKey:@"phone"];
    
    UIImage*image=self.uploadImage;
    NSData*data1=nil;
    if (!image) {
        UIImage*image=[UIImage imageNamed:@"home_head_image.png"];
        UIImage *image1 =[UIimageScaleImage scaleImage:image toKb:60];
        data1=UIImageJPEGRepresentation(image1, 0.2);
    } else {
        UIImage *image1 =[UIimageScaleImage scaleImage:image toKb:60];
        data1=UIImageJPEGRepresentation(image1, 0.2);
        
    }
    
    
    [RequestManger UPLoadImageUrl:[self urlRequestChildreurl:@"ownerAdd"] parmar:param token:self.tokenString imageData:data1 imageName:@"image" imageFileName:@"image" mimeType:@"image/jpg" succeed:^(id data) {
        NSLog(@"业主添加%@",data);
        [self turnPage];
    } failure:^(NSError *error) {
        NSLog(@"图片上传失败");
    }];
    
}
-(void)editorData{
    //项目ID
    NSString* ID= [[SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //账号密码
    [param setObject:ID forKey:@"projectsId"];
    [param setObject:@(self.model.yezhuID) forKey:@"id"];

    
    if (self.PnameView.popTextFile.text.length ==0||[self.PnameView.popTextFile.text isEqualToString:@" "]) {
        [param setObject:self.model.name forKey:@"name"];
    } else {
        [param setObject:self.PnameView.popTextFile.text forKey:@"name"];
    }
    
    if (self.gender.length == 0) {
        [param setObject:self.model.info[@"sex"] forKey:@"sex"];
    } else {
        if([self.gender isEqualToString:@"女"]){
            [param setObject:@(2) forKey:@"sex"];
        }else if ([self.gender isEqualToString:@"男"]){
            [param setObject:@(1) forKey:@"sex"];
        }
        
    }
    if (self.PageView.popTextFile.text.length  == 0 ||[self.PageView.popTextFile.text isEqualToString:@" "]) {
        [param setObject:self.model.info[@"age"] forKey:@"age"];
    } else {
        [param setObject:@([self.PageView.popTextFile.text intValue]) forKey:@"age"];
    }
    
    if (self.PheightView.popTextFile.text.length  ==0 ||[self.PheightView.popTextFile.text isEqualToString:@" "]) {
        [param setObject:self.model.info[@"height"] forKey:@"height"];
    } else {
        [param setObject:@([self.PheightView.popTextFile.text intValue]) forKey:@"height"];
    }
    if (self.PositionView.popTextFile.text.length  == 0 ||[self.PositionView.popTextFile.text isEqualToString:@" "]) {
        [param setObject:self.model.info[@"job"] forKey:@"job"];
    } else {
        [param setObject:self.PositionView.popTextFile.text forKey:@"job"];
    }
    
    if (self.PtimeView.starTimeFile.text ==nil|| self.PtimeView.endTimeFile.text  ==nil) {
        [param setObject:self.model.info[@"workinghours"] forKey:@"workinghours"];
    } else {
        NSString*hour=[NSString stringWithFormat:@"%@-%@",self.PtimeView.starTimeFile.text,self.PtimeView.endTimeFile.text];
        [param setObject:hour forKey:@"workinghours"];
    }
    if (self.PcarNumView.popTextFile.text ==nil) {
        [param setObject:self.model.info[@"numberplates"] forKey:@"numberplates"];
    } else {
        NSString*carNum =self.PcarNumView.popTextFile.text;
        NSString* car =[self toUpper:carNum];
        [param setObject:car forKey:@"numberplates"];
        
    }
    if (self.phoneView.popTextFile.text ==0 || [self.phoneView.popTextFile.text isEqualToString:@" "]) {
        [param setObject:self.model.info[@"phone"] forKey:@"Phone"];
    } else {
        [param setObject:self.phoneView.popTextFile.text forKey:@"Phone"];
    }
    
    if (self.potherView.popTextFile.text.length ==0 || [self.potherView.popTextFile.text isEqualToString:@" "]) {
        [param setObject:self.model.info[@"remarks"] forKey:@"remarks"];
    } else {
        [param setObject:self.potherView.popTextFile.text forKey:@"remarks"];
    }
    
    
    UIImage*image=self.uploadImage;
    NSData*data1=nil;
    if (!image) {
        UIImageView*imageview=[[UIImageView alloc]init];
        imageview.frame=CGRectMake(0, 0, 100, 100);
        [self.view addSubview:imageview];
        imageview.hidden=YES;
        [imageview sd_setImageWithURL:[NSURL URLWithString:[self urlStringWithImageUrl:self.model.images]]];
        
        UIImage *image1 =[UIimageScaleImage scaleImage:imageview.image toKb:60];
        data1=UIImageJPEGRepresentation(image1, 0.2);
    } else {
        UIImage *image1 =[UIimageScaleImage scaleImage:image toKb:60];
        data1=UIImageJPEGRepresentation(image1, 0.2);
        
    }
    
    
    [RequestManger UPLoadImageUrl:[self urlRequestChildreurl:@"ownerUpdate"] parmar:param token:self.tokenString imageData:data1 imageName:@"image" imageFileName:@"image" mimeType:@"image/jpg" succeed:^(id data) {
        NSLog(@"业主添加%@",data);
        [self turnPage];
    } failure:^(NSError *error) {
        NSLog(@"图片上传失败");
    }];
    
    
}

-(void)addMessage{
    
    //项目ID
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //账号密码
    [param setObject:ID forKey:@"projectsId"];
    
    if (self.PnameView.popTextFile.text.length ==0||[self.PnameView.popTextFile.text isEqualToString:@" "]) {
        [param setObject:@"暂无" forKey:@"name"];
    } else {
        [param setObject:self.PnameView.popTextFile.text forKey:@"name"];
    }
    
    if (self.gender.length == 0) {
        [param setObject:@(1) forKey:@"sex"];
    } else {
        if([self.gender isEqualToString:@"女"]){
            [param setObject:@(2) forKey:@"sex"];
        }else if ([self.gender isEqualToString:@"男"]){
            [param setObject:@(1) forKey:@"sex"];
            
        }
        
    }
    if (self.PageView.popTextFile.text.length  == 0 ||[self.PageView.popTextFile.text isEqualToString:@" "]) {
        [param setObject:@(0) forKey:@"age"];
    } else {
        [param setObject:@([self.PageView.popTextFile.text intValue]) forKey:@"age"];
    }
    
    if (self.PheightView.popTextFile.text.length  ==0 ||[self.PheightView.popTextFile.text isEqualToString:@" "]) {
        [param setObject:@(0) forKey:@"height"];
    } else {
        [param setObject:@([self.PheightView.popTextFile.text intValue]) forKey:@"height"];
    }
    if (self.PositionView.popTextFile.text.length  == 0 ||[self.PositionView.popTextFile.text isEqualToString:@" "]) {
        [param setObject:@"暂无" forKey:@"job"];
    } else {
        [param setObject:self.PositionView.popTextFile.text forKey:@"job"];
    }
    
    if (self.PtimeView.starTimeFile.text ==nil|| self.PtimeView.endTimeFile.text  ==nil) {
        [param setObject:@"暂无" forKey:@"workinghours"];
    } else {
        NSString*hour=[NSString stringWithFormat:@"%@-%@",self.PtimeView.starTimeFile.text,self.PtimeView.endTimeFile.text];
        [param setObject:hour forKey:@"workinghours"];
    }
    if (self.PcarNumView.popTextFile.text ==nil) {
        [param setObject:@"暂无" forKey:@"numberplates"];
    } else {
        NSString*carNum =self.PcarNumView.popTextFile.text;
        NSString* car =[self toUpper:carNum];
        [param setObject:car forKey:@"numberplates"];
        
    }
    if (self.phoneView.popTextFile.text ==0 || [self.phoneView.popTextFile.text isEqualToString:@" "]) {
        [param setObject:@"暂无" forKey:@"Phone"];
    } else {
        [param setObject:self.phoneView.popTextFile.text forKey:@"Phone"];
    }
    
    if (self.potherView.popTextFile.text.length ==0 || [self.potherView.popTextFile.text isEqualToString:@" "]) {
        [param setObject:@"暂无" forKey:@"remarks"];
    } else {
        [param setObject:self.potherView.popTextFile.text forKey:@"remarks"];
    }
    
    NSLog(@"%@",param);//my_image
    //        //UIImage*image=self.uploadImage;
    UIImage*image= [UIImage imageNamed:@"home_head_image.png"];
    NSData*data1=nil;
    //    if (!image) {
    //        UIImage*image=[UIImage imageNamed:@"home_head_image.png"];
    //        UIImage *image1 =[UIimageScaleImage scaleImage:image toKb:100];
    //        data1=UIImagePNGRepresentation(image1);
    //    } else {
    UIImage *image1 =[UIimageScaleImage scaleImage:image toKb:100];
    // data1=UIImageJPEGRepresentation(image1, 0.2);
    data1=UIImagePNGRepresentation(image1);
    //
    //    }
    
    [RequestManger UPLoadImageUrl:[self urlRequestChildreurl:@"ownerUpdate"] parmar:param token:self.tokenString imageData:data1 imageName:@"image" imageFileName:@"image.png" mimeType:@"image/jpg" succeed:^(id data) {
        
        for (NSArray*array in [data allValues]) {
            
            NSLog(@"图片上传 %@",array);
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

//跳转
-(void)turnPage{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIViewController* controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[YezhufangMainViewController  class]]) {
                YezhufangMainViewController* yezhuShowVC =(YezhufangMainViewController*)controller;
                [self.navigationController popToViewController:yezhuShowVC animated:YES];
            }
        }
        
    });
    
    
}



-(void)addData{
    self.dataArray = [[NSMutableArray alloc]init];
    
    
    self.dataArray =(NSMutableArray*) @[@"姓名",@"性别",@"年龄",@"身高",@"职务",@"工作时间",@"车牌号",@"手机号码",@"其它"];
}


-(void)addView{
    
    self.tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, PROPORTION_HIGHT(45*8+70+20+20)) style:(UITableViewStylePlain)];
    [self.view addSubview:self.tableview];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[YezueditorTableViewCell class] forCellReuseIdentifier:yezhuCellID];
    //add footView
    [self addFootView];
    
}
-(void)addFootView{
    
    //footView
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    self.tableview.tableHeaderView = self.headView ;
    
    UILabel*leftLabel=[[UILabel alloc]init];
    leftLabel.frame = CGRectMake(10,  self.headView .height/2-10, 100, 20);
    leftLabel.text = @"业主方头像";
    [ self.headView  addSubview:leftLabel];
    UILabel*rightLa = [[UILabel alloc]init];
    rightLa.frame = CGRectMake(SCREEN_WIDTH/2.5, leftLabel.y, 80, 20);
    rightLa.text = @"显示头像";
    [ self.headView addSubview:rightLa];
    //是否显示图像
    self.rightBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.frame = CGRectMake(CGRectGetMaxX(rightLa.frame)+10, leftLabel.y, 20, 20) ;
    [ self.headView  addSubview:self.rightBtn];
    [self.rightBtn setImage:[UIImage imageNamed:@"home_yezhuEye"] forState:(UIControlStateSelected)];
    [self.rightBtn setImage:[UIImage imageNamed:@"iconeyelook.png"] forState:(UIControlStateNormal)];
    [self.rightBtn addTarget:self action:@selector(lookHeadImageAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.userImageBtn.hidden = NO;
    
    self.userImageBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.userImageBtn.frame = CGRectMake(0, 0, PROPORTION_WIDTH(60), PROPORTION_HIGHT(60));
    self.userImageBtn.center = CGPointMake(CGRectGetMaxX(self.rightBtn.frame)+5+self.userImageBtn.width/2, self.headView .height/2);
    self.userImageBtn.layer.cornerRadius = self.userImageBtn.width/2;
    self.userImageBtn.layer.masksToBounds = YES;
    UIImage* image=[UIImage imageNamed:@"home_head_image.png"];
    [self.userImageBtn setBackgroundImage:image forState:(UIControlStateNormal)];
    [self.userImageBtn sd_setImageWithURL:[NSURL URLWithString:[self urlStringWithImageUrl:self.model.images]] forState:(UIControlStateNormal)];
    
    [ self.headView  addSubview:self.userImageBtn];
    [self.userImageBtn addTarget:self action:@selector(imageBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //UIImage*rightImage=[UIImage imageNamed:@"icon_right"] ;
    UIButton*  nextBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    nextBtn.frame = CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(25), PROPORTION_HIGHT(27.5),PROPORTION_WIDTH(8), PROPORTION_HIGHT(15));
    //nextBtn.backgroundColor=[UIColor purpleColor];
    [self.headView  addSubview:nextBtn];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"icon_right"] forState:(UIControlStateNormal)];
    
}
//显示头像
-(void)lookHeadImageAction:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.userImageBtn.hidden = YES;
        self.uploadImageType =1;
    } else {
        self.uploadImageType =2;
        self.userImageBtn.hidden = NO;
        
    }
    
}
-(void)imageBtnAction:(UIButton*)sender{
    self.selectView =[[SelectPhotoView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview:self.selectView];
    self.selectView.hidden = NO;
    
    UITapGestureRecognizer*selectPhotoTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectPhotoTapActin:)];
    [self.selectView.photoview addGestureRecognizer:selectPhotoTap];
    
    UITapGestureRecognizer*selectCameraTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectcamerTapActin:)];
    [self.selectView.cameraView addGestureRecognizer:selectCameraTap];
    
}
-(void)selectPhotoTapActin:(UITapGestureRecognizer*)sender{
    
    //camera
    [self getImageFromIpc];
    self.selectView.hidden = YES;
    
}
- (void)getImageFromIpc
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    self.imagePickerController = [[UIImagePickerController alloc] init];
    
    // 3.
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 4.
    self.imagePickerController.delegate = self;
    // 5.modal
    [self presentViewController:  self.imagePickerController animated:YES completion:nil];
    
    self.selectView.hidden = YES;
}

-(void)selectcamerTapActin:(UITapGestureRecognizer*)sender{
    //camera
    [self camera];
    
}
-(void)camera{
    
    self.imagePickerController = [[UIImagePickerController alloc]init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = YES;
    
    // 获取支持的媒体格式
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    // 判断是否支持需要设置的sourceType
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
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
        
        // 4、推送图片拾取器控制器
        if([[[UIDevice
              currentDevice] systemVersion] floatValue]>=8.0) {
            
            self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            
        }
        [self presentViewController:_imagePickerController animated:YES completion:nil];
        
    }else {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"当前设备不支持拍照" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {   }]];
        
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
    
    self.selectView.hidden = YES;
}
//拍照照片选取
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage * image = info[@"UIImagePickerControllerOriginalImage"];
    //UIImage * image = info[UIImagePickerControllerEditedImage];
    //      UIImage * image = info[UIImagePickerControllerOriginalImage];
    //    if (!image) {
    //        image = info[UIImagePickerControllerOriginalImage];
    //    }
    self.uploadImage = image;
    YSHYClipViewController * clipView = [[YSHYClipViewController alloc]initWithImage:image];
    clipView.delegate = self;
    clipView.clipType = clipType; //支持圆形:CIRCULARCLIP 方形裁剪:SQUARECLIP   默认:圆形裁剪
    clipView.radius = 120;   //设置 裁剪框的半径
    //    clipView.scaleRation = 2;// 图片缩放的最大倍数 默认为3
    [_imagePickerController pushViewController:clipView animated:YES];
    
}
//用户头像裁剪delegate
#pragma mark - ClipViewControllerDelegate
-(void)ClipViewController:(YSHYClipViewController *)clipViewController FinishClipImage:(UIImage *)editImage
{
    [clipViewController dismissViewControllerAnimated:YES completion:^{
        [self.userImageBtn setImage:editImage forState:UIControlStateNormal];
        self.headImage = editImage;
        // self.uploadImage = editImage;
    }];
}
#pragma mark ---- tableviewdelegate--------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return  PROPORTION_HIGHT(45);
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YezueditorTableViewCell*cell = [self.tableview dequeueReusableCellWithIdentifier:yezhuCellID];
    cell.leftLa.text= self.dataArray[indexPath.row];


    self.tableview.tableFooterView=[[UIView alloc]init];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if ( indexPath.row == 0) {
        self.PnameView =[[POPView alloc]initWithFrame:UIScreenBpunds];
        self.PnameView.popTitle.text = @"设置姓名";
        self.PnameView.popTextFile.placeholder = @"请输入姓名";
        [self.view addSubview:self.PnameView];
        [self.PnameView.popDoneBtn addTarget:self action:@selector(namePopAction:) forControlEvents:(UIControlEventTouchUpInside )];
        [[SingleXiangmuxnxi SingleXiangmuxinxiManger].YezhumessageArray addObject:self.PnameView.popTextFile.text];
        
    } else if (indexPath.row ==1){
        
        self.genderView=[[YezhuGenderView alloc]initWithFrame:UIScreenBpunds];
        self.genderView.selectTitle.text=@"性别设置";
        [self.view addSubview:self.genderView];
        
        [self.genderView.manBtn addTarget:self action:@selector(genderManAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.genderView.womenBtn addTarget:self action:@selector(genderWomenAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }else if (indexPath.row ==2){
        self.PageView =[[POPView alloc]initWithFrame:UIScreenBpunds];
        self.PageView.popTitle.text = @"设置年龄";
        self.PageView.popTextFile.placeholder = @"请输入年龄";
        self.PageView.popTextFile.keyboardType=UIKeyboardTypeNumberPad;
        [self.view addSubview:self.PageView];
        [self.PageView.popDoneBtn addTarget:self action:@selector(ageAction:) forControlEvents:(UIControlEventTouchUpInside )];
    }else if (indexPath.row ==3){
        self.PheightView =[[POPView alloc]initWithFrame:UIScreenBpunds];
        self.PheightView.popTitle.text = @"设置身高";
        self.PheightView.popTextFile.keyboardType=UIKeyboardTypeNumberPad;
        
        self.PheightView.popTextFile.placeholder = @"请输入身高(cm)";
        [self.view addSubview:self.PheightView];
        [self.PheightView.popDoneBtn addTarget:self action:@selector(heightAction:) forControlEvents:(UIControlEventTouchUpInside )];
    }else if (indexPath.row ==4){
        self.PositionView =[[POPView alloc]initWithFrame:UIScreenBpunds];
        self.PositionView.popTitle.text = @"设置职务";
        self.PositionView.popTextFile.placeholder = @"请输入职务";
        [self.view addSubview: self.PositionView];
        [ self.PositionView.popDoneBtn addTarget:self action:@selector(opstionAction:) forControlEvents:(UIControlEventTouchUpInside )];
    }else if (indexPath.row ==5){
        self.PtimeView =[[WorkTimeView alloc]initWithFrame:UIScreenBpunds];
        self.PtimeView.popTitle.text = @"设置工作时间";
        self.PtimeView.starTimeFile.placeholder = @"上班时间";
        self.PtimeView.endTimeFile.placeholder = @"下班时间";
        self.PtimeView.starTimeFile.delegate=self;
        self.PtimeView.endTimeFile.delegate=self;
        [self.view addSubview:self.PtimeView];
        [self.PtimeView.popDoneBtn addTarget:self action:@selector(timeAction:) forControlEvents:(UIControlEventTouchUpInside )];
    }else if (indexPath.row ==6){
        self.PcarNumView =[[POPView alloc]initWithFrame:UIScreenBpunds];
        self.PcarNumView.popTitle.text = @"设置车牌号";
        //        self.PcarNumView.popTextFile.keyboardType=UIKeyboardTypeDefault;
        self.PcarNumView.popTextFile.placeholder = @"请输入车牌号";
        [self.view addSubview:self.PcarNumView];
        //大写
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange)name:UITextFieldTextDidChangeNotification object:self.PcarNumView.popTextFile];
        [self.PcarNumView.popDoneBtn addTarget:self action:@selector(carAction:) forControlEvents:(UIControlEventTouchUpInside )];
    }else if (indexPath.row ==7){
        self.phoneView =[[POPView alloc]initWithFrame:UIScreenBpunds];
        self.phoneView.popTitle.text = @"添加手机号码";
        self.phoneView.popTextFile.placeholder = @"请输入手机号码";
        self.phoneView.popTextFile.keyboardType = UIKeyboardTypeNumberPad;
        [self.view addSubview:self.phoneView];
        [self.phoneView.popDoneBtn addTarget:self action:@selector(phoneAction:) forControlEvents:(UIControlEventTouchUpInside )];
    }else if (indexPath.row ==8){
        self.potherView =[[YezhuOtherView alloc]initWithFrame:UIScreenBpunds];
        self.potherView.popTitle.text = @"其他";
        //self.potherView.popTextFile.placeholder = @"请输入其他描述";
        [self.view addSubview:self.potherView];
        [self textViewDelegate];
        [self.potherView.popDoneBtn addTarget:self action:@selector(otherAction:) forControlEvents:(UIControlEventTouchUpInside )];
    }
}
//textFILE
-(void)textChange{
    self.PcarNumView.popTextFile.text = [self toUpper:self.PcarNumView.popTextFile.text];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //turn page
    if (textField ==self.PtimeView.starTimeFile) {
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
        self.PtimeView.starTimeFile.text =timeString;
        self.PtimeView.starTimeFile.textColor=textCententColor;
        
    } else {
        
        self.PtimeView.endTimeFile.text= timeString;
        self.PtimeView.endTimeFile.textColor =textCententColor;
    }
    
}
//textview
-(void)textViewDelegate{
    
    self.potherView.popTextFile.text=@"某某的亲戚";
    self.potherView.popTextFile.delegate=self;
    
}
#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"某某的亲戚";
        
        textView.textColor = textColorPlace;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"某某的亲戚"]){
        textView.text=@"";
        
        textView.textColor=[UIColor blackColor];
    }
    
}


//弹框点击事件
//姓名
-(void)namePopAction:(UIButton*)sender{
    
    
    [self popCellBack:self.PnameView.popTextFile.text];
    self.PnameView.hidden = YES;
    
}
//gender
-(void)genderManAction:(UIButton*)sender{
    
    
    self.gender = @"男";
    [self popCellBack:self.gender];
    self.genderView.hidden = YES;
    sender.backgroundColor=[UIColor grayColor];
    self.genderView.hidden=YES;
    
}
-(void)genderWomenAction:(UIButton*)sender{
    //if (sender.selected ==YES) {
    self.gender = @"女";
    [self popCellBack:self.gender];
    sender.backgroundColor=[UIColor grayColor];
    self.genderView.hidden=YES;
    
    //    } else {
    //         sender.backgroundColor=[UIColor whiteColor];
    //    }
}
//age
-(void)ageAction:(UIButton*)sender{
    
    [self popCellBack:self.PageView.popTextFile.text];
    self.PageView.hidden = YES;
}
//hight
-(void)heightAction:(UIButton*)sender{
    [self popCellBack:self.PheightView.popTextFile.text];
    self.PheightView.hidden = YES;
}
//position
-(void)opstionAction:(UIButton*)sender{
    [self popCellBack:self.PositionView.popTextFile.text];
    self.PositionView.hidden = YES;
}
//work time
-(void)timeAction:(UIButton*)sender{
    NSString*timeStr=[NSString stringWithFormat:@"%@-%@",self.PtimeView.starTimeFile.text,self.PtimeView.endTimeFile.text];
    [self popCellBack:timeStr];
    self.PtimeView.hidden = YES;
}
//care number
-(void)carAction:(UIButton*)sender{
    [self popCellBack:self.PcarNumView.popTextFile.text];
    self.PcarNumView.hidden = YES;
}
// phone number
-(void)phoneAction:(UIButton*)sender{
    if ([self valiMobile:self.phoneView.popTextFile.text]) {
        [self popCellBack:self.phoneView.popTextFile.text];
        self.phoneView.hidden = YES;
    } else {
        [self AlerVCtitleString:@"提示" messageString:@"手机号格式错误,请重新输入手机号" doneString:@"重新输入"];
    }
    
    
}
//other
-(void)otherAction:(UIButton*)sender{
    [self popCellBack:self.potherView.popTextFile.text];
    self.potherView.hidden = YES;
}

-(void)popCellBack:(NSString*)backString{
    
    NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
    
  YezueditorTableViewCell *cell = [self.tableview cellForRowAtIndexPath: indexPath];
    cell.rightLa.text = backString;
    cell.rightLa.textColor = textCententColor;
    //refresh data
    [self.tableview reloadData];
    
    
}
//base64转image
-(UIImage*)baseToImageBString:(NSString*)baseString{
    
    if(baseString.length ==0 ){
        NSLog(@"数据为空");
    }
    NSData *decodedImageData = [[NSData alloc]
                                
                                initWithBase64EncodedString:baseString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    
    return decodedImage;
}
//image转base64
-(NSString*)imageToBase:(UIImage*)image{
    
    //UIImage *baseImage = [UIImage imageNamed:@"base64"];
    UIImage *baseImage = image;
    
    NSData*imageg = UIImageJPEGRepresentation(baseImage, 0.2);
    
    NSString *imageString = [imageg base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return imageString;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.yezhuTextfile resignFirstResponder];
    
    
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
