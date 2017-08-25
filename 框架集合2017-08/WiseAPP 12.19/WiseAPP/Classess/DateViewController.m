//
//  DateViewController.m
//  WiseAPP
//
//  Created by app on 16/11/30.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "DateViewController.h"
#import "NSDateYMD.h"
@interface DateViewController ()

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor cyanColor];
    NSLog(@"%@",[NSDateYMD getCurrentDate]);
    
UITextField*fi= [CreatUI createTextFieldFrame:CGRectMake(0, 100, SCREEN_WIDTH, 30) backgroundColor:[UIColor redColor] placeholder:@"11" clearsOnBeginEditing:YES];
    [self.view addSubview:fi];
  UILabel*la=  [CreatUI createLableFrame:CGRectMake(0, 200, SCREEN_WIDTH, 40) backgroundColor:[UIColor redColor] text:@"1233243" textColor:[UIColor greenColor] font:[UIFont systemFontOfSize:16] numberOfLines:0 adjustsFontSizeToFitWidth:YES];
    [self.view addSubview:la];
    
 NSLog(@"DDDDMMM%ld",  (long)[NSDateYMD howManyDaysInThisMonth:11]);
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
