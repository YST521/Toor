//
//  TestDateViewController.m
//  WiseAPP
//
//  Created by app on 16/11/30.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "TestDateViewController.h"
#import "NSDateYMD.h"

@interface TestDateViewController ()

@end

@implementation TestDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"DDDDDDYYYYFDSGFDJGDF%@---%ld--%ld-%ld---%@",[NSDateYMD currentDate],(long)[NSDateYMD nowYear],(long)[NSDateYMD nowMonth],(long)[NSDateYMD nowDay],[NSDateYMD getCurrentDate]);
//    NSString*str =[NSDateYMD dateWithString:@"2016-11-30"];
//    NSLog(@"bbbbb%@",str);
    NSLog(@"%@KKKKKK%@",[NSDateYMD getShifenmiao],[NSDateYMD getweek:@"2016-11-30"]);
    
    
    [self getDate];
}
- (void)getDate {
    // 获取系统时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    // 设置显示格式
    [formatter setDateFormat:@" yyyy - MM - dd "];
    NSDate *now = [NSDate date];
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 全局数组，使用tableview展示数据
    NSMutableArray* weekArray = [NSMutableArray array];
    //  第一行，全局14天
    [weekArray addObject:@"全部(14天)"];
    // for 循环获取各14天的数据
    for (int i = 0; i <= 14; i ++) {
        //DATE
        NSDate *date = [now dateByAddingTimeInterval:i*3600*24];
        NSString *dateStr = [formatter stringFromDate:date];
        // 日期组件
        NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
        NSLog(@"comps==%@",comps);
        NSInteger intweek = [comps weekday];
        // 获取日期，拼接日期字符串
        NSString *stringDate = [NSString stringWithFormat:@"%@ %@", dateStr, [self week:intweek]];
        NSLog(@"dateStr===%@",dateStr);
        [weekArray addObject:stringDate];
    }
    NSLog(@"MMMAAASSSS%@",weekArray);
}

//2.获取星期几
// 判断星期
- (NSString*)week:(NSInteger)week {
    
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
