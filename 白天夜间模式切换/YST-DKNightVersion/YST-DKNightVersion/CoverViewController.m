//
//  CoverViewController.m
//  YST-DKNightVersion
//
//  Created by youxin on 2017/7/5.
//  Copyright © 2017年 youxin. All rights reserved.
//

#import "CoverViewController.h"
#import "HeaderView.h"

@interface CoverViewController ()
@property(nonatomic,strong)HeaderView * hview;
@property(nonatomic,strong)UIButton*button;

@end

@implementation CoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title =@"假换肤 view遮罩";
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"left" style:(UIBarButtonItemStylePlain) target:self action:@selector(left)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"RIGHT" style:(UIBarButtonItemStylePlain) target:self action:@selector(right)];
    
    self.hview=[[HeaderView alloc]init];
    self.hview.frame = [UIScreen mainScreen].bounds;
    self.hview.backgroundColor =[UIColor colorWithWhite:0.1 alpha:0.5];
    [self.view addSubview:self.hview];
    self.hview.hidden = YES;
    
    self.button =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button.frame = CGRectMake(100, 100, 100, 40);
    self.button.backgroundColor =[UIColor redColor];
    [self.view addSubview:self.button];
    [self.button setTitle:@"切换颜色" forState:(UIControlStateNormal)];
    [self.button addTarget:self action:@selector(test) forControlEvents:(UIControlEventTouchUpInside) ];

    
}

-(void)test{
    self.view.backgroundColor =[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];

}

-(void)left{

    self.hview.hidden = NO;

}

-(void)right{
  self.hview.hidden = YES;


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
