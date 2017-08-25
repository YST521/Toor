//
//  GetcodeViewController.m
//  WiseAPP
//
//  Created by yst911521 on 2016/11/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "GetcodeViewController.h"
#import <MapKit/MapKit.h>
#import "LocationHander.h"



#import <CoreLocation/CoreLocation.h>

@interface GetcodeViewController ()<MKMapViewDelegate>
@property(nonatomic,strong)MKMapView* mapView;

/** 地理编码管理器 */
@property (nonatomic, strong) CLGeocoder *geoC;

//@property (weak, nonatomic) IBOutlet UITextView *addressTV;
//
//@property (weak, nonatomic) IBOutlet UITextField *latitudeTF;
//
//@property (weak, nonatomic) IBOutlet UITextField *longitudeTF;

@end

@implementation GetcodeViewController

#pragma mark - 懒加载
/** 地理编码管理器 */
- (CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.mapView =[[MKMapView alloc]init];
    self.mapView.frame =self.view.bounds;
    [self.view addSubview:self.mapView];
    self.mapView.delegate =self;
    
    [self getAdress];
    [self getCode];
    self.mapView.mapType = MKMapTypeStandard;//有多个样式此处用标准类型
    //设置追踪模式
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake([self.la doubleValue], [self.lon doubleValue]), MKCoordinateSpanMake(0.006, 0.006))];
    

    
        MKPointAnnotation *annotation0 = [[MKPointAnnotation alloc] init];
    [annotation0 setCoordinate:CLLocationCoordinate2DMake([self.la doubleValue], [self.lon doubleValue])];
    //NSString*string=[[LocationHander handleCoo2D].handelcoo2dDic objectForKey:@"city"];
      [annotation0 setTitle:[[LocationHander handleCoo2D].handelcoo2dDic objectForKey:@"city"]];        [annotation0 setSubtitle:[[LocationHander handleCoo2D].handelcoo2dDic objectForKey:@"place"]];
        [self.mapView addAnnotation:annotation0];
        //是否自动显示大头针内容
        [self.mapView selectAnnotation:annotation0 animated:YES];
    ////    //添加圆形覆盖物
        [self MKCircleSettingCllcoationDD:CLLocationCoordinate2DMake([self.la doubleValue], [self.lon doubleValue])];

    
}
-(void)MKCircleSettingCllcoationDD:(CLLocationCoordinate2D)CLLocation{
    MKCircle * cirle = [MKCircle circleWithCenterCoordinate:CLLocation radius:200];
    //添加覆盖物
    [_mapView addOverlay:cirle];
}
//覆盖物
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKCircleRenderer * render=[[MKCircleRenderer alloc]initWithCircle:overlay];
    render.lineWidth=1;    //填充颜色
    render.fillColor=[UIColor colorWithRed:250 green:0 blue:0 alpha:0.2];    //线条颜色
    render.strokeColor=[UIColor redColor];
    return render;
}
//给经纬度大头针
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If the annotation is the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        MKAnnotationView* aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MKPointAnnotation"];
        aView.image = [UIImage imageNamed:@"home_dizhi.png"];
        aView.canShowCallout = YES;

        return aView;
    }
    return nil;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//给经纬度大头针
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    // If the annotation is the user location, just return nil.
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//        return nil;
//    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
//        MKAnnotationView* aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MKPointAnnotation"];
//        aView.image = [UIImage imageNamed:@"iconfont-dizhi copy"];
//        aView.canShowCallout = YES;
//
//        return aView;
//    }
//    return nil;
//}
// 地理编码(地址关键字 ->经纬度 )
-(void)getCode{

    //NSString *address = self.addressTV.text;
    NSString *address = @"上海市静安区民和路民和路219号";
    // 容错处理
    if([address length] == 0)
    {
        return;
    }
    
    // 根据地址关键字, 进行地理编码
    [self.geoC geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        /**
         *  CLPlacemark : 地标对象
         *  location : 对应的位置对象
         *  name : 地址全称
         *  locality : 城市
         *  按相关性进行排序
         */
        CLPlacemark *pl = [placemarks firstObject];
        
        if(error == nil)
        {
            NSLog(@"ppPPP%f----%f", pl.location.coordinate.latitude, pl.location.coordinate.longitude);
            
            NSLog(@"%@", pl.name);
//            self.addressTV.text = pl.name;
//            self.latitudeTF.text = @(pl.location.coordinate.latitude).stringValue;
//            self.longitudeTF.text = @(pl.location.coordinate.longitude).stringValue;
            NSLog(@"%@%@",@(pl.location.coordinate.latitude).stringValue,@(pl.location.coordinate.longitude).stringValue);
        }
    }];


}
-(void)getAdress{

    //获取用户输入的经纬度
        double latitude = [self.la doubleValue];
        double longitude = [self.lon doubleValue];
//    double latitude= 31.267548;
//    double longitude = 121.465180;
    ///<31.26958850,+121.46056000>
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    // 反地理编码(经纬度---地址)
    [self.geoC reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error == nil)
        {
            CLPlacemark *pl = [placemarks firstObject];
            //            self.addressTV.text = pl.name;
            //            self.latitudeTF.text = @(pl.location.coordinate.latitude).stringValue;
            //            self.longitudeTF.text = @(pl.location.coordinate.longitude).stringValue;
            NSLog(@"测试地址***%@----",pl);
        }else
        {
            NSLog(@"错误");
        }
    }];
}

@end
