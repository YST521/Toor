//
//  NSDate+Calendar.h
//  SoHeroAttendanceAPP
//
//  Created by 冯佳玉 on 16/9/27.
//  Copyright © 2016年 冯佳玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateModel.h"

#define _WorkBeginTime_ @"0830"
#define _workEndTime_ @"1730"
#define _MidBeginTime_ @"1200"
#define _MidEndTime_ @"1300"

@interface NSDate (Calendar)
/** 获取当月的第一天 */
- (NSDate *)getFirstDayInMonth;
/** 获取当月的最后一天 */
- (NSDate *)getLastDayInMonth;
/** 获取当月共有多少天 */
- (NSInteger)getDayCountInMonth;
/** 获取当天是星期几 */
- (int)weekdayInCurrentWeek;
/** 阳历日期转换阴历日期 */
- (NSString *)dateSwitch;
/** 获取年、月、日、时、分、秒*/
-(int)getYear;
-(int)getMonth;
-(int)getDay;
-(int)getHour;
-(int)getMinute;
-(int)getSecond;
/** 获取阴历日期的月份 */
- (NSString *)getLunarMonth;
/** 获取阴历日期的日子 */
- (NSString *)getLunarDay;

/** 改变日期模型对象中的法定节假日状态 */
+ (void)changeDateModelState:(NSDate *)date inDateArray:(NSMutableArray *)mutArray;
@end
