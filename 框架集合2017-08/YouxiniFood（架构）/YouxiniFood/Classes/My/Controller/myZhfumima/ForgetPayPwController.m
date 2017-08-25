//
//  ForgetPayPwController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "ForgetPayPwController.h"
#import "FMessageCodeController.h"

@interface ForgetPayPwController (){
    
    UIView *bgView;
    UITextField *userNameField,*userPhoneNumFileld,* idCardNumField;
    UIButton *nextBtn;
}

@end

@implementation ForgetPayPwController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
}

//跳转到 短信验证页面
-(void)nextBtnClickAction:(UIButton*)sender{

    FMessageCodeController *messageVC =[[FMessageCodeController alloc]init];
    messageVC.title = @"填写验证码";
    
    [self.navigationController pushViewController:messageVC animated:YES];

}

- (void)creatUI{

    UIView *squreView =[[UIView alloc]init];
    squreView.frame = CGRectMake(20, 25, 18, 13);
    squreView.layer.cornerRadius = 3;
    squreView.clipsToBounds = YES;
    squreView.backgroundColor = SquareColorGray;
    [self.view addSubview:squreView];
    
    UILabel *upAlretLa =[[UILabel alloc]init];
    upAlretLa.frame = CGRectMake(CGRectGetMaxX(squreView.frame)+10, squreView.originY, SceneWidth/2+100, 13);
    upAlretLa.text = @"请填写个人信息，已验证身份";
    upAlretLa.font =[UIFont systemFontOfSize:14];
    upAlretLa.textColor = [UIColor colorWithHexStringg:@"#666666"];
    [self.view addSubview:upAlretLa];
    
    bgView = [[UIView alloc]init];
    bgView.backgroundColor =[UIColor whiteColor];
    bgView.frame = CGRectMake(0, 50, SceneWidth, 50*3);
//    bgView.layer.borderWidth = 0.3;
//    bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:bgView];
    
    //姓名
    UILabel*userNAmeLa =[[UILabel alloc]init];
    userNAmeLa.frame = CGRectMake(20, 15, 70, 20);
    userNAmeLa.text = @"姓名";
    userNAmeLa.textColor =[UIColor colorWithHexStringg:@"#999999"];
    userNAmeLa.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:userNAmeLa];
    
    userNameField  =[[UITextField alloc]init];
    userNameField.frame =CGRectMake(CGRectGetMaxX(userNAmeLa.frame)+20, userNAmeLa.originY, SceneWidth/2, 20);
    userNameField.placeholder = @"请输入姓名";
    userNameField.font =[UIFont systemFontOfSize:14];
    [bgView addSubview:userNameField];
    
    UIView *lineI = [[UIView alloc]init];
    lineI.frame = CGRectMake(20, CGRectGetMaxY(userNameField.frame)+15, SceneWidth-40, 0.5);
    lineI.backgroundColor = LineColor;
    [bgView addSubview:lineI];
    
    
    UILabel*phoneNumLa =[[UILabel alloc]init];
    phoneNumLa.frame = CGRectMake(20, CGRectGetMaxY(lineI.frame)+15, 70, 20);
    phoneNumLa.text = @"手机号码";
    phoneNumLa.textColor =[UIColor colorWithHexStringg:@"#999999"];
    phoneNumLa.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:phoneNumLa];
    
    userPhoneNumFileld  =[[UITextField alloc]init];
    userPhoneNumFileld.frame =CGRectMake(CGRectGetMaxX(phoneNumLa.frame)+20, phoneNumLa.originY, SceneWidth/2, 20);
   userPhoneNumFileld.placeholder = @"请输入手机号码";
    userPhoneNumFileld.font =[UIFont systemFontOfSize:14];
    
    [bgView addSubview:userPhoneNumFileld];
    
    UIView *lineP = [[UIView alloc]init];
    lineP.frame = CGRectMake(20, CGRectGetMaxY(userPhoneNumFileld.frame)+15, SceneWidth-40, 0.5);
    lineP.backgroundColor = LineColor;
    [bgView addSubview:lineP];

    
    UILabel*idCardNumLa =[[UILabel alloc]init];
    idCardNumLa.frame = CGRectMake(20, CGRectGetMaxY(lineP.frame)+15, 70, 20);
    idCardNumLa.text = @"身份证号";
    idCardNumLa.textColor =[UIColor colorWithHexStringg:@"#999999"];
    idCardNumLa.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:idCardNumLa];
    
    idCardNumField  =[[UITextField alloc]init];
    idCardNumField.frame =CGRectMake(CGRectGetMaxX(idCardNumLa.frame)+20, idCardNumLa.originY, SceneWidth/2, 20);
    idCardNumField.placeholder = @"请输入身份证号码";
    idCardNumField.font =[UIFont systemFontOfSize:14];
    [bgView addSubview:idCardNumField];
    
    UIView *lineC = [[UIView alloc]init];
    lineC.frame = CGRectMake(20, CGRectGetMaxY(idCardNumField.frame)+12, SceneWidth-40, 0.5);
    lineC.backgroundColor = LineColor;
    [bgView addSubview:lineC];
    
    UILabel *bottomAlretLa = [[UILabel alloc]init];
    bottomAlretLa.frame = CGRectMake(20, CGRectGetMaxY(bgView.frame)+10, SceneWidth-40, 20);
    bottomAlretLa.text = @"信息加密处理，仅用于找回支付密码";
    bottomAlretLa.font =[UIFont systemFontOfSize:14];
    bottomAlretLa.textColor = [UIColor colorWithHexStringg:@"#999999"];
    [self.view addSubview:bottomAlretLa];
    
    nextBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    nextBtn.frame = CGRectMake(20, CGRectGetMaxY(bottomAlretLa.frame)+20, SceneWidth-40, 45);
    [nextBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
    [nextBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    nextBtn.backgroundColor =[UIColor whiteColor];
    
//    [nextBtn xw_roundedCornerWithCornerRadii:CGSizeMake((SceneWidth-40)/2, 45/2)   cornerColor:BgColor corners:UIRectCornerAllCorners borderColor:[UIColor lightGrayColor] borderWidth:0.3];
    nextBtn.layer.cornerRadius = 8;
    nextBtn.clipsToBounds = YES;
    nextBtn.layer.borderWidth = 0.3;
    nextBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
    
    [self.view addSubview:nextBtn];
    
    [nextBtn addTarget:self action:@selector(nextBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
 
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
