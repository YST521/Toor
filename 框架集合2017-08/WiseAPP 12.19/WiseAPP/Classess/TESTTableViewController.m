//
//  TESTTableViewController.m
//  WiseAPP
//
//  Created by app on 16/11/30.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "TESTTableViewController.h"
#import "MainViewController.h"
#import "DateViewController.h"
#import "TestDateViewController.h"
#import "TimeDHViewController.h"
#import "TimeYYMMDDViewController.h"

@interface TESTTableViewController ()

@end

@implementation TESTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
//    2016-11-30 02:56:39============年-月-日  时：分：秒=====================
//    2016-11-30
    NSString *DateTime = [formatter stringFromDate:date];
    NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSString *dateStr= DateTime;
    NSDateFormatter *nextformatter = [[NSDateFormatter alloc] init] ;
    [nextformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *datee=[nextformatter dateFromString:dateStr];
    [nextformatter setDateFormat:@"yyyy"];
    NSInteger year=[[nextformatter stringFromDate:datee] integerValue];
    [nextformatter setDateFormat:@"MM"];
    NSInteger month=[[nextformatter stringFromDate:datee]integerValue];
    [nextformatter setDateFormat:@"dd"];
    NSInteger day=[[nextformatter stringFromDate:datee] integerValue];
    
    NSLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld",date,(long)year,(long)month,(long)day);
//    NSDate *datt =[self dateWithString:@"2016-11-30 07:14:27 +0000"];
//    NSLog(@"当前是否是周末--%@",[self calculateWeek:datt]);

  
}
//NSString 转 NSDate
-(NSDate *)dateWithString:(NSString *)dataString
{
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * date = [format dateFromString:dataString];
    
    return date;
}
-(void)addDATE{

               //简书 FlyElephant
               NSString *dateString = @"2016-03-31 23:59:00";
               NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
               [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
               
               NSDate *mydate=[formatter dateFromString:dateString];
               [formatter setDateFormat:@"yyyy"];
               NSInteger currentYear=[[formatter stringFromDate:mydate] integerValue];
               [formatter setDateFormat:@"MM"];
               NSInteger currentMonth=[[formatter stringFromDate:mydate]integerValue];
               [formatter setDateFormat:@"dd"];
               NSInteger currentDay=[[formatter stringFromDate:mydate] integerValue];
               
               NSLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld",mydate,(long)currentYear,currentMonth,currentDay);
               
               
               NSString *dateStr= @"2016-04-01 00:01:00";
               NSDateFormatter *nextformatter = [[NSDateFormatter alloc] init] ;
               [nextformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
               
               NSDate *date=[nextformatter dateFromString:dateStr];
               [nextformatter setDateFormat:@"yyyy"];
               NSInteger year=[[nextformatter stringFromDate:date] integerValue];
               [nextformatter setDateFormat:@"MM"];
               NSInteger month=[[nextformatter stringFromDate:date]integerValue];
               [nextformatter setDateFormat:@"dd"];
               NSInteger day=[[nextformatter stringFromDate:date] integerValue];
               
               NSLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld",date,(long)year,month,day);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSDate *now = [NSDate date];
    NSLog(@"now date is: %@", now);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    int year =(int) [dateComponent year];
    int month = (int) [dateComponent month];
    int day = (int) [dateComponent day];
    int hour = (int) [dateComponent hour];
    int minute = (int) [dateComponent minute];
    int second = (int) [dateComponent second];
    
//    NSInteger year = [dateComponent year];
//    NSInteger month =  [dateComponent month];
//    NSInteger day = [dateComponent day];
//    NSInteger hour =  [dateComponent hour];
//    NSInteger minute =  [dateComponent minute];
//    NSInteger second = [dateComponent second];
    
    
    NSLog(@"year is: %ld", (long)year);
    NSLog(@"month is: %ld", (long)month);
    NSLog(@"day is: %ld", (long)day);
    NSLog(@" hour is: %ld",  (long)hour);
    NSLog(@"minute  is: %ld", (long)minute );
    NSLog(@"second is: %ld", (long)second);
    //字符串的转化并且拼接
    NSString *yearstr=[NSString stringWithFormat:@"%ld-",(long)year];
    NSString *monthstr=[NSString stringWithFormat:@"%ld-",(long)month];
    NSString *daystr=[NSString stringWithFormat:@"%ld ",(long)day];
    NSString *hourstr=[NSString stringWithFormat:@"%ld:",(long)hour];
    NSString *minutestr=[NSString stringWithFormat:@"%ld:",(long)minute];
    NSString *secondstr=[NSString stringWithFormat:@"%ld",(long)second];
    //字符串开始拼接
    NSString *allstr=[yearstr stringByAppendingString:monthstr];
    NSString *allstr1=[allstr stringByAppendingString:daystr];
    NSString *allstr2=[allstr1 stringByAppendingString:hourstr];
    NSString *allstr3=[allstr2 stringByAppendingString:minutestr];
    NSString *DateTime=[allstr3 stringByAppendingString:secondstr];
    NSLog(@"最后年月日时分秒拼接的结果=====%@",DateTime);
}
- (NSString *)calculateWeek:(NSDate *)date{
    //计算week数
    NSCalendar * myCalendar = [NSCalendar currentCalendar];
    myCalendar.timeZone = [NSTimeZone systemTimeZone];
    NSInteger week = [[myCalendar components:NSCalendarUnitWeekday  fromDate:date] weekday];
    NSLog(@"week : %zd",week);
    switch (week) {
        case 1:
        {
            return @"周日";
        }
        case 2:
        {
            return @"周一";
        }
        case 3:
        {
            return @"周二";
        }
        case 4:
        {
            return @"周三";
        }
        case 5:
        {
            return @"周四";
        }
        case 6:
        {
            return @"周五";
        }
        case 7:
        {
            return @"周六";
        }
    }
    
    return @"";
}
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sunday", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row ==0) {
        cell.textLabel.text = @"图片编辑";
    }else if (indexPath.row ==1){
        
          cell.textLabel.text = @"时间";
        
        
    }else if (indexPath.row ==3){
        
        cell.textLabel.text = @"时间封装";
        
        
    }else if (indexPath.row ==4){
        
        cell.textLabel.text = @"年月日时分封装";
        
        
    }else {
         cell.textLabel.text = @"时间测试";
    }
    
   
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        MainViewController* main =[[MainViewController alloc]init];
        [self.navigationController pushViewController:main animated:YES];
    } else if(indexPath.row ==1) {
        DateViewController*date=[[DateViewController alloc]init];
        
        [self.navigationController pushViewController:date animated:YES];
    }else if(indexPath.row ==2) {
        TestDateViewController* test=[[TestDateViewController alloc]init];
        [self.navigationController pushViewController:test animated:YES];
    }else if(indexPath.row ==3) {
        TimeDHViewController* test=[[ TimeDHViewController alloc]init];
        test.view.backgroundColor=[UIColor redColor];
        [self.navigationController pushViewController:test animated:YES];
    }else if(indexPath.row ==4) {
        TimeYYMMDDViewController* test=[[TimeYYMMDDViewController alloc]init];
        //test.view.backgroundColor=[UIColor redColor];
        [self.navigationController pushViewController:test animated:YES];
    }

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
