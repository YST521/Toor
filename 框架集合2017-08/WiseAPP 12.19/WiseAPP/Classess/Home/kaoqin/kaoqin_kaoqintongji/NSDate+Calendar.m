//
//  NSDate+Calendar.m
//  SoHeroAttendanceAPP
//
//  Created by 冯佳玉 on 16/9/27.
//  Copyright © 2016年 冯佳玉. All rights reserved.
//

#import "NSDate+Calendar.h"
#import "AFNetworking.h"

#define APPKEY @"86652c111eefc37d12fd5dbd8d299765"
@implementation NSDate (Calendar)
/// 获取当前日期所在月份有多少天
- (NSInteger)getDayCountInMonth {
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}
/// 获取当前日期所在月份的第一天日期
- (NSDate *)getFirstDayInMonth {
    int currentDay = [self getDay];
    NSInteger timeInterval = (currentDay-1)*24*3600;
    NSDate *date = [NSDate dateWithTimeInterval:-timeInterval sinceDate:self];
    return date;
}
/// 获取当前日期所在月份的最后一天
- (NSDate *)getLastDayInMonth {
    int monthDays = (int)[self getDayCountInMonth];
    int currentDay = [self getDay];
   // MYLog(@"当月共多少天：%d",monthDays);
    NSInteger timeInterval = (monthDays-currentDay)*24*3600;
    NSDate *date = [NSDate dateWithTimeInterval:timeInterval sinceDate:self];
    return date;
}
/// 获取当前日期  是周几
- (int)weekdayInCurrentWeek {
     return (int)[[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfYear forDate:self];
}

- (NSDateComponents *)getDateComponents {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return dateComponent;
}
-(int)getYear{
    NSDateComponents *dateComponent = [self getDateComponents];
    return (int)dateComponent.year;
}
-(int)getMonth{
    NSDateComponents *dateComponent = [self getDateComponents];
    return (int)dateComponent.month;
}
-(int)getDay{
    NSDateComponents *dateComponent = [self getDateComponents];
    return (int)dateComponent.day;
}
-(int)getHour{
    NSDateComponents *dateComponent = [self getDateComponents];
    return (int)dateComponent.hour;
}
-(int)getMinute{
    NSDateComponents *dateComponent = [self getDateComponents];
    return (int)dateComponent.minute;
}
-(int)getSecond{
    NSDateComponents *dateComponent = [self getDateComponents];
    return (int)dateComponent.second;
}

#pragma mark - 阳历转阴历日期
- (NSString *)dateSwitch{
    int wCurYear = [self getYear];
    int wCurMonth = [self getMonth];
    int wCurDay = [self getDay];
    
    //农历日期名
    NSArray *cDayName =  [NSArray arrayWithObjects:@"*",@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十", @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    
    //农历月份名
    NSArray *cMonName =  [NSArray arrayWithObjects:@"*",@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"冬",@"腊",nil];

    //公历每月前面的天数
    
    const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    
    //农历数据
    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
        
        ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
        
        ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
        
        ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
        
        ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
        
        ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
        
        ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
        
        ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
        
        ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
        
        ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};

    static int nTheDate,nIsEnd,m,k,n,i,nBit;
 
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    
    if((!(wCurYear % 4)) && (wCurMonth > 2))
        
        nTheDate = nTheDate + 1;
  
    //计算农历天干、地支、月、日
    
    nIsEnd = 0;
    m = 0;
    while(nIsEnd != 1)
    {
        if(wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;

        n = k;
        while(n>=0)
        {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            for(i=1;i<n+1;i++)
                nBit = nBit/2;
 
            nBit = nBit % 2;
            if (nTheDate <= (29 + nBit))
            {
                nIsEnd = 1;
                break;
            }
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }

        if(nIsEnd)
            break;
        m = m + 1;
    }
    
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    if (k == 12)
    {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            
            wCurMonth = 1 - wCurMonth;
        
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }
    //生成农历月
    
    NSString *szNongliMonth;
    if (wCurMonth < 1){
        szNongliMonth = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
    }else{
        szNongliMonth = (NSString *)[cMonName objectAtIndex:wCurMonth];
    }
    //生成农历日
    
    NSString *szNongliDay = [cDayName objectAtIndex:wCurDay];
    //合并
    
    NSString *lunarDate = [NSString stringWithFormat:@"%@-%@",szNongliMonth,szNongliDay];
    return lunarDate;
}
- (NSString *)getLunarMonth {
    NSString *str = [self dateSwitch];
    NSArray *tempArr = [str componentsSeparatedByString:@"-"];
    return tempArr[0];
}
- (NSString *)getLunarDay {
    NSString *str = [self dateSwitch];
    NSArray *tempArr = [str componentsSeparatedByString:@"-"];
    return tempArr[1];
}

///** 法定节假日的判断 */
+ (void)changeDateModelState:(NSDate *)date inDateArray:(NSMutableArray *)mutArray {
   // AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"key"] = APPKEY;
    parameter[@"year-month"] = [NSString stringWithFormat:@"%d-%d",[date getYear],[date getMonth]];
    [RequestManger PostRequestUrl:@"http://japi.juhe.cn/calendar/month" Token:nil parmpar:parameter succeed:^(id data) {
        if ([data[@"error_code"] intValue] == 0) {
                        NSString *dataString = data[@"result"][@"data"][@"holiday"];
                        NSData *tmpData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
            
                        id object = [NSJSONSerialization JSONObjectWithData:tmpData options:NSJSONReadingMutableContainers error:nil];
                      
                        if ([object isKindOfClass:[NSArray class]]) {
                            for (NSDictionary *dataDict in object) {
                                for (NSDictionary *dict in dataDict[@"list"]) {
                                    for (int i=0; i<mutArray.count; i++) {
                                        DateModel *dateModel = mutArray[i];
                                        NSString *dayString = [NSString stringWithFormat:@"%d-%d-%d",dateModel.year,dateModel.month,dateModel.day];
                                        if ([dayString isEqualToString:dataDict[@"festival"]]) {
                                            dateModel.lunarDay = dataDict[@"name"];
                                        }
                                        if ([dayString isEqualToString:dict[@"date"]]) {
                                            dateModel.status = dict[@"status"];
                                            break;
                                        }
                                    }
                                }
                            }
                        }else{
                            for (NSDictionary *dict in object[@"list"]) {
                                for (int i=0; i<mutArray.count; i++) {
                                    DateModel *dateModel = mutArray[i];
                                    NSString *dayString = [NSString stringWithFormat:@"%d-%d-%d",dateModel.year,dateModel.month,dateModel.day];
                                    if ([dayString isEqualToString:object[@"festival"]]) {
                                        dateModel.lunarDay = object[@"name"];
                                    }
                                    if ([dayString isEqualToString:dict[@"date"]]) {
                                        dateModel.status = dict[@"status"];
                                        break;
                                    }
                                }
                            }
                        }
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadCollectionView" object:nil];
                    }

    } failure:^(NSError *error) {
        
    }];

}
@end
