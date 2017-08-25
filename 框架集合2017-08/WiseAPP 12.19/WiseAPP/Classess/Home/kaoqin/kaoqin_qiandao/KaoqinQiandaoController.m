//
//  KaoqinQiandaoController.m
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "KaoqinQiandaoController.h"
#import "KaoqinShuiyingController.h"
#import "KaoqinqiandaoView.h"
#import <MapKit/MapKit.h>

@interface KaoqinQiandaoController ()<MKMapViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,strong)CLGeocoder*geocoder;
@property(nonatomic,strong)KaoqinqiandaoView*qiandaoView;
@property(nonatomic,assign)double mapviewLa;
@property(nonatomic,assign)double mapViewLon;
@property(strong,nonatomic)UIImagePickerController *imagePickerController;
@property(nonatomic,strong)UIImage* cameraImage;
@end

@implementation KaoqinQiandaoController
-(CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder =[[CLGeocoder alloc]init];
    }
    return _geocoder;
}

-(void)loadView{
    self.qiandaoView=[[KaoqinqiandaoView alloc]init];
    self.view =self.qiandaoView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addData];
    [self addView];
    }
-(void)addData{


}
-(void)addView{
    
    self.qiandaoView.mapView.delegate =self;
    self.qiandaoView.mapView.mapType = MKMapTypeStandard;//有多个样式此处用标准类型
    self.qiandaoView.mapView.userTrackingMode=MKUserTrackingModeFollow;//蓝色光圈
    //跟踪用户位置
    self.qiandaoView.mapView.userTrackingMode = MKUserTrackingModeFollow;

   //camare btn action
    [self.qiandaoView.cameraBtn addTarget:self action:@selector(cameraAction:) forControlEvents:(UIControlEventTouchUpInside)];
    NSString*curretime=nil;

        if (self.minutes<10) {
            curretime=[NSString stringWithFormat:@"%ld:0%ld",(NSInteger)self.hours,(long)self.minutes];
        } else {
            curretime=[NSString stringWithFormat:@"%ld:%ld",(NSInteger)self.hours,(long)self.minutes];
        }


    self.qiandaoView.addressLa.text =[[LocationHander handleCoo2D].handelcoo2dDic objectForKey:@"place"];
    self.qiandaoView.cuttreTimeLa.text=curretime;
   // self.qiandaoView.selectbanciLa.text=curretime;
   
}

-(void)cameraAction:(UIButton*)sender{

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
    self.cameraImage=image;
    [self dismissViewControllerAnimated:YES completion:NULL];
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
        [self.qiandaoView.mapView setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.006, 0.006))];
        // [self getAddressLatitude:self.mapviewLa longitude:self.mapViewLon];
        
        return aView;
    }
    return nil;
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
                        NSLog(@"经纬度转地址%@",address);
                        //地址
                       // self.qiandaoView.addressLa.text =address;
            //结束定位
//                        [self stopLocation];
//                        [_chooseCityBtn setTitle:city forState:UIControlStateNormal];
//                        [_activityIndicator stopAnimating];

                    }

    }];



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
