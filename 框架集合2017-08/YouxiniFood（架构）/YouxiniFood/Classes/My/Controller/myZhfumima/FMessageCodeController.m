//
//  FMessageCodeController.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "FMessageCodeController.h"
#import "ChangNewCodeController.h"

@interface FMessageCodeController (){
    UIButton *nextBtn;

}

@property(nonatomic,strong)UITextField *messageCodeFi;
@property(nonatomic,strong)UILabel *alertLa;

@end

@implementation FMessageCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    
}

- (void)creatUI{
  
   self.alertLa = [[UILabel alloc]init];
     self.alertLa.frame = CGRectMake(20, 20, SceneWidth-40, 40);
    self.alertLa.textColor =[UIColor colorWithHexStringg:@"#999999"];
    self.alertLa.numberOfLines = 2;
    self.alertLa.font =[UIFont systemFontOfSize:14];
    [self.view addSubview:self.alertLa];
    
    self.messageCodeFi = [[UITextField alloc]init];
    self.messageCodeFi.frame = CGRectMake(20, CGRectGetMaxY(self.alertLa.frame)+20, SceneWidth/3, 40);
    self.messageCodeFi.backgroundColor =[UIColor whiteColor];
    self.messageCodeFi.layer.cornerRadius = 8;
    self.messageCodeFi.clipsToBounds = YES;
    [self.view addSubview:self.messageCodeFi];
    
    //getMessageBtn
    
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(CGRectGetMaxX(self.messageCodeFi.frame)+10, CGRectGetMaxY(self.alertLa.frame)+30, SceneWidth/3, 30);
    button.titleLabel.font =[UIFont systemFontOfSize:14];
//    button.layer.cornerRadius = 4;
//    button.clipsToBounds = YES;
//    button.layer.borderWidth = 0.3;
//    button.layer.borderColor =[UIColor lightGrayColor].CGColor;
    [self.view addSubview:button];
//    [button setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    [button setTitleColor:NaTitleColor forState:UIControlStateNormal];
    
     NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"点击获取验证码"];
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[tncString length]}];
    //此时如果设置字体颜色要这样
    [tncString addAttribute:NSForegroundColorAttributeName value:NaTitleColor  range:NSMakeRange(0,[tncString length])];
    
    //设置下划线颜色...
    [tncString addAttribute:NSUnderlineColorAttributeName value:NaTitleColor range:(NSRange){0,[tncString length]}];
    [button setAttributedTitle:tncString forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getMessageCodeBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //
    nextBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    nextBtn.frame = CGRectMake(20, CGRectGetMaxY(self.messageCodeFi.frame)+20, SceneWidth-40, 45);
    [nextBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
    [nextBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    nextBtn.backgroundColor =[UIColor whiteColor];
    
    //    [nextBtn xw_roundedCornerWithCornerRadii:CGSizeMake((SceneWidth-40)/2, 45/2)   cornerColor:BgColor corners:UIRectCornerAllCorners borderColor:[UIColor lightGrayColor] borderWidth:0.3];
    nextBtn.layer.cornerRadius = 4;
    nextBtn.clipsToBounds = YES;
    nextBtn.layer.borderWidth = 0.3;
    nextBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
    
    [self.view addSubview:nextBtn];
    
    [nextBtn addTarget:self action:@selector(nextPagewBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.alertLa.text = @"绑定银行卡需要短信确认，验证码已发送至手机：135******,请按提示操作";

}

- (void)getMessageCodeBtnAction:(UIButton*)sender{

    self.view.backgroundColor =[UIColor greenColor];

}

- (void)nextPagewBtnClickAction:(UIButton*)sender{
    ChangNewCodeController *newVC =[[ChangNewCodeController alloc]init];
    
    [self.navigationController pushViewController:newVC animated:YES];
    
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
