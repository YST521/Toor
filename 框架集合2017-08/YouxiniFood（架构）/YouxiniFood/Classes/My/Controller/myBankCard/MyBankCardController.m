//
//  MyBankCardController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/29.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyBankCardController.h"

@interface MyBankCardController ()

@property(nonatomic,strong)UIImageView *bankcardImagewV;

@end

@implementation MyBankCardController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNa];
    [self creatUI];
    
}


- (void)creatNa{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"解绑" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightItemClickAction:)];
    

}
-(void)creatUI{

    UIView *bgView =[[UIView alloc]init];
    bgView.frame = CGRectMake(10, 20, SceneWidth-20, 150);
    bgView.layer.cornerRadius = 10;
    bgView.backgroundColor =[UIColor greenColor];
    bgView.clipsToBounds = YES;
    [self.view addSubview:bgView];
    
    self.bankcardImagewV =[[UIImageView alloc]init];
    self.bankcardImagewV.frame =CGRectMake(0, 0, bgView.width,bgView.height);
    self.bankcardImagewV.layer.cornerRadius = 10;
    self.bankcardImagewV.clipsToBounds = YES;
    self.bankcardImagewV.backgroundColor =[UIColor blueColor];
    [bgView addSubview:self.bankcardImagewV];
    
    UILabel *aleartLa =[[UILabel alloc]init];
    aleartLa.frame =CGRectMake(10, CGRectGetMaxY(bgView.frame)+10, SceneWidth-50, 20);
    aleartLa.textColor = [UIColor colorWithHexStringg:@"#999999"];
    aleartLa.font =[UIFont systemFontOfSize:14];
    [self.view addSubview:aleartLa];
    
    aleartLa.text =@"目前只支持绑定一张银行卡";
}

#pragma mark ---------------------clickAction---------------

-(void)rightItemClickAction:(UIBarButtonItem*)sender{


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
