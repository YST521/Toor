//
//  KaoqinQiantuiController.m
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "KaoqinQiantuiController.h"
#import "QiantuiView.h"
#import "KaoqinShuiyingController.h"

@interface KaoqinQiantuiController ()<MKMapViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,strong)QiantuiView*qiantuiView;
@property(nonatomic,strong)MKMapView*mapView;
@property(nonatomic,assign)double mapviewLa;
@property(nonatomic,assign)double mapViewLon;
@property(nonatomic,strong)CLGeocoder*geocoder;
@property(nonatomic,strong)UIImagePickerController*imagePickerController;
@property(nonatomic,strong)UIImageView*cameraImage;

@end

@implementation KaoqinQiantuiController
-(void)loadView{
    self.qiantuiView=[[QiantuiView alloc]init];
    self.view =self.qiantuiView;
}
-(CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder =[[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addView];
}
-(void)addView{
    //self.qiantuiView.cuttreTimeLa.text = [self curretDatehhSS];
  // self.qiantuiView.selectbanciLa.text=[self curretDatehhSS];
    [self.qiantuiView.cameraBtn addTarget:self action:@selector(camreaAction:) forControlEvents:(UIControlEventTouchUpInside)];

    self.qiantuiView.cuttreTimeLa.text= [self curreTime];
    
    self.qiantuiView.mapView.delegate=self;
    self.qiantuiView.mapView.mapType = MKMapTypeStandard;//有多个样式此处用标准类型
       self.qiantuiView.mapView.userTrackingMode=MKUserTrackingModeFollow;//蓝色光圈
    //跟踪用户位置
self.qiantuiView.mapView.userTrackingMode = MKUserTrackingModeFollow;
}
-(NSString*)curreTime{
    NSLog(@"DDDDDDD%ld",(long)self.hours);

    NSString*curretime=nil;
    //if (0<(NSInteger)self.hours&& (NSInteger)self.hours< 12) {
        if (self.minutes<10) {
            curretime=[NSString stringWithFormat:@"%ld:0%ld",(NSInteger)self.hours,(long)self.minutes];
        } else {
            curretime=[NSString stringWithFormat:@"%ld:%ld",(NSInteger)self.hours,(long)self.minutes];
        }
        
//    } else {
//        if (self.minutes<10) {
//            curretime=[NSString stringWithFormat:@"%ld:0%ld",(NSInteger)self.hours,(long)self.minutes];
//        } else {
//            curretime=[NSString stringWithFormat:@"%ld:%ld",(NSInteger)self.hours,(long)self.minutes];
//        }
//        
//    }
    return curretime;

}
-(void)camreaAction:(UIButton*)sender{

  
  
}
//给经纬度大头针
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    CLLocationCoordinate2D coord = [annotation coordinate];
    self.mapviewLa =coord.latitude;
    self.mapViewLon =coord.longitude;
    NSLog(@"经度:%f,纬度:%f",coord.latitude,coord.longitude);
    // If the annotation is the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        MKAnnotationView* aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MKPointAnnotation"];
        aView.image = [UIImage imageNamed:@"home_dizhi"];
        aView.canShowCallout = YES;
        //显示当前地点
        [self.mapView setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.006, 0.006))];
        // [self getAddressLatitude:self.mapviewLa longitude:self.mapViewLon];
        
        return aView;
    }
    return nil;
}

//MKUserLocation是地图上大头针模型，有title和subtitle以及location信息。该方法调用频繁
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"%f,%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    //点击大头针，会出现以下信息
//    userLocation.title=@"中国";
//    userLocation.subtitle=@"四大文明古国之一";
     [self getAddressLatitude:self.mapviewLa longitude:self.mapViewLon];
    //让地图显示用户的位置（iOS8一打开地图会默认转到用户所在位置的地图），该方法不能设置地图精度
    //    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    //这个方法可以设置地图精度以及显示用户所在位置的地图
    MKCoordinateSpan span=MKCoordinateSpanMake(0.05, 0.05);
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
            self.qiantuiView.addressLa.text =address;
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
    KaoqinShuiyingController*shuiyingVC=[[KaoqinShuiyingController alloc]init];
    shuiyingVC.image =image;
    [self.navigationController pushViewController:shuiyingVC animated:YES];
    self.cameraImage.image=image;
    [self dismissViewControllerAnimated:YES completion:NULL];
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
