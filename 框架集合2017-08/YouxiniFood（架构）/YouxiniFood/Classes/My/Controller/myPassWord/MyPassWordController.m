//
//  MyPassWordController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyPassWordController.h"

@interface MyPassWordController ()
@property(nonatomic,strong)UITextField *oldPwField;
@property(nonatomic,strong)UITextField *newfield;
@property(nonatomic,strong)UITextField *againField;

@end

@implementation MyPassWordController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
}

- (void)creatUI{
    
    UIView*view =[[UIView alloc]init];
    view.frame = CGRectMake(0, 0, SceneWidth, 140);
    view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *oldPwLa =[[UILabel alloc]init];
    oldPwLa.frame = CGRectMake(20, 20, 60, 20);
    oldPwLa.text = @"原密码";
    oldPwLa.textColor =[UIColor colorWithHexStringg:@"#666666"];
    [view addSubview:oldPwLa];
    
    self.oldPwField =[[UITextField alloc]init];
    self.oldPwField.frame = CGRectMake(100, 20, SceneWidth/2, 20);
    self.oldPwField.placeholder = @"请输入旧密码";
    self.oldPwField.secureTextEntry = YES;
    self.oldPwField.font =[UIFont systemFontOfSize:14];
    [view addSubview:self.oldPwField];
    
    UIView *lineV =[[UIView alloc]init];
    lineV.frame = CGRectMake(20, CGRectGetMaxY(self.oldPwField.frame)+5, SceneWidth-40, 0.5);
    lineV.backgroundColor = LineColor;
    [view addSubview:lineV];
    
    //新密码
    UILabel *newPwLa =[[UILabel alloc]init];
    newPwLa.frame = CGRectMake(20, CGRectGetMaxY(lineV.frame)+15, 60, 20);
    newPwLa.text = @"新密码";
      newPwLa.textColor =[UIColor colorWithHexStringg:@"#666666"];
    [view addSubview:newPwLa];
    
    self.newfield =[[UITextField alloc]init];
    self.newfield.frame = CGRectMake(100, CGRectGetMaxY(lineV.frame)+15, SceneWidth/2, 20);
    self.newfield.placeholder = @"请输入新密码";
       self.newfield.secureTextEntry = YES;
    self.newfield.font =[UIFont systemFontOfSize:14];
    [view addSubview:self.newfield];
    
    UIView*newLine =[[UIView alloc]init];
    newLine.frame = CGRectMake(20,90, SceneWidth-40, 0.5);
    newLine.backgroundColor = LineColor;
    [view addSubview:newLine];
    

    //新密码 again
    UILabel *newAgainPwLa =[[UILabel alloc]init];
    newAgainPwLa.frame = CGRectMake(20, CGRectGetMaxY(newPwLa.frame)+25, 70, 20);
    newAgainPwLa.textColor =[UIColor colorWithHexStringg:@"#666666"];
    newAgainPwLa.text = @"确认密码";
    [view addSubview:newAgainPwLa];
    
    self.againField =[[UITextField alloc]init];
    self.againField.frame = CGRectMake(100, CGRectGetMaxY(newPwLa.frame)+25, SceneWidth/2, 20);
    self.againField.placeholder = @"请再次输入新密码";
    self.againField.secureTextEntry = YES;
    self.againField.font =[UIFont systemFontOfSize:14];
    [view addSubview:self.againField];
    
    UIView *lineII =[[UIView alloc]init];
    lineII.frame = CGRectMake(20, 135, SceneWidth-40, 0.5);
    lineII.backgroundColor = LineColor;
    [view addSubview:lineII];
    
    UIButton *saveBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    saveBtn.frame = CGRectMake(20, CGRectGetMaxY(view.frame)+30, SceneWidth-40, 40);
    saveBtn.backgroundColor=[UIColor whiteColor];
    [saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [saveBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
    saveBtn.layer.cornerRadius = 3;
    saveBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    saveBtn.layer.borderWidth = 0.3;
    [self.view addSubview:saveBtn];
    
    [saveBtn addTarget:self action:@selector(saveBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];

}

- (void)saveBtnClickAction:(UIButton*)sender{

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
