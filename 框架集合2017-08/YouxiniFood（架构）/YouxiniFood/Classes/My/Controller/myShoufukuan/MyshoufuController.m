//
//  MyshoufuController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyshoufuController.h"
#import "CreatQrImage.h"


@interface MyshoufuController ()<readQRmessageDelegate>
@property(nonatomic,strong)UIImageView *qrImageV;

@end

@implementation MyshoufuController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    UIImageView *shoukuanImage =[[UIImageView alloc]init];
    shoukuanImage.frame = CGRectMake(20, 20, 30, 20);
    shoukuanImage.image =[UIImage imageNamed:@"bg_shoufukuang"];
    [QrView addSubview:shoukuanImage];
    
    UILabel * fukauanLa =[[UILabel alloc]init];
    fukauanLa.frame =CGRectMake(CGRectGetMaxX(shoukuanImage.frame)+10, 20, SceneWidth/3, 20);
    fukauanLa.textColor = [UIColor colorWithHexStringg:@"#333333"];
    fukauanLa.text = @"向商家付款";
    fukauanLa.font  = [UIFont systemFontOfSize:14];
    [QrView addSubview:fukauanLa];
    
    UIView *linView =[[UIView alloc]init];
    linView.frame =CGRectMake(20, CGRectGetMaxY(shoukuanImage.frame)+10, QrView.width-40, 0.5);
    linView.backgroundColor = LineColor;
    [QrView addSubview:linView];
    
    //显示二维码图片
    self.qrImageV =[[UIImageView alloc]init];
    self.qrImageV.frame = CGRectMake(60, CGRectGetMaxY(linView.frame)+20, QrView.width -120, QrView.width -120);
//    self.qrImageV.backgroundColor=[UIColor greenColor];
    self.qrImageV.layer.borderWidth = 0.5;
    self.qrImageV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [QrView addSubview:self.qrImageV];
    
   //
    
    UILabel *youxianLa =[[UILabel alloc]init];
    if (SceneWidth<375) {
            youxianLa.frame = CGRectMake(20, CGRectGetMaxY(self.qrImageV.frame)+30, QrView.width/2-30, 20);
    } else {
            youxianLa.frame = CGRectMake(60, CGRectGetMaxY(self.qrImageV.frame)+30, self.qrImageV.width/2-20, 20);
    }

    youxianLa.font = [UIFont systemFontOfSize:13];
    youxianLa.textColor =[UIColor colorWithHexStringg:@"#666666"];
    [QrView addSubview:youxianLa];
    
    UILabel *yueLa =[[UILabel alloc]init];
     if (SceneWidth<375) {
           yueLa.frame = CGRectMake(CGRectGetMaxX(youxianLa.frame), CGRectGetMaxY(self.qrImageV.frame)+30, QrView.width/2+30, 20);
     }else{
           yueLa.frame = CGRectMake(CGRectGetMaxX(youxianLa.frame), CGRectGetMaxY(self.qrImageV.frame)+30, self.qrImageV.width/2+20, 20);
     }
//    yueLa.frame = CGRectMake(CGRectGetMaxX(youxianLa.frame), CGRectGetMaxY(self.qrImageV.frame)+30, self.qrImageV.width/2+20, 20);
    yueLa.font = [UIFont systemFontOfSize:13];
    yueLa.textColor = NaTitleColor;
    [QrView addSubview:yueLa];
    
    youxianLa.text = @"使用余额优先级：";
    yueLa.text = @"企业补助 -> 充值余额";
    
    //扫一扫
    
    UIView *saoView =[[UIView alloc]init];
    saoView.frame = CGRectMake(20, CGRectGetMaxY(QrView.frame)+20, SceneWidth-40, 50);
    saoView.backgroundColor =[UIColor whiteColor];
    saoView.layer.cornerRadius = 8;
    saoView.layer.masksToBounds= YES;
    saoView.layer.borderWidth = 0.3;
    saoView.layer.borderColor =[UIColor grayColor].CGColor;
    [self.view addSubview:saoView];
    
    UIImageView *saoIamgeV =[[UIImageView alloc]init];
    saoIamgeV.frame =CGRectMake(20, 12.5, 25, 25);
    saoIamgeV.image =[UIImage imageNamed:@"icon_shaoyishao.png"];
    [saoView addSubview:saoIamgeV];
    
    UILabel *saoLa =[[UILabel alloc]init];
    saoLa.frame = CGRectMake(CGRectGetMaxX(saoIamgeV.frame)+10, 0, SceneWidth-150, 50);
    saoLa.textColor =[UIColor colorWithHexStringg:@"#666666"];
    saoLa.text = @"扫一扫";
    [saoView addSubview:saoLa];
    
    //根据字符串生成二维码
    self.qrImageV.image = [CreatQrImage createQRimageString:@"123456" sizeWidth: QrView.width -120 fillColor:[UIColor whiteColor]];
    UITapGestureRecognizer *tapE =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(readQrTapAction:)];
    [saoView addGestureRecognizer:tapE];
    

}

- (void)readQrTapAction:(UITapGestureRecognizer*)sender{
    
    ReadQrMessageController *readQrVC =[[ReadQrMessageController alloc]init];
    readQrVC.title = @"收付款";
    readQrVC.readQRdelegate = self;
    [self.navigationController pushViewController:readQrVC animated:YES];
    

}

-(void)readQRMessage:(NSString *)messageString{

    NSLog(@"收付款二维码扫描结果--%@",messageString);
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
