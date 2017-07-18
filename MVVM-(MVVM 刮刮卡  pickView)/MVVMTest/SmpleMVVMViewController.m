//
//  SmpleMVVMViewController.m
//  MVVMTest
//
//  Created by youxin on 2017/7/18.
//  Copyright © 2017年 李泽鲁. All rights reserved.
//

#import "SmpleMVVMViewController.h"
#import "Animal.h"
#import "ViewModel.h"
#import "SMpleView.h"


@interface SmpleMVVMViewController ()
@property(nonatomic,strong)Animal *animal;
@property(nonatomic,strong)SMpleView *sview;
@property(nonatomic,strong)ViewModel* viewmodel;

@end

@implementation SmpleMVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
//    https://objccn.io/issue-13-1/
    
    
    self.animal =[[Animal alloc]init];
    self.sview = [[SMpleView alloc]init];
    self.viewmodel =[[ViewModel alloc]init];
    
    [self.view addSubview:self.sview];
    [self.viewmodel animal:self.animal];
    [self.sview passModel:self.viewmodel];
    
    
    
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
