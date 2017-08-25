//
//  KaoqinShuiyingController.m
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "KaoqinShuiyingController.h"

@interface KaoqinShuiyingController ()
@property(nonatomic,strong)UIImageView*imagev;
@end

@implementation KaoqinShuiyingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imagev=[[UIImageView alloc]init];
    self.imagev.frame=UIScreenBpunds;
    [self.view addSubview:self.imagev];
    self.imagev.image=self.image;
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
