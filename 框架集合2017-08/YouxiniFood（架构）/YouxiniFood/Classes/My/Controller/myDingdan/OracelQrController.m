//
//  OracelQrController.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/4.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "OracelQrController.h"
#import "CreatQrImage.h"

@interface OracelQrController ()

@property(nonatomic,strong)UILabel     *titleLa;
@property(nonatomic,strong)UILabel     *detaLa;
@property(nonatomic,strong)UIImageView *qrImageV;

@end

@implementation OracelQrController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"取餐码"];
    [self creatUI];
    
}

- (void)creatUI{
    
    UIView *QrView =[[UIView alloc]init];
    QrView.frame = CGRectMake(20, 30, SceneWidth-40, SceneHeight*0.55);
    QrView.backgroundColor =[UIColor whiteColor];
    QrView.layer.cornerRadius = 8;
    QrView.layer.masksToBounds= YES;
    QrView.layer.borderWidth = 0.3;
    QrView.layer.borderColor =[UIColor grayColor].CGColor;
    [self.view addSubview:QrView];
    
   
    
    self.titleLa =[[UILabel alloc]init];
   self.titleLa.frame =CGRectMake(20, 20,  QrView.width - 40, 20);
    self.titleLa.textColor = [UIColor colorWithHexStringg:@"#333333"];
   
    self.titleLa.font  = [UIFont systemFontOfSize:14];
    [QrView addSubview:self.titleLa];
    
    UIView *linView =[[UIView alloc]init];
    linView.frame =CGRectMake(20, CGRectGetMaxY(self.titleLa.frame)+10, QrView.width-40, 0.5);
    linView.backgroundColor = LineColor;
    [QrView addSubview:linView];
    
    //显示二维码图片
    self.qrImageV =[[UIImageView alloc]init];
    self.qrImageV.frame = CGRectMake(60, CGRectGetMaxY(linView.frame)+20, QrView.width -120, QrView.width -120);
    //    self.qrImageV.backgroundColor=[UIColor greenColor];
    self.qrImageV.layer.borderWidth = 0.5;
    self.qrImageV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [QrView addSubview:self.qrImageV];
    
    
    
    self.detaLa =[[UILabel alloc]init];
           self.detaLa.frame = CGRectMake(20, CGRectGetMaxY(self.qrImageV.frame)+30, QrView.width, 20);
   self.detaLa.textAlignment = NSTextAlignmentCenter;
   self.detaLa.font = [UIFont systemFontOfSize:13];
   self.detaLa.textColor =[UIColor colorWithHexStringg:@"#666666"];
    [QrView addSubview:self.detaLa];
    
    self.detaLa.text = @"有效期至：2017/07/14 13:00";
     self.titleLa.text = @"午餐取餐码：0357 6666 8888";
    //根据字符串生成二维码
    self.qrImageV.image = [CreatQrImage createQRimageString:@"123456" sizeWidth: QrView.width -120 fillColor:[UIColor whiteColor]];
    
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
