//
//  BaogangDetailController.m
//  WiseAPP
//
//  Created by app on 16/12/6.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaogangDetailController.h"

@interface BaogangDetailController ()

@end

@implementation BaogangDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView*imagev=[[UIImageView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview:imagev];
    imagev.image =self.image;
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
