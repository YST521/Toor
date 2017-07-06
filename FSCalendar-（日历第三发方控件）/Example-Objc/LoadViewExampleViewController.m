//
//  LoadViewExampleViewController.m
//  FSCalendar
//
//  Created by DingWenchao on 6/25/15.
//  Copyright (c) 2016 Wenchao Ding. All rights reserved.
//

#import "LoadViewExampleViewController.h"
#import "FSCalendar.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoadViewExampleViewController()<FSCalendarDataSource,FSCalendarDelegate>

@property (weak, nonatomic) FSCalendar *calendar;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDictionary<NSString *, UIImage *> *images;

@end

NS_ASSUME_NONNULL_END

@implementation LoadViewExampleViewController

#pragma mark - Life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"FSCalendar";
        self.images = @{@"2016/11/01":[UIImage imageNamed:@"icon_cat"],
                        @"2016/11/05":[UIImage imageNamed:@"icon_footprint"],
                        @"2016/11/20":[UIImage imageNamed:@"icon_cat"],
                        @"2016/11/07":[UIImage imageNamed:@"icon_footprint"]};
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    
    // 450 for iPad and 300 for iPhone
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), view.frame.size.width, height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    calendar.backgroundColor = [UIColor whiteColor];
   
    
    [view addSubview:calendar];
    self.calendar = calendar;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy/MM/dd";
    
    
    // [self.calendar selectDate:[self.dateFormatter dateFromString:@"2016/02/03"]];

    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.calendar setScope:FSCalendarScopeWeek animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.calendar setScope:FSCalendarScopeMonth animated:YES];
        });
    });
     */
    
    
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - <FSCalendarDelegate>


- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"should select date %@",[self.dateFormatter stringFromDate:date]);
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change to page %@",[self.dateFormatter stringFromDate:calendar.currentPage]);
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
}

#pragma mark - <FSCalendarDataSource>


- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter dateFromString:@"2016/10/01"];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter dateFromString:@"2017/10/10"];
}
//-(NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date{
//
//return @"666";
//}

- (nullable NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date;{
    NSLog(@"-----%@--%@ ------------%@",date,[self getCurrentTime],[self getCurrentDay]);
    
//    
//    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
//    
////    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
//    [dateFormat setDateFormat:@"yyyy-MM-dd "];//设定时间格式,这里可以设置成自己需要的格式
//    
//
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
      [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
   NSString *currentDateStr = [dateFormat stringFromDate:[self getCurrentTime]];
   NSString *currentDateStr2 = [dateFormat stringFromDate:date];
    
    
    NSString *dateStr =[currentDateStr substringToIndex:10];
    
    NSString *dateStr2 =[currentDateStr2 substringToIndex:10];


    NSLog(@"***********%@-----%@",dateStr2,dateStr);
    
    
    if ([dateStr isEqualToString:dateStr2]) {
        return @"OK";
    } else {
          return @"666";
    }

  
}

-(void)stringToDate{
//http://www.cnblogs.com/missna/archive/2011/04/15/2017285.html
//    1、字符串转换为日期
    
    　　NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate *date =[dateFormat dateFromString:@"1980-01-01 00:00:01"];
    
//    2、日期转换为字符串
    
    　　NSDateFormatter* dateFormat1 = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    
    　　NSString *currentDateStr = [dateFormat1 stringFromDate:[NSDate date]];


}



- (UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    return self.images[dateString];
}

- (NSDate *)getCurrentTime{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    
//    NSLog(@"---------- currentDate == %@",date);
    return date;
}
- (NSDate *)getCurrentDay{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    
//    NSLog(@"---------- currentDate == %@",date);
    return date;
}

- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
     [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

-(void)dateuuuuu{

//    1.date转string
    
    NSDate *date=[NSDate date];
    
    NSLog(@"%@",date);//2015-11-20 00:37:40 +0000
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    
    dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss";//指定转date得日期格式化形式
    
    NSLog(@"%@",[dateFormatter stringFromDate:date]);//2015-11-20 08:24:04
    
    dateFormatter.dateFormat=@"yyyy-MM-dd";
    
    NSLog(@"%@",[dateFormatter stringFromDate:date]);//2015-11-20
    
    dateFormatter.dateFormat=@"yyyy-MM-dd eeee aa HH:mm:ss";
    
    NSLog(@"%@",[dateFormatter stringFromDate:date]);//2015-11-20 Friday AM 08:30:28
    
    dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss z";
    
    NSLog(@"%@",[dateFormatter stringFromDate:date]);//2015-11-20 08:42:22 GMT+8
    
//    其实date转string只需要根据格式来就可以了,但是string转date需要注意事项
    
//    2.string转date
    
    NSString *dateStr=@"2012-5-4 4:34:23";
    
    dateFormatter.dateFormat=@"yyyy-mm-dd hh:mm:ss";
    
    //输出:2012-05-03 20:34:23 +0000
    
    /*
     
     转化的类型必须与dateFormat保持一致
     
     2012-->y
     
     5->m
     
     4->d
     
     */
    
    
//    
//    NSString *dateStr=@"2012-5-4 4:34:23";
//    
//    dateFormatter.dateFormat=@"yyyy-mm-dd "//后面的hh:mm:ss不写可以吗?答案不写不可以
    
    //dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss";//转化格式
    
    NSLog(@"%@",[dateFormatter dateFromString:dateStr]);
}

@end
