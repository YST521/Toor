//
//  NSDateYMD.h
//  WiseAPP
//
//  Created by app on 16/11/30.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateYMD : NSObject
//当前时间
+(NSString*)currentDate;
//年
+(NSInteger)nowYear;
//月
+(NSInteger)nowMonth;
//日
+(NSInteger)nowDay;
//2016年11月30日 03时57
+(NSString*)getShifenmiao;

//判断周末
+ (NSString*)getweek:(NSString*)dateString ;

//1.获取当前时间
+(NSString *)getCurrentDate;
//NSString 转 NSDate
+(NSDate *)dateWithString:(NSString *)dataString;
//NSDate 转 NSString
+(NSString *)stringWithDate:(NSDate *)date;
//根据日期算出周几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
// 获取今年指定月的天数

+ (NSInteger)howManyDaysInThisMonth :(NSInteger)imonth;
//获取某年某月天数0000
+ (NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month;
@end
