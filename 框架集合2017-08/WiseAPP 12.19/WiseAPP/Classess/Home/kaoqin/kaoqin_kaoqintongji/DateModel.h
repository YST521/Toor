//
//  DateModel.h
//  SoHeroAttendanceAPP
//
//  Created by 冯佳玉 on 16/9/27.
//  Copyright © 2016年 冯佳玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModel : NSObject
@property (nonatomic,strong) NSDate *date;
// 年月日
@property (nonatomic,assign) int year;
@property (nonatomic,assign) int month;
@property (nonatomic,assign) int day;
@property (nonatomic,assign) int weedly;
// 农历月日
@property (nonatomic,strong) NSString *lunarMonth;
@property (nonatomic,strong) NSString *lunarDay;
// 上班、休假标示
@property (nonatomic,strong) NSString *status;
@end
