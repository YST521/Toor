//
//  BanhuiAddViewController.m
//  WiseAPP
//
//  Created by app on 16/11/4.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BanhuiAddViewController.h"
#import "BanhuiModel.h"
#import "BanhuiSettingViewController.h"



@interface BanhuiAddViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate,passTimHMvalue,UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)UITableView* XunjianTypeTableView;
@property(nonatomic,strong)UITextField * banhuiStarTimeFi;
@property(nonatomic,strong)UITextView* banhuiContentFv;
@property(nonatomic,strong)UITextField* banhuiAddressFi;
@property(nonatomic,strong)UIView* photoImageView;

@property(nonatomic,strong)UIView* bgView;
@property(nonatomic,strong)UILabel* titleLa;
@property(nonatomic,strong)NSMutableArray* pickArray;
@property(nonatomic,strong)UIPickerView*pickView;
@property (nonatomic, strong) WSImagePickerView *pickerView;
@property(nonatomic,strong)NSMutableArray* banhuiIDarray;
@property(nonatomic,assign)NSInteger huiyiID;

@end
static NSString* xunjiandianweiID = @"xunjiandianweiID";
@implementation BanhuiAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"班会设置";
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    [self addData];
    [self addView];
    [self setupPickerView];
    [self textViewDelegate];
    self.banhuiStarTimeFi.delegate=self;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField ==self.banhuiStarTimeFi) {
        
        TimeDHViewController*timeVC=[[TimeDHViewController alloc]init];
        timeVC.timeTitle=@"班会开始时间";
        timeVC.delegate =self;
        [self presentViewController:timeVC animated:YES completion:nil];
    }

}
-(void)passTime:(NSString *)timeString type:(NSString *)typeString{
//    if ([typeString isEqualToString:@"班会开始时间"]) {
        self.banhuiStarTimeFi.text=timeString;
//    }


}

#pragma mark - UITextViewDelegate
-(void)textViewDelegate{
    
self.banhuiContentFv.text=@"例如：1.准时到达指定地点";
    self.banhuiContentFv.delegate=self;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"例如：1.准时到达指定地点";
        
        textView.textColor = textColorPlace;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"例如：1.准时到达指定地点"]){
        textView.text=@"";
        
        textView.textColor=[UIColor blackColor];
    }
    
}
-(void)saveAction:(UIButton*)sender{

   
    [self banciselect];
}
//conditions
-(void)banciselect{
    if (self.banhuiID.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"请选择班次" doneString:@"确定"];
    } else {
        [self banhuiTime];
    }

}
-(void)banhuiTime{
    if ([self.banhuiStarTimeFi.text isEqualToString:@" "]||self.banhuiStarTimeFi.text.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"班会时间不能为空" doneString:@"确定"];
    } else {
        [self banhuiPlace];
    }

}
-(void)banhuiPlace{
    if ([self.banhuiAddressFi.text isEqualToString:@" "]||self.banhuiAddressFi.text.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"班会地点不能为空" doneString:@"确定"];
    } else {
        [self banhuiContent];
    }
    
    
}
-(void)banhuiContent{
    if ([self.banhuiContentFv.text isEqualToString:@"例如：1.准时到达指定地点"]) {
          [self AlerVCtitleString:@"提示" messageString:@"班会内容不能为空！" doneString:@"确定"];
    } else {
        
    
    if ([self.banhuiContentFv.text isEqualToString:@" "]||self.banhuiContentFv.text.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"班会内容不能为空！" doneString:@"确定"];
    } else {
        if (self.upPageType ==1) {
            [self updateData];
            
        } else {
            [self addBanhuiData];
        }
        

    }
    }

}


-(void)addBanhuiData{
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    NSMutableDictionary* parma=[NSMutableDictionary dictionary];
    [parma setObject:ID forKey:@"projectid"];
    [parma setObject:self.banhuiID forKey:@"serviceid"];//
    NSString*timestr=[NSString stringWithFormat:@"%@",self.banhuiStarTimeFi.text];
    [parma setObject:timestr forKey:@"meetingtime"];
    
    [parma setObject:self.banhuiAddressFi.text forKey:@"meetingplace"];
    
    [parma setObject:self.banhuiContentFv.text forKey:@"meetingcontent"];
    
//        [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"classmeetingAdd"] Token:self.tokenString parmpar:parma succeed:^(id data) {
//    
//        for (NSArray*ARRAY in [data  allValues]) {
//            NSLog(@"%@",ARRAY);
//        }
//        
//    } failure:^(NSError *error) {
//        
//    }];
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
    
    [manger POST:[self urlRequestChildreurl:@"classmeetingAdd"] parameters:parma constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
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
//编辑
-(void)updateData{
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    [dic setObject:@(self.model.banhuiID)  forKey:@"id"];
    [dic setObject:ID forKey:@"projectid"];
   //
    NSString*serviceId =[NSString stringWithFormat:@"%@",self.model.service[@"id"]];
     [dic setObject:serviceId forKey:@"serviceid"];
    NSString*timestr=[NSString stringWithFormat:@"%@",self.banhuiStarTimeFi.text];
    [dic setObject:timestr forKey:@"meetingtime"];
    
    [dic setObject:self.banhuiAddressFi.text forKey:@"meetingplace"];
    
    [dic setObject:self.banhuiContentFv.text forKey:@"meetingcontent"];

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
    
    [manger POST:[self urlRequestChildreurl:@"classmeetingUpdate"] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
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
        NSLog(@"班会修改%@",responseObject);
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
        if ([controller isKindOfClass:[BanhuiSettingViewController class]]) {
           BanhuiSettingViewController * yezhuShowVC =(BanhuiSettingViewController *)controller;
            [self.navigationController popToViewController:yezhuShowVC animated:YES];
        }
    }
    
   
    
    
}
-(void)addData{
    self.banhuiIDarray=[NSMutableArray array];
    self.dataArray=[NSMutableArray array];
    self.dataArray=(NSMutableArray*) @[@"11",@"22",@"33",@"55",@"66"];
    self.pickArray=[NSMutableArray array];
    //self.pickArray= @[@"日班",@"夜班",@"常日班",@""];
    self.dataArray =[NSMutableArray array];
    
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //账号密码
    [param setObject:ID forKey:@"projectid"];
    
    
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"serviceList"] Token:self.tokenString parmpar:param succeed:^(id data) {
        for (NSDictionary*dic in data[@"resultMessage"]) {
            [self.pickArray addObject:dic[@"servicesname"]];
            NSString*banhuiID=[NSString stringWithFormat:@"%@",dic[@"id"]];
            [self.banhuiIDarray addObject:banhuiID];
            
        }
        
    } failure:^(NSError *error) {
        
    }];

    
}
-(void)addView{
    self.view.backgroundColor=[UIColor whiteColor];
    self.XunjianTypeTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, STANDARD_HEIGHT) style:(UITableViewStylePlain)];
    [self.view addSubview:self.XunjianTypeTableView];
    self.XunjianTypeTableView.dataSource = self;
    self.XunjianTypeTableView.delegate = self;
    [self.XunjianTypeTableView registerClass:[PublieTableViewCell class] forCellReuseIdentifier:xunjiandianweiID];
    
    UILabel* titleLa=[[UILabel alloc]init];
    titleLa.frame = CGRectMake(10, CGRectGetMaxY(self.XunjianTypeTableView.frame)+10, 120, 30);
    titleLa.text = @"班会开始时间";
    titleLa.textColor = textCententColor;
    [self.view addSubview:titleLa];
    
    UIImageView*imagBg=[[UIImageView alloc]init];
    imagBg.frame = CGRectMake(SCREEN_WIDTH -PROPORTION_WIDTH(138), titleLa.y, PROPORTION_WIDTH(100), 30);    //textfilebackgroundimage.png // textfile
    imagBg.image =[UIImage imageNamed:@"textfilebackgroundimage.png"];
    
    [self.view addSubview:imagBg];
    imagBg.userInteractionEnabled = YES;
    
    self.banhuiStarTimeFi=[[UITextField alloc]init];
     self.banhuiStarTimeFi.frame = CGRectMake(0, 0, imagBg.width-20, imagBg.height);
    self.banhuiStarTimeFi.textAlignment = NSTextAlignmentCenter;
    self.banhuiStarTimeFi.placeholder =@"08:00";
     self.banhuiStarTimeFi.textColor = textCententColor;
    [imagBg addSubview: self.banhuiStarTimeFi];
    
    UILabel* renwuLa=[[UILabel alloc]init];
    renwuLa.frame = CGRectMake(10, CGRectGetMaxY(imagBg.frame)+10, SCREEN_WIDTH-20, 30);
    renwuLa.text = @"班会地点";
    renwuLa.textColor = textCententColor;
    [self.view addSubview:renwuLa];
    
    UIImageView*addressBg=[[UIImageView alloc]init];
   addressBg.frame = STANDARDWH(CGRectGetMaxY(renwuLa.frame)+10);    //textfilebackgroundimage.png // textfile
    addressBg.image =[UIImage imageNamed:@"textfilebackgroundimage.png"];
    
    [self.view addSubview:addressBg];
    addressBg.userInteractionEnabled = YES;
    
    self.banhuiAddressFi=[[UITextField alloc]init];
    self.banhuiAddressFi.frame = CGRectMake(STANDARD_X, 0, STANDARD_WIDTH, addressBg.height);
    self.banhuiAddressFi.placeholder =@"例如：1号会议室";
    self.banhuiAddressFi.textColor = textCententColor;
    //self.produceFile.backgroundColor=[UIColor blueColor];
    [addressBg addSubview: self.banhuiAddressFi];

    UILabel* contentLa=[[UILabel alloc]init];
    contentLa.frame = CGRectMake(10, CGRectGetMaxY(addressBg.frame)+10, SCREEN_WIDTH-20, 30);
   contentLa.text = @"班会内容";
   contentLa.textColor = textCententColor;
    [self.view addSubview:contentLa];
    
    
    //输入框
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame =CGRectMake(STANDARD_X, CGRectGetMaxY(contentLa.frame)+10, STANDARD_WIDTH, PROPORTION_HIGHT(250));
    textfBg.image=[UIImage imageNamed:@"home_textView_contentbg.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self.view addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    self.banhuiContentFv=[[UITextView alloc]init];
    self.banhuiContentFv.frame = textfBg.bounds;
    self.banhuiContentFv.backgroundColor=[UIColor clearColor];
   self.banhuiContentFv.font =[UIFont systemFontOfSize:17];
    [textfBg addSubview:self.banhuiContentFv];
    
    UILabel*warinLa=[[UILabel alloc]init];
    warinLa.frame = CGRectMake(self.banhuiContentFv.width-100, self.banhuiContentFv.height-20, 100, 20);
    warinLa.text =@"210字";
    warinLa.backgroundColor=[UIColor clearColor];
    warinLa.textColor =[UIColor grayColor];
    warinLa.textAlignment = NSTextAlignmentCenter;
    [self.banhuiContentFv addSubview:warinLa];
    self.banhuiContentFv.text=@"例如：1.准时到达指定地点";
    self.banhuiContentFv.textColor =textColorPlace;
    
    self.photoImageView=[[UIView alloc]init];
   self.photoImageView.frame = CGRectMake(0, CGRectGetMaxY(textfBg.frame)+10, SCREEN_WIDTH, PROPORTION_HIGHT(100));
  // self.photoImageView.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.photoImageView];
    
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
      self.pickerView = pickerView;
    [self.photoImageView  addSubview:pickerView];

    
    //refresh superview height
    [pickerView refreshImagePickerViewWithPhotoArray:nil];
}



#pragma mark ------tableviewdelegate ----------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublieTableViewCell*cell=[self.XunjianTypeTableView dequeueReusableCellWithIdentifier:xunjiandianweiID];
     cell.leftLa.text = @"班次选择";
    cell.leftLa.font =[UIFont systemFontOfSize:16];
    cell.textLabel.textColor =textCententColor;
        //cell.rightLa.text = @"去选择";
    
    
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
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(280));
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
    self.pickView.frame = CGRectMake(0, CGRectGetMaxY(titleBg.frame), bgView.width, PROPORTION_HIGHT(150));
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
    self.banhuiID =self.banhuiIDarray[row];
    NSIndexPath *indexPath = [self.XunjianTypeTableView indexPathForSelectedRow];
    PublieTableViewCell *cell = [self.XunjianTypeTableView cellForRowAtIndexPath: indexPath];
    cell.rightLa.text = self.pickArray[row];
    
    cell.rightLa.textColor= textCententColor;
   // NSLog(@"hhhhh%@",self.banhuiID);
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
