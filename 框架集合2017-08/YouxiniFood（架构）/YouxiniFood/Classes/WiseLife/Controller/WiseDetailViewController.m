//
//  WiseDetailViewController.m
//  YouxiniFood
//
//  Created by 何青 on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "WiseDetailViewController.h"

@interface WiseDetailViewController ()

@end

@implementation WiseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight)];
    imgView.image = [UIImage imageNamed:@"bg_zhifuchengong"];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    [self.view addSubview:imgView];
}


@end
