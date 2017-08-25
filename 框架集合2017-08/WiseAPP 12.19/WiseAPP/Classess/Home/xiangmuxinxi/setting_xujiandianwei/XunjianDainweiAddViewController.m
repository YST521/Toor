//
//  XunjianDainweiAddViewController.m
//  WiseAPP
//
//  Created by app on 16/11/4.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XunjianDainweiAddViewController.h"
#import "XunjiandanModel.h"
#import "XunjiandianweiViewController.h"

@interface XunjianDainweiAddViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate>
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)UITableView* XunjianTypeTableView;
@property(nonatomic,strong)UITextField * pointNameFi;
@property(nonatomic,strong)UITextView* renwuFv;

@property(nonatomic,strong)UIView* bgView;
@property(nonatomic,strong)UILabel* titleLa;
@property(nonatomic,strong)NSArray* pickArray;
@property(nonatomic,strong)UIPickerView*pickView;
@property(nonatomic,strong)UIView* photoView;
@property (nonatomic, strong) WSImagePickerView *pickerView;
@property(nonatomic,strong)NSString* dianweiType;

@end
static NSString* xunjiandianweiID = @"xunjiandianweiID";
@implementation XunjianDainweiAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"巡检点位设置";
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    [self addData];
    [self addView];
    [self setupPickerView];
    [self textViewDelegate];
}
#pragma mark - UITextViewDelegate
-(void)textViewDelegate{
    
    self.renwuFv.text=@"例如：工作时间不得玩手机";
    self.renwuFv.delegate=self;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"例如：工作时间不得玩手机";
        
        textView.textColor = textColorPlace;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"例如：工作时间不得玩手机"]){
        textView.text=@"";
        
        textView.textColor=[UIColor blackColor];
    }
    
}

//图片选择
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
        [self.photoView addSubview:pickerView];
        self.pickerView = pickerView;
        
        //refresh superview height
        [pickerView refreshImagePickerViewWithPhotoArray:nil];
    }
    

    
-(void)saveAction:(UIButton*)sender{

    if (self.upPageType==1) {
        [self updataDate];
    } else {
        [self requestPointName];
    }
   
    
}
//condition
-(void)requestPointName{
    if ([self.pointNameFi.text isEqualToString:@" "]||self.pointNameFi.text.length==0 ) {
        [self AlerVCtitleString:@"提示" messageString:@"点位名称不能为空" doneString:@"确定"];
    } else {
        
        [self requestPointType];
    }


}
-(void)requestPointType{
    if ([self.dianweiType isEqualToString:@" "]||self.dianweiType.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"巡检方式不能为空" doneString:@"确定"];
    } else {
        [self requestContent];
    }


}
-(void)requestContent{
    if ([self.renwuFv.text isEqualToString:@" "]||self.renwuFv.text.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"巡检任务不能为空" doneString:@"确定"];
    } else {
        [self loadData];
    }

}




-(void)updataDate{
    //select photo Array
    NSArray *array = [_pickerView getPhotos];
    //项目ID
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    //上传参数
    [param setObject:ID forKey:@"projectid"];
    [param setObject:@(self.model.xunjiandianID) forKey:@"id"];
    [param setObject:self.pointNameFi.text  forKey:@"inspectionname"];
    if ([self.dianweiType isEqualToString:@"二维码"]) {
       [param setObject:@(1) forKey:@"inspectionmethod"];
    }else if ([self.dianweiType isEqualToString:@"拍照"]){
        
        [param setObject:@(2) forKey:@"inspectionmethod"];
        
    }
    [param setObject:self.renwuFv.text forKey:@"inspectioncontent"];
    
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
    
    [manger POST:[self urlRequestChildreurl:@"inspectionpointsUpdate"] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
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
     dispatch_async(dispatch_get_main_queue(), ^{

         //页面跳转
        // if (responseObject[@"resultCode"]==0) {
             [self turnPage];
       //  }
         

     });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //隐藏指示器
        [MBProgressHUD hideHUDForView:nil animated:YES];
        
        
    }];
}

-(void)loadData{
    //select photo Array
 NSArray *array = [_pickerView getPhotos];
    //项目ID
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    //上传参数
    [param setObject:ID forKey:@"projectid"];
    [param setObject:self.pointNameFi.text  forKey:@"inspectionname"];
    if ([self.dianweiType isEqualToString:@"二维码"]) {
        [param setObject:@(1) forKey:@"inspectionmethod"];
    }else if ([self.dianweiType isEqualToString:@"拍照"]){
    
     [param setObject:@(2) forKey:@"inspectionmethod"];
    
    }
  
      [param setObject:self.renwuFv.text forKey:@"inspectioncontent"];
    
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
    
    [manger POST:[self urlRequestChildreurl:@"inspectionpointsAdd"] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
       
            //页面跳转
            //if (responseObject[@"resultCode"]==0) {
              [self turnPage];
            //}
        
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //隐藏指示器
        [MBProgressHUD hideHUDForView:nil animated:YES];
        
        
    }];



}
-(void)turnPage{
    for (UIViewController* controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[XunjiandianweiViewController class]]) {
            XunjiandianweiViewController*xujiandianweiVC=(XunjiandianweiViewController*)controller;
            [self.navigationController popToViewController:xujiandianweiVC animated:YES];
        }
    }

}

-(void)addData{
    self.dataArray=[NSMutableArray array];
    self.dataArray=(NSMutableArray*) @[@"11",@"22",@"33",@"55",@"66"];
    self.pickArray=[NSArray array];
    self.pickArray= @[@"拍照",@"二维码"];
    
}
-(void)addView{
    UILabel* titleLa=[[UILabel alloc]init];
    titleLa.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 30);
    titleLa.text = @"巡检点名称";
    titleLa.textColor = textCententColor;
    [self.view addSubview:titleLa];
    
    UIImageView*imagBg=[[UIImageView alloc]init];
    imagBg.frame = STANDARDWH(CGRectGetMaxY(titleLa.frame)+10);
    //textfilebackgroundimage.png // textfile
    imagBg.image =[UIImage imageNamed:@"home_text_bg.png"];
    [self.view addSubview:imagBg];
    imagBg.userInteractionEnabled = YES;
    
    self.pointNameFi=[[UITextField alloc]init];
    self.pointNameFi.frame = CGRectMake(10, 0, imagBg.width-20, imagBg.height);
    self.pointNameFi.placeholder =@"例如：1号点";
     self.pointNameFi.textColor = textCententColor;
    //self.produceFile.backgroundColor=[UIColor blueColor];
    [imagBg addSubview:self.pointNameFi];
   
    self.XunjianTypeTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imagBg.frame)+10, SCREEN_WIDTH, imagBg.height) style:(UITableViewStylePlain)];
    [self.view addSubview:self.XunjianTypeTableView];
    self.XunjianTypeTableView.dataSource = self;
    self.XunjianTypeTableView.delegate = self;
    [self.XunjianTypeTableView registerClass:[PublieTableViewCell class] forCellReuseIdentifier:xunjiandianweiID];
    
    UILabel* renwuLa=[[UILabel alloc]init];
   renwuLa.frame = CGRectMake(10, CGRectGetMaxY(self.XunjianTypeTableView.frame)+10, SCREEN_WIDTH-20, 30);
    renwuLa.text = @"巡检任务";
    renwuLa.textColor = textCententColor;
    [self.view addSubview:renwuLa];
   
    //输入框
    UIImage*image=[UIImage imageNamed:@"home_textView_contentbg.png"];
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame =CGRectMake(STANDARD_X, CGRectGetMaxY(renwuLa.frame)+10, STANDARD_WIDTH,image.size.height);
    textfBg.image=image;
    [self.view addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
     self.renwuFv=[[UITextView alloc]init];
     self.renwuFv.frame = textfBg.bounds;
    self.renwuFv.backgroundColor=[UIColor clearColor];
    self.renwuFv.font =[UIFont systemFontOfSize:17];
    [textfBg addSubview: self.renwuFv];
     self.renwuFv.text=@"例如：工作时间不得玩手机";
    self.renwuFv.textColor=textColorPlace;
    
    UILabel*warinLa=[[UILabel alloc]init];
    warinLa.frame = CGRectMake( self.renwuFv.width-100,  self.renwuFv.height-20, 100, 20);
    warinLa.text =@"210字";
    warinLa.textColor =[UIColor grayColor];
    warinLa.font =[UIFont systemFontOfSize:14];
    warinLa.textAlignment = NSTextAlignmentCenter;
    [textfBg addSubview:warinLa];
    
    self.photoView=[[UIView alloc]init];
    self.photoView.frame = CGRectMake(0, CGRectGetMaxY(textfBg.frame)+10, SCREEN_WIDTH, PROPORTION_HIGHT(100));
    //self.photoView.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.photoView];
    
  }
#pragma mark ------tableviewdelegate ----------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublieTableViewCell*cell=[self.XunjianTypeTableView dequeueReusableCellWithIdentifier:xunjiandianweiID];
    cell.leftLa.text = @"巡检方式";
    cell.leftLa.textColor =[UIColor grayColor];
    

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  
    [self creatPickView:@"巡检方式"];
}


//pickViewdelegate
-(void)creatPickView:(NSString*)title {
    self.bgView=[[UIView alloc]initWithFrame:UIScreenBpunds];
    self.bgView.backgroundColor = popBGColore;
    [self.view addSubview:self.bgView];
    self.bgView.userInteractionEnabled = YES;
    
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT((self.pickArray.count+2)*45)+30);
    bgView.backgroundColor=[UIColor whiteColor];
    [self.bgView addSubview:bgView];
    
    UIImageView*titleBg=[[UIImageView alloc]init];
    titleBg.frame = CGRectMake(0, 0, bgView.width,  STANDARD_HEIGHT);
    titleBg.image =[UIImage imageNamed:@"nabackgroundImage.png"];
    [bgView addSubview:titleBg];
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:titleBg.bounds];
    titleLabel.text =  title;
    titleLabel.textAlignment =NSTextAlignmentCenter;
    titleLabel.textColor =  [UIColor whiteColor];
    [bgView addSubview: titleLabel];
    
    self.pickView=[[UIPickerView alloc]init];
    self.pickView.frame = CGRectMake(0, CGRectGetMaxY(titleBg.frame), bgView.width, PROPORTION_HIGHT(45*self.pickArray.count));
    [bgView addSubview:self.pickView];
    self.pickView.delegate =self;
    self.pickView.dataSource = self;
    self.pickView.userInteractionEnabled = YES;
    self.bgView.hidden = NO;
    
    UIButton* XueLibackBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    XueLibackBtn.frame = CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(self.pickView.frame)+10, (bgView.width-PROPORTION_WIDTH(10)*2-10)/2, STANDARD_HEIGHT);
    KUIbutton( XueLibackBtn);
    KUIbuttonClick(XueLibackBtn);
    [ XueLibackBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [bgView addSubview: XueLibackBtn];
    
    UIButton* XueLidoneBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    XueLidoneBtn.frame=CGRectMake(CGRectGetMaxX( XueLibackBtn.frame)+10,  XueLibackBtn.y,  XueLibackBtn.width,  XueLibackBtn.height);
    KUIbutton(XueLidoneBtn);
    KUIbuttonClick(XueLidoneBtn);
    [XueLidoneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [bgView addSubview:XueLidoneBtn];
    
    
    [XueLibackBtn addTarget:self action:@selector(xueliBackAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [XueLidoneBtn addTarget:self action:@selector(xueliDoneAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)xueliBackAction:(UIButton*)sender{
    
    self.bgView.hidden = YES;
    
}
-(void)xueliDoneAction:(UIButton*)sender{
    
    self.bgView.hidden = YES;
    [self.XunjianTypeTableView reloadData];
}
#pragma mark UIPickerView Delegate Method 代理方法
//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;//第一个展示字母、第二个展示数字
}
//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    return self.pickArray.count;
}

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title = nil;
    title = self.pickArray[row];
    self.dianweiType =title;
    NSIndexPath *indexPath = [self.XunjianTypeTableView indexPathForSelectedRow];
    PublieTableViewCell *cell = [self.XunjianTypeTableView cellForRowAtIndexPath: indexPath];
    cell.rightLa.text = self.pickArray[row];
    
    cell.rightLa.textColor= textCententColor;
    
    return title;
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
