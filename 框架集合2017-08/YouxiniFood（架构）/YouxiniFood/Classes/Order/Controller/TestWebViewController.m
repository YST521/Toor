//
//  TestWebViewController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/29.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "TestWebViewController.h"

@interface TestWebViewController ()

@end

@implementation TestWebViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView =[[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://pro.modao.cc/app/c16f9f1ff364d32fa34a34dd4033d6d2d9e3eabe#screen=sf726bb0c9aba30a3d0fbd4"]]];
//    https://pro.modao.cc/app/c16f9f1ff364d32fa34a34dd4033d6d2d9e3eabe#screen=sf726bb0c9aba30a3d0fbd4
    UIButton*Btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    Btn.backgroundColor=[UIColor redColor];
    Btn.frame= CGRectMake(50, 50, 40, 20);
    [Btn setTitle:@"返回" forState:(UIControlStateNormal)];
    [self.view addSubview:Btn];
    [Btn addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)pop{
    
    [self.navigationController popViewControllerAnimated:YES];

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
