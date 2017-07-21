//
//  MyPageViewController.m
//  WiseAPP
//
//  Created by app on 16/10/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "MyPageViewController.h"

@interface MyPageViewController ()

@end

@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
  /*
    UILabel*titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 22, SCREEN_WIDTH, 42);
    titleLabel.text = @"我的";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
   */
     self.navigationItem.title = @"我的";
    

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
