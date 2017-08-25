//
//  BindFankaController.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/2.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "BindFankaController.h"
#import "SettingZhifuCodeController.h"

@interface BindFankaController ()
@property (nonatomic,strong)UILabel     *alertLa;
@property (nonatomic,strong)UIImageView *succesImageV;
@property (nonatomic,strong)UIButton    *goSettingBtn;

@end

@implementation BindFankaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"绑定饭卡"];
    [self creatUI];
}

- (void)creatUI{

    self.succesImageV =[[UIImageView alloc]init];
    self.succesImageV.frame = CGRectMake(0, 0, 200, 200);
    
    if (SceneHeight>600) {
         self.succesImageV.center = CGPointMake(SceneWidth/2, SceneHeight*0.3);
    } else {
         self.succesImageV.center = CGPointMake(SceneWidth/2, SceneHeight*0.4);
    }
   
    [self.view addSubview:self.succesImageV];
    
    self.alertLa = [[UILabel alloc]init];
    self.alertLa.frame = CGRectMake(self.succesImageV.originX , CGRectGetMaxY(self.succesImageV.frame)+30, self.succesImageV.width, 30);
    self.alertLa.textColor =[UIColor grayColor];
    self.alertLa.font =[UIFont systemFontOfSize:20];
    self.alertLa.text = @"您以成功绑定饭卡";
    self.alertLa.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.alertLa];
    
    self.goSettingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
  
        self.goSettingBtn.frame = CGRectMake(20, CGRectGetMaxY(self.alertLa.frame)+50, SceneWidth-40, 40);
    
    
    
   self.goSettingBtn.layer.cornerRadius = ButtonLayerCornerRadius;
   self.goSettingBtn.clipsToBounds = YES;
   self.goSettingBtn.layer.borderWidth = 0.3;
    self.goSettingBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
    [self.goSettingBtn setTitle:@"前往设置钱包支付密码" forState:(UIControlStateNormal)];
    [self.goSettingBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
    [self.goSettingBtn setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.goSettingBtn];
    [self.goSettingBtn addTarget:self action:@selector(goBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];

    
    //
    self.succesImageV.backgroundColor=[UIColor greenColor];

}

#pragma mark - goSettingBtnClickAction

- (void)goBtnClickAction:(UIButton*)sender{
    
    SettingZhifuCodeController *settVC =[[SettingZhifuCodeController alloc]init];
    
    [self.navigationController pushViewController:settVC animated:YES];
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
