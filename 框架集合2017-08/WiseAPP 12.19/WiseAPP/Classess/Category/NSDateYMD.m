//
//  NSDateYMD.m
//  WiseAPP
//
//  Created by app on 16/11/30.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "NSDateYMD.h"

@implementation NSDateYMD

//当前时间
+(NSString*)currentDate{

    return [self getdate];
}

//年
+(NSInteger)nowYear{

    NSString *dateStr= [self getdate];
    NSDateFormatter *nextformatter = [[NSDateFormatter alloc] init] ;
    [nextformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *datee=[nextformatter dateFromString:dateStr];
    [nextformatter setDateFormat:@"yyyy"];
    
    NSInteger year=[[nextformatter stringFromDate:datee] integerValue];
    [nextformatter setDateFormat:@"MM"];
  
    return year;
}

//月
+(NSInteger)nowMonth{
    
    NSString *dateStr= [self getdate];
    NSDateFormatter *nextformatter = [[NSDateFormatter alloc] init] ;
    [nextformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *datee=[nextformatter dateFromString:dateStr];
    [nextformatter setDateFormat:@"yyyy"];
    [nextformatter setDateFormat:@"MM"];


    NSInteger month=[[nextformatter stringFromDate:datee]integerValue];


    return month;
}

//日
+(NSInteger)nowDay{
    
    NSString *dateStr= [self getdate];
    NSDateFormatter *nextformatter = [[NSDateFormatter alloc] init] ;
    [nextformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *datee=[nextformatter dateFromString:dateStr];
    [nextformatter setDateFormat:@"yyyy"];

    NSInteger day=[[nextformatter stringFromDate:datee] integerValue];
    

    return day;
}





+(NSString*)getdate{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    //    2016-11-30 02:56:39============年-月-日  时：分：秒=====================
    //    2016-11-30
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}


+(NSString*)getShifenmiao{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY年MM月dd日 hh时mm分"];
    //    2016-11-30 02:56:39============年-月-日  时：分：秒=====================
    //    2016-11-30
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}
//- (void)getDate {
//    // 获取系统时间
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    // 设置显示格式
//    [formatter setDateFormat:@" yyyy - MM - dd "];
//    NSDate *now = [NSDate date];
//    // 日历
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
//    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    // 全局数组，使用tableview展示数据
//    NSMutableArray* weekArray = [NSMutableArray array];
//    //  第一行，全局14天
//    [weekArray addObject:@"全部(14天)"];
//    // for 循环获取各14天的数据
//    for (int i = 0; i <= 14; i ++) {
//        //DATE
//        NSDate *date = [now dateByAddingTimeInterval:i*3600*24];
//        NSString *dateStr = [formatter stringFromDate:date];
//        // 日期组件
//        NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
//        NSLog(@"comps==%@",comps);
//        NSInteger intweek = [comps weekday];
//        // 获取日期，拼接日期字符串
//        NSString *stringDate = [NSString stringWithFormat:@"%@ %@", dateStr, [self week:intweek]];
//        NSLog(@"dateStr===%@",dateStr);
//        [weekArray addObject:stringDate];
//    }
//    NSLog(@"MMMAAASSSS%@",weekArray);
//}
//2.获取星期几
// 判断星期
+ (NSString*)getweek:(NSString*)dateString {
    // 获取系统时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    // 设置显示格式
    [formatter setDateFormat:@" yyyy - MM - dd "];
    NSDate * getDate =[NSDateYMD dateWithString:dateString];
    
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;    //DATE
    NSDate *date = getDate;
    NSString *dateStr = [formatter stringFromDate:date];
    NSLog(@"%@",dateStr);
    // 日期组件
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSLog(@"comps==%@",comps);
    NSInteger week = [comps weekday];
    
    NSString*weekStr=nil;
    
    if(week==1) {
        weekStr=@"星期天";
        
    } else if(week==2) {
        weekStr=@"星期一";
        
    } else if(week==3) {
        weekStr=@"星期二";
        
    } else if(week==4) {
        weekStr=@"星期三";
        
    } else if(week==5) {
        weekStr=@"星期四";
        
    } else if(week==6) {
        weekStr=@"星期五";
        
    } else if(week==7) {
        weekStr=@"星期六";
        
    }
    return weekStr;
}


//1.获取当前时间
+(NSString *)getCurrentDate
{
    //获取当前时间
    NSDate *now = [NSDate date];
   NSLog(@"now date is: %@", now);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    NSString * currentDate = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld:%.2ld",(long)year,(long)month,day,hour,minute,second];
    
    return currentDate;
}


//2.NSDate转换成时间戳

//NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//
//NSString *timeSp = [NSString stringWithFormat:@"%d", (long)[datenow timeIntervalSince1970]];
//
//NSLog(@"timeSp:%@",timeSp); //时间戳的值时间戳转时间的方法


//NSString 转 NSDate
+(NSDate *)dateWithString:(NSString *)dataString
{
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * date = [format dateFromString:[self getCurrentDate]];
    
    return date;
}

//NSDate 转 NSString
+(NSString *)stringWithDate:(NSDate *)date{
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString*strDate = [dateFormatter stringFromDate:[NSDate date]];
    
    NSLog(@"%@",strDate);
    
   // [dateFormatter release];
    
    return strDate;
}
//根据日期算出周几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate
{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekOfYear;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}


//调用

//NSInteger i = [self howManyDaysInThisMonth:2];
//
//NSLog(@"%ld",(long)i);



// 获取今年指定月的天数

+ (NSInteger)howManyDaysInThisMonth :(NSInteger)imonth {
    
    int year = [[self years][0] intValue];
    
    if((imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        
        return 31 ;
    
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        
        return 30;
    
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
        
    {
        
        return 28;
        
    }
    
    if(year%400 == 0)
        
        return 29;
    
    if(year%100 == 0)
        
        return 28;
    
    return 29;
    
}



#pragma mark 获取当前的年月

+ (NSArray *) years {
    
    
    
    NSMutableArray *yearArr = [[NSMutableArray alloc]init];
    
    
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    
    
    NSInteger year = [dateComponent year];
    
    NSInteger month = [dateComponent month];
    
    [yearArr addObject:@(year)];
    
    [yearArr addObject:@(month)];
    
    return yearArr;
    
}
#pragma mark - 获取某年某月的天数
+ (NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
    {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}

@end
