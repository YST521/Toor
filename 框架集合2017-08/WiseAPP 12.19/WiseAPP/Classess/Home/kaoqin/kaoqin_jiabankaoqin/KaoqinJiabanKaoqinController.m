//
//  KaoqinJiabanKaoqinController.m
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "KaoqinJiabanKaoqinController.h"
#import "JiaobanKaoqinView.h"
#import <MapKit/MapKit.h>
#import "JiabankaoqinCell.h"

@interface KaoqinJiabanKaoqinController ()<UICollectionViewDelegate,UICollectionViewDataSource,MKMapViewDelegate>
@property(nonatomic,strong)JiaobanKaoqinView* jiabankaoqinView;
@property(nonatomic,strong)UICollectionView*collectView;
@property(nonatomic,strong)CLGeocoder*geocoder;
@property(nonatomic,assign)double mapviewLa;
@property(nonatomic,assign)double mapViewLon;
@end

@implementation KaoqinJiabanKaoqinController
-(CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder =[[CLGeocoder alloc]init];
    }
    return _geocoder;
}

-(void)loadView{
    self.jiabankaoqinView=[[JiaobanKaoqinView alloc]init];
    self.view =self.jiabankaoqinView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addData];
    [self addView];
    
}
-(void)addData{

}

-(void)addView{
//地图
    self.jiabankaoqinView.mapView.delegate =self;
    self.jiabankaoqinView.mapView.mapType = MKMapTypeStandard;//有多个样式此处用标准类型
     self.jiabankaoqinView.mapView.userTrackingMode=MKUserTrackingModeFollow;//蓝色光圈
    //跟踪用户位置
    self.jiabankaoqinView.mapView.userTrackingMode = MKUserTrackingModeFollow;

//时间
    self.jiabankaoqinView.cuttreTimeLa.text=[self curreTime];
   //集合视图
    UICollectionViewFlowLayout*layout=[[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize=CGSizeMake((SCREEN_WIDTH-PROPORTION_WIDTH(60))/2, PROPORTION_HIGHT(60));
    self.collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.jiabankaoqinView.mapView.frame)+10, SCREEN_WIDTH-40, PROPORTION_HIGHT(60)) collectionViewLayout:layout];
    [self.view addSubview:self.collectView];
    self.collectView.backgroundColor =GlobBackGroundColor;
    self.collectView.dataSource=self;
    self.collectView.delegate=self;
    [self.collectView registerClass:[JiabankaoqinCell class] forCellWithReuseIdentifier:@"cell"];
    

}
#pragma mark ------collectView==
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 2;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JiabankaoqinCell*cell= [self.collectView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    
    if (indexPath.row==0) {
        cell.titleLabel.text=@"签到";
        cell.iconImageView.image =[UIImage imageNamed:@"kaoqin_qiandao.png"];
        cell.backgroundColor=[UIColor redColor];
        
    } else {
        cell.titleLabel.text=@"签退";
        cell.iconImageView.image =[UIImage imageNamed:@"kaoqin_qiantui.png"];
        cell.backgroundColor=[UIColor greenColor];
    }
    
    
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

-(NSString*)curreTime{

    NSString*curretime=nil;

        if (self.minutes<10) {
            curretime=[NSString stringWithFormat:@"%ld:0%ld",(NSInteger)self.hours,(long)self.minutes];
        } else {
            curretime=[NSString stringWithFormat:@"%ld:%ld",(NSInteger)self.hours,(long)self.minutes];
        }
    
    return curretime;

}
//定位相关
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
            self.jiabankaoqinView.addressLa.text =address;
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
