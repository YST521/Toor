//
//  MainViewController.m
//  MyMap
//
//  Created by swinglife on 13-11-17.
//  Copyright (c) 2013年 swinglife. All rights reserved.
//

#import "MainViewController.h"
#import "TimeDHViewController.h"
#import "MyPoint.h"
#import <CoreLocation/CoreLocation.h>
#import "GetcodeViewController.h"
#import "TimeYYMMDDViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()<passTimHMvalue>
/** 地理编码 */
@property (nonatomic, strong) CLGeocoder *geoC;
@property(nonatomic,strong)NSString* la;
@property(nonatomic,strong)NSString* lon;
@end

@implementation MainViewController
-(CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
        
    }
    return _geoC;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    //设置MapView的委托为自己
    [self.mapView setDelegate:self];
    
    //标注自身位置
    [self.mapView setShowsUserLocation:YES];
    
    [self.longitudeText setDelegate:self];
    [self.latitudeText setDelegate:self];
    
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"大头针" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
      self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"时间" style:(UIBarButtonItemStylePlain) target:self action:@selector(timeAction:)];
    //横屏设置
    //需在上面#import "AppDelegate.h"
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
    //不让横屏的时候 appDelegate.allowRotation = NO;即可

    
}
-(void)timeAction:(UIButton*)sender{
    
    [UIView animateWithDuration:0.01 animations:^{
        TimeDHViewController*timVC=[[TimeDHViewController alloc]init];
        timVC.delegate =self;
        timVC.title = @"时间设置";
        [self.navigationController pushViewController:timVC animated:NO];
        
//        
//        TimeYYMMDDViewController* ymmd=[[TimeYYMMDDViewController alloc]init];
//         [self.navigationController pushViewController:ymmd animated:NO];

    }];
    
}

-(void)passTime:(NSString *)timeString{
   
    NSLog(@"HHHH%@",timeString);
}

-(void)saveAction:(UIButton*)sender{
    
    GetcodeViewController* ggVC=[[GetcodeViewController alloc]init];
    ggVC.la =self.la;
    ggVC.lon =self.lon;
    [self.navigationController pushViewController:ggVC animated:YES];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    GetcodeViewController* ggVC=[[GetcodeViewController alloc]init];
    ggVC.la =self.la;
    ggVC.lon =self.lon;
    [self.navigationController pushViewController:ggVC animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//MapView委托方法，当定位自身时调用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    
    self.longitudeLabel.text = [NSString stringWithFormat:@"%f",loc.longitude];
  
    self.latitudeLabel.text = [NSString stringWithFormat:@"%f",loc.latitude];
      self.la =[NSString stringWithFormat:@"%f",loc.latitude];
    self.lon =[NSString stringWithFormat:@"%f",loc.longitude];
    
    //放大地图到自身的经纬度位置。
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [self.mapView setRegion:region animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//放置标注
- (IBAction)annotationAction:(id)sender {
    //创建CLLocation 设置经纬度
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:[[self.latitudeText text] floatValue] longitude:[[self.longitudeText text] floatValue]];
    CLLocationCoordinate2D coord = [loc coordinate];
    //创建标题
    NSString *titile = [NSString stringWithFormat:@"%f,%f",coord.latitude,coord.longitude];
    MyPoint *myPoint = [[MyPoint alloc] initWithCoordinate:coord andTitle:titile];
    //添加标注
    [self.mapView addAnnotation:myPoint];
    
    //放大到标注的位置
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [self.mapView setRegion:region animated:YES];
}

@end
