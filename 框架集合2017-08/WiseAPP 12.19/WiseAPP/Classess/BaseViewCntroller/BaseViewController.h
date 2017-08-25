//
//  BaseViewController.h
//  WiseAPP
//
//  Created by app on 16/10/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//#import <CoreLocation/CoreLocation.h>

@interface BaseViewController : UIViewController
@property(nonatomic,strong)NSString* lat;
@property(nonatomic,strong)NSString*  lont;

@property(nonatomic,strong)NSString* tokenString; //登陆token
//判断手机号码格式是否正确  正则表达式
-(BOOL)valiMobile:(NSString *)mobile;
//常用时间
@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger days;
@property(nonatomic,assign)NSInteger hours;
@property(nonatomic,assign)NSInteger  minutes;

-(NSString*)curretDateMM;
-(NSString*)curretDateDD;
-(NSString*)curretDatehhSS;
//网址拼接
-(NSString*)urlRequestChildreurl:(NSString*)childreUrl;
-(NSString*)urlStringWithImageUrl:(NSString*)imageUrl;
//字符串拼接
- (NSString *)mainString:(NSString*)mainString subStringFrom:(NSString *)startString to:(NSString *)endString;
//字典或数组转json字符串
- (NSString *)dictionaryOrArrrayToJSONData:(id)theData;

//常用方法
-(void)AlerVCtitleString:(NSString*)title messageString:(NSString*)message doneString:(NSString*)doneString;
// 将字典或者数组转化为JSON串
- (NSData *)toJSONData:(id)theData;
//字典转json
- (NSString*)dictionaryToJson:(NSDictionary *)dic;
// 将JSON串转化为字典或者数组
-(id)toArrayOrNSDictionary:(NSData *)jsonData;

-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;


//大小写转换
//转小写
-(NSString*)ChangeLowercas:(NSString*)string;
//转大写
-(NSString *)toUpper:(NSString *)str;

@end
