//
//  MVCViewController.m
//  MVVMTest
//
//  Created by youxin on 2017/7/17.
//  Copyright © 2017年 李泽鲁. All rights reserved.
//

#import "MVCViewController.h"
#import "NSDate+TTDate.h"
#import "PersonN.h"

@interface MVCViewController ()
@property(nonatomic,strong)UILabel*label;
@property(nonatomic,strong)UILabel*label2;

@end

@implementation MVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    NSDate *DATE =[NSDate date];
    [DATE getWeekIntValueWithDate];
    int day = [DATE getWeekIntValueWithDate];
    if (day == 2) {
        NSLog(@"今天是周一");
    }else{
     NSLog(@"今天非周一");
    }
    
    NSLog(@"***********%d",  [DATE getWeekIntValueWithDate]);
    
    // m  v  c
    
    self.label =[[UILabel alloc]init];
    self.label.frame = CGRectMake(100, 100, 414/2, 40);
    self.label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.label];
    
    self.label2 =[[UILabel alloc]init];
    self.label2.frame = CGRectMake(200, 200, 414/2, 40);
    self.label2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.label2];
    
    PersonN*p = [[PersonN alloc]init];
    
    self.label.text =p.name;
    self.label2.text = p.age;
    
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
