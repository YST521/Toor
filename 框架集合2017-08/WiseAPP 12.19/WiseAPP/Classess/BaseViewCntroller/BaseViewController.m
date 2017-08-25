//
//  BaseViewController.m
//  WiseAPP
//
//  Created by app on 16/10/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaseViewController.h"
#import "Header.h"
#import <MapKit/MapKit.h>
#import "LocationHander.h"

@interface BaseViewController ()<MKMapViewDelegate>

@property(nonatomic,strong)MKMapView* mapview;
/** 地理编码管理器 */
@property (nonatomic, strong) CLGeocoder *geoC;

@end

@implementation BaseViewController
/** 地理编码管理器 */
- (CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}


-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.tokenString=  [[LoginMessageManger loginMessageSingleManger].loginMangerDic objectForKey:@"loginToken"];
    [self getCurretDate];
    [self addView];
    self.view.backgroundColor = YSTGlobBg;
}
#pragma mark ----------网络请求相关------
//url 拼接
-(NSString*)urlRequestChildreurl:(NSString*)childreUrl{
    NSString*request =[NSString stringWithFormat:@"http://118.178.88.132:8000/api/%@",childreUrl];
    return request;
}
//urlimage 拼接
-(NSString*)urlStringWithImageUrl:(NSString*)imageUrl{
    NSString*request =[NSString stringWithFormat:@"http://118.178.88.132:8000%@",imageUrl];
    return request;
}

// 将字典或者数组转化为JSON串
- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
   
    
}
//数组或字典转json字符串
- (NSString *)dictionaryOrArrrayToJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
   
        NSString *jsonStringgg = [[NSString alloc] initWithData:jsonData
                                                       encoding:NSUTF8StringEncoding];
        return jsonStringgg;
    }else{
        return nil;
    }
   
    
}
// 将JSON串转化为字典或者数组
-(id)toArrayOrNSDictionary:(NSData *)jsonData{
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:nil];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}

//字典转json
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

-(void)creatMap{
    self.mapview =[[MKMapView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.mapview];

    //设置MapView的委托为自己
    //[self.mapView setDelegate:self];
    self.mapview.delegate =self;
    
    //标注自身位置
    [self.mapview setShowsUserLocation:YES];



}
//MapView委托方法，当定位自身时调用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    
    //    self.longitudeLabel.text = [NSString stringWithFormat:@"%f",loc.longitude];
    //
    //    self.latitudeLabel.text = [NSString stringWithFormat:@"%f",loc.latitude];
    //    self.la =[NSString stringWithFormat:@"%f",loc.latitude];
    //    self.lon =[NSString stringWithFormat:@"%f",loc.longitude];
    self.lat =[NSString stringWithFormat:@"%f",loc.latitude];
    self.lont =[NSString stringWithFormat:@"%f",loc.longitude];
    [ [LocationHander handleCoo2D].handercoo2dArray  addObject:self.lat];
    [ [LocationHander handleCoo2D].handercoo2dArray  addObject:self.lont];
    [self getAdress];
  //NSLog(@"Base单例存贮经纬度%@",[LocationHander handleCoo2D].handercoo2dArray);
    //放大地图到自身的经纬度位置。
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [self.mapview setRegion:region animated:YES];
}
-(void)getAdress{
    
    //获取用户输入的经纬度
    double latitude = [self.lat doubleValue];
    double longitude = [self.lont doubleValue];
    //    double latitude= 31.267548;
    //    double longitude = 121.465180;
    
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

#pragma mark -----------获取当前时间相关------------
-(void)getCurretDate{

    NSDate *now = [NSDate date];
    NSLog(@"now date is: %@", now);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//        NSUInteger unitFlags = kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour |  kCFCalendarUnitMinute | kCFCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    
    NSInteger year = [dateComponent year];
    NSInteger month =  [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour =  [dateComponent hour];
    NSInteger minute =  [dateComponent minute];
   // NSInteger second = [dateComponent second];
    self.year =(long)year;
    self.month=(long)month;
    self.days =(long)day;
    self.hours=(long)hour;
    self.minutes =(long)minute;
    
    
//    
//    NSLog(@"year is: %ld", (long)year);
//    NSLog(@"month is: %ld", (long)month);
//    NSLog(@"day is: %ld", (long)day);
//    NSLog(@" hour is: %ld",  (long)hour);
//    NSLog(@"minute  is: %ld", (long)minute );
//    NSLog(@"second is: %ld", (long)second);
//    //字符串的转化并且拼接
//    NSString *yearstr=[NSString stringWithFormat:@"%ld-",(long)year];
//    NSString *monthstr=[NSString stringWithFormat:@"%ld-",(long)month];
//    NSString *daystr=[NSString stringWithFormat:@"%ld ",(long)day];
//    NSString *hourstr=[NSString stringWithFormat:@"%ld:",(long)hour];
//    NSString *minutestr=[NSString stringWithFormat:@"%ld:",(long)minute];
//    NSString *secondstr=[NSString stringWithFormat:@"%ld",(long)second];
//    //字符串开始拼接
//    NSString *allstr=[yearstr stringByAppendingString:monthstr];
//    NSString *allstr1=[allstr stringByAppendingString:daystr];
//    NSString *allstr2=[allstr1 stringByAppendingString:hourstr];
//    NSString *allstr3=[allstr2 stringByAppendingString:minutestr];
//    NSString *DateTime=[allstr3 stringByAppendingString:secondstr];
//    NSLog(@"最后年月日时分秒拼接的结果=====%@",DateTime);
}

-(NSString*)curretDateMM{

    
   
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
      [dateFormatter setDateFormat:@"YYYY年MM月 "];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    return dateString;
}
-(NSString*)curretDateDD{
    
    
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"YYYY年MM月dd日 "];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    return dateString;
}

-(NSString*)curretDatehhSS{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"YYYY年MM月dd日 hh时:mm分 "];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    return dateString;
}

// 截取字符串方法封装
- (NSString *)mainString:(NSString*)mainString subStringFrom:(NSString *)startString to:(NSString *)endString;{
    
    NSRange startRange = [mainString rangeOfString:startString];
    NSRange endRange = [mainString rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [mainString substringWithRange:range];
    
}
//大小写转换
//转小写

-(NSString *)toLower:(NSString *)str{
    for (NSInteger i=0; i<str.length; i++) {
        if ([str characterAtIndex:i]>='A'&[str characterAtIndex:i]<='Z') {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]+32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}
//转大写
-(NSString *)toUpper:(NSString *)str{
    for (NSInteger i=0; i<str.length; i++) {
        if ([str characterAtIndex:i]>='a'&[str characterAtIndex:i]<='z') {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]-32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}

-(void)addView{

//self.view.backgroundColor = [UIColor colorWithRed:244/255 green:244/255 blue:244/255 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:21],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}
//弹框
-(void)AlerVCtitleString:(NSString*)title messageString:(NSString*)message doneString:(NSString*)doneString{
    
    UIAlertController*alerVC= [UIAlertController alertControllerWithTitle:title message:message preferredStyle:( UIAlertControllerStyleAlert)];
    UIAlertAction*al= [UIAlertAction actionWithTitle:doneString style:(UIAlertActionStyleDefault) handler:nil];
    [alerVC addAction:al];
    [self presentViewController:alerVC animated:YES completion:nil];
    
}

//判断手机号码格式是否正确  正则表达式
-(BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
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
