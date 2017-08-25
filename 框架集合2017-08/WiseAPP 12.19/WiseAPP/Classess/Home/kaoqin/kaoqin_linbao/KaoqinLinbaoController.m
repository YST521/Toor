//
//  KaoqinLinbaoController.m
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "KaoqinLinbaoController.h"
#import "LinbaoView.h"
#import "LinbaoCollectionViewCell.h"
@interface KaoqinLinbaoController ()<MKMapViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)LinbaoView*linbaoView;
@property(nonatomic,strong)UICollectionView*  collectView;
@property(nonatomic,strong)CLGeocoder*geocoder;
@property(nonatomic,assign)double mapviewLa;
@property(nonatomic,assign)double mapViewLon;
@property(strong,nonatomic)UIImagePickerController *imagePickerController;
@property(nonatomic,strong)UIImage* cameraImage;
@property(nonatomic,assign)BOOL flag;
@end

@implementation KaoqinLinbaoController
-(CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder =[[CLGeocoder alloc]init];
    }
    return _geocoder;
}


-(void)loadView{
    self.linbaoView=[[LinbaoView alloc]init];

    self.view =self.linbaoView;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    [self addData];
    [self addView];
    
}
-(void)addData{


}

-(void)addView{
    self.linbaoView.mapView.delegate =self;
    self.linbaoView.mapView.mapType = MKMapTypeStandard;//有多个样式此处用标准类型
    self.linbaoView.mapView.userTrackingMode=MKUserTrackingModeFollow;//蓝色光圈
    //跟踪用户位置
   self.linbaoView.mapView.userTrackingMode = MKUserTrackingModeFollow;
    self.linbaoView.cuttreTimeLa.text=[self curreTime];
    UICollectionViewFlowLayout*layout=[[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize =CGSizeMake((SCREEN_WIDTH-30)/2, PROPORTION_HIGHT(60));
    self.collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.linbaoView.mapView.frame)+10, SCREEN_WIDTH-20, PROPORTION_HIGHT(60)) collectionViewLayout:layout];
    self.collectView.backgroundColor=GlobBackGroundColor;
    [self.view addSubview:self.collectView];
    self.collectView.dataSource=self;
    self.collectView.delegate =self;
    [self.collectView registerClass:[LinbaoCollectionViewCell class] forCellWithReuseIdentifier:@"collectItem"];
    self.collectView.contentSize=CGSizeMake(0, 0);
    //animation
    
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.linbaoView.rightImage addGestureRecognizer:tap];
//    UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
//                                                                                            action:@selector(doHandlePanAction:)];
//    [self.linbaoView.hadongView addGestureRecognizer:panGestureRecognizer];

}
//拖拽
//- (void) doHandlePanAction:(UIPanGestureRecognizer *)paramSender{
//    
//    CGPoint point = [paramSender translationInView:self.view];
//    NSLog(@"X:%f;Y:%f",point.x,point.y);
//    
//    paramSender.view.center = CGPointMake(paramSender.view.center.x + point.x, paramSender.view.center.y + point.y);
//    [paramSender setTranslation:CGPointMake(0, 0) inView:self.view];
//    
//    
//}
-(void)tapAction:(UITapGestureRecognizer*)sender{
    if (self.flag) {
        self.linbaoView.hadongView.frame =CGRectMake(0, 0, PROPORTION_WIDTH(280), PROPORTION_HIGHT(80));
         self.linbaoView.rightImage.frame =CGRectMake(self.linbaoView.hadongView.width-PROPORTION_WIDTH(30)+5, PROPORTION_HIGHT(25), PROPORTION_WIDTH(30), PROPORTION_HIGHT(30));
        self.linbaoView.contentView.hidden =NO;

       // [UIView animateWithDuration:0.001 animations:^{
             //self.linbaoView.rightImage.transform=CGAffineTransformMakeRotation(M_PI);
            [self.linbaoView.rightImage setImage:[UIImage imageNamed:@"kaoqin_linbaoleft.png"]];
       // }];
           self.flag=NO;
        
    } else {
   
        self.linbaoView.hadongView.frame =CGRectMake(0, 0, PROPORTION_WIDTH(80), PROPORTION_HIGHT(80));
        self.linbaoView.rightImage.frame =CGRectMake(self.linbaoView.hadongView.width-PROPORTION_WIDTH(30), PROPORTION_HIGHT(25), PROPORTION_WIDTH(30), PROPORTION_HIGHT(30));
        self.linbaoView.contentView.hidden =YES;
        
        [UIView animateWithDuration:1 animations:^{
            [self.linbaoView.rightImage setImage:[UIImage imageNamed:@"kaoqin_linbaoright.png"]];
               self.flag=YES;
        }];

    }
    

    
}




#pragma mark-----------collectdelegate------
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   LinbaoCollectionViewCell*cell=[self.collectView dequeueReusableCellWithReuseIdentifier:@"collectItem" forIndexPath:indexPath];
    if (indexPath.row==0) {
        cell.titleLabel.text=@"签到";
        cell.iconImageView.image =[UIImage imageNamed:@"kaoqin_qiandao.png"];
        
        
    } else {
        cell.titleLabel.text=@"签退";
        cell.iconImageView.image =[UIImage imageNamed:@"kaoqin_qiantui.png"];
    
    }
    cell.backgroundColor=[UIColor whiteColor];
    

    return cell;
}
//页面跳转
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        NSLog(@"签到");
    } else {
        NSLog(@"签退");
    }

}

//MKUserLocation是地图上大头针模型，有title和subtitle以及location信息。该方法调用频繁
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"%f,%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    self.mapviewLa =userLocation.location.coordinate.latitude;
    self.mapViewLon=userLocation.location.coordinate.longitude;
    //点击大头针，会出现以下信息
    //    userLocation.title=@"中国";
    //    userLocation.subtitle=@"四大文明古国之一";
    [self getAddressLatitude:self.mapviewLa longitude:self.mapViewLon];
    //让地图显示用户的位置（iOS8一打开地图会默认转到用户所在位置的地图），该方法不能设置地图精度
    //    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    //这个方法可以设置地图精度以及显示用户所在位置的地图
    MKCoordinateSpan span=MKCoordinateSpanMake(0.006, 0.006);
    MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [mapView setRegion:region animated:YES];
}



//根据坐标获取地名
-(void)getAddressLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitiude{
    //反地理编码
    CLLocation* location =[[CLLocation alloc]initWithLatitude:latitude longitude:longitiude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //  CLPlacemark*placeMark =[placemarks firstObject];
        
        for (CLPlacemark *placeMark in placemarks)
        {
            NSDictionary *addressDic=placeMark.addressDictionary;
            
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            NSLog(@"WWWQQQQQQ%@-%@--%@-%@",state,city,subLocality,street);
            NSString*address=[NSString stringWithFormat:@"%@.%@.%@",city,subLocality,street];
            //地址
            self.linbaoView.addressLa.text =address;
            //结束定位
            //                        [self stopLocation];
            //                        [_chooseCityBtn setTitle:city forState:UIControlStateNormal];
            //                        [_activityIndicator stopAnimating];
            
        }
        
    }];
    
    
    
}

#pragma mark-----camare======
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
        NSLog(@"当前设备不支持拍照");
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                  message:@"当前设备不支持拍照"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              
                                                          }]];
        
        
        
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
    
}//拍照照片选取

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
//    KaoqinShuiyingController*shuiyingVC=[[KaoqinShuiyingController alloc]init];
//    shuiyingVC.image =image;
//    [self.navigationController pushViewController:shuiyingVC animated:YES];
//    self.cameraImage=image;
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//时间
-(NSString*)curreTime{
    
    NSString*curretime=nil;
    
    if (self.minutes<10) {
        curretime=[NSString stringWithFormat:@"%ld:0%ld",(NSInteger)self.hours,(long)self.minutes];
    } else {
        curretime=[NSString stringWithFormat:@"%ld:%ld",(NSInteger)self.hours,(long)self.minutes];
    }
    
    return curretime;
    
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
