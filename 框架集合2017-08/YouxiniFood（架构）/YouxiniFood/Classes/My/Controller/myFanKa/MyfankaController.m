//
//  MyfankaController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyfankaController.h"
#import "FankaZahngdanCell.h"
#import "FankaCellHeadView.h"
#import "PayCardViewController.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "FrozenPopView.h"
#import "QFDatePickerView.h"
#import "AppDelegate.h"
#import "PopPasswordView.h"
#import "InputPasswordBordView.h"
#import "JiedongPopView.h"


@interface MyfankaController ()<UITableViewDelegate,UITableViewDataSource,UIApplicationDelegate,PassWordViewDelegate,UIApplicationDelegate>{
    UIView *bgV;
}

@property (nonatomic,strong) UITableView        *fankaTabView;
@property (nonatomic,strong) FankaCellHeadView  *headView;
@property (nonatomic,strong) UILabel  *cellTilteLa,*monthShouruLa;
@property (nonatomic,strong) UILabel     *monthZhichuLa;
@property  (nonatomic,strong) FrozenPopView *froV;
@property (nonatomic,strong)  UIView       *popView;
//输入密码弹框
@property (nonatomic,strong)  InputPasswordBordView *wclV;
@property (nonatomic,strong) UILabel *alertLa ;
@property (nonatomic,strong) UIButton *pwcloseBtn;
@property (nonatomic,strong) UIButton *pwdoneBtn;
@property (nonatomic,strong) InputPasswordBordView *InpPw;
@property (nonatomic,strong) JiedongPopView *jiedongView;
@end


static NSString *fankaCellID =@"fankacellID";

@implementation MyfankaController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
//    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatNaItemBar];
    [self creatUI];
}

- (void)creatNaItemBar{
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_rili"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightItemClickAction:)];
}


- (void)backBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSDate *)dateWithString:(NSString *)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter dateFromString:dateStr];
}

- (void)creatUI{

    self.fankaTabView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight ) style:(UITableViewStylePlain)];
    self.fankaTabView.backgroundColor = BgColor;
    [self.view addSubview:self.fankaTabView];
    self.fankaTabView.delegate = self;
    self.fankaTabView.dataSource = self;
    [self.fankaTabView registerClass:[FankaZahngdanCell class] forCellReuseIdentifier:fankaCellID];
    
    self.headView =[[FankaCellHeadView alloc]init];
    self.headView.frame = CGRectMake(0, 0, SceneWidth, 180);
    
    self.fankaTabView.tableHeaderView = self.headView;

//    self.fankaTabView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.fankaTabView.backgroundView.backgroundColor = GoldColor;
    //防止cell头部悬浮与导航栏有透明间隙
//    self.fankaTabView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
    
    //取消分割线
    self.fankaTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
  //冻结饭卡  饭卡充值
    [self.headView.DongjieBtn addTarget:self action:@selector(dongjieBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
     [self.headView.ChongzhiBtn addTarget:self action:@selector(chongzhiBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

#pragma mark - clickAction

//冻结
- (void)dongjieBtnClickAction:(UIButton*)sender{
     NSLog(@"****************^^^^^^^^^666666");
// self.navigationController.navigationBar.hidden = YES;
//    self.navigationController.navigationBar.translucent = YES;
   
//   froV.frame = [UIScreen mainScreen].bounds;
//    
//    froV.backgroundColor= [UIColor redColor];
//    [self.view addSubview: self.froV];
    
//     AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    if ([self.headView.DongjieBtn.titleLabel.text isEqualToString:@"冻结饭卡"]) {
       
        self.froV =[[FrozenPopView alloc]init];

        self.froV.frame = CGRectMake(0, 0, SceneWidth, SceneHeight);
          [[UIApplication sharedApplication].keyWindow addSubview:self.froV];
        
    } else {
        [self alertViewTitle:@"确定" alretContent:@"饭卡已冻结，解冻饭卡请联系管理人员！"];
//        self.jiedongView =[[JiedongPopView alloc]init];
//        self.jiedongView.userInteractionEnabled = YES;
//    [app.window addSubview:self.jiedongView];
//        //解冻弹框点击事件
//[self.jiedongView.closeBtn addTarget:self action:@selector(closeJiedongView) forControlEvents:(UIControlEventTouchUpInside)];
//[self.jiedongView.jdoneBtn addTarget:self action:@selector(closeJiedongView) forControlEvents:(UIControlEventTouchUpInside)];
//        
//        UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeJiedongView)];
//        [self.jiedongView.closeBtn addGestureRecognizer:Tap];
//         [self.jiedongView addGestureRecognizer:Tap];
    }
 
    //冻结弹框点击事件
    [self.froV.cancelBtn addTarget:self action:@selector(cancelPopView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.froV.closeBtn addTarget:self action:@selector(cancelPopView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.froV.doneBtn addTarget:self action:@selector(doneBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
   
   
}

//- (void)closeJiedongView{
//     NSLog(@"*******jjjjjjjjj*******");
//    self.jiedongView.hidden= YES;
//}

//充值Btn
- (void)chongzhiBtnClickAction:(UIButton*)sender{
    
     NSLog(@"****************^^^^^^^^^7777");
//    [self turnUpPage];
    
    PayCardViewController*payVC = [[PayCardViewController alloc]init];
    [self.navigationController pushViewController:payVC animated:YES];
    
}

//日期选择
- (void)rightItemClickAction:(UIBarButtonItem*)sender{
    QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *str) {
        NSString *string = str;
        NSLog(@"str = %@",string);
    }];
    [datePickerView show];

  
}

//跳转到充值页面
-(void)turnUpPage{
//  self.tabBarController.selectedIndex = 1;
//    self.tabBarController.selectedIndex = 1;
    
//    for (UIViewController*collector in self.navigationController.viewControllers) {
//        if ([collector isKindOfClass:[PayCardViewController class]]) {
//           PayCardViewController*payVC =(PayCardViewController*)collector;
//            [self.navigationController popToViewController:payVC animated:YES];
//        }
//    }
   
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    MainTabBarController *tab = (MainTabBarController *)delegate.window.rootViewController;
//    MainNavigationController *nav = (MainNavigationController *)tab.viewControllers[1];
//     PayCardViewController *proCtl = [[PayCardViewController alloc]init];
//    
//     [nav pushViewController:proCtl animated:YES];
  
}
#pragma mark - popViewBtnClickAction

- (void)cancelPopView{
    self.froV.hidden = YES;
    NSLog(@"不冻结");
}
- (void)doneBtnClickAction:(UIButton*)sender{
    self.froV.hidden = YES;
    //冻结饭卡操作
     NSLog(@"冻结饭卡");
//    self.passWordPopView =[[PopPasswordView alloc]init];
//    self.passWordPopView.backgroundColor =[UIColor colorWithWhite:0.0 alpha:0.4];
//    self.passWordPopView.backgroundColor =[UIColor redColor];
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    [app.window addSubview:self.passWordPopView];
    
    [self creatPassWordPopView];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40*2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView*view =[[UIView alloc]init];
    view.frame =CGRectMake(0, 0, SceneWidth, 40);
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *suqareView =[[UIView alloc]init];
    suqareView.frame = CGRectMake(0, 0, 18, 13);
    suqareView.center = CGPointMake(20+9, view.frame.size.height/2);
    suqareView.backgroundColor = SquareColorGray;
    suqareView.layer.cornerRadius = 3;
    suqareView.clipsToBounds = YES;
    [view addSubview:suqareView];
    
    self.cellTilteLa =[[UILabel alloc]init];
    self.cellTilteLa.frame = CGRectMake(CGRectGetMaxX(suqareView.frame)+10, 10, SceneWidth/3, 20);
    self.cellTilteLa.textColor =[UIColor colorWithHexStringg:@"#333333"];
    self.cellTilteLa.font =[UIFont systemFontOfSize:14];
    [view addSubview:self.cellTilteLa];
    
    //本月支出收入
    UIView *shouzhiView =[[UIView alloc]init];
    shouzhiView.frame = CGRectMake(0,40, SceneWidth, 40);
    shouzhiView.backgroundColor=[UIColor whiteColor];
    [view addSubview:shouzhiView];
    
    self.monthZhichuLa = [[UILabel alloc]init];
    self.monthZhichuLa.frame = CGRectMake(20, 0, SceneWidth/2-20, 40);
    self.monthZhichuLa.font = [UIFont systemFontOfSize:14.0f];
    self.monthZhichuLa.textColor =[UIColor colorWithHexStringg:@"#333333"];
    [shouzhiView addSubview:self.monthZhichuLa];
    
    self.monthShouruLa = [[UILabel alloc]init];
    self.monthShouruLa.frame = CGRectMake(SceneWidth/2, 0, SceneWidth/2-20, 40);
    self.monthShouruLa.textColor =[UIColor colorWithHexStringg:@"#333333"];
    self.monthShouruLa.font = [UIFont systemFontOfSize:14.0f];
    [shouzhiView addSubview:self.monthShouruLa];
   
    //test
    self.cellTilteLa.text =@"本月";
    NSString*shouruStr =@"50:00";
    self.monthShouruLa.text = [NSString stringWithFormat:@"本月收入：%@",shouruStr];
    
    NSString*zhichuStr =@"50:00";
    self.monthZhichuLa.text = [NSString stringWithFormat:@"本月支出：%@",zhichuStr];
    
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FankaZahngdanCell *cell =[self.fankaTabView dequeueReusableCellWithIdentifier:fankaCellID ];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    UIView*footV =[[UIView alloc]init];
//    footV.frame = CGRectMake(0, 0, SceneWidth, 49);
//    self.fankaTabView.tableFooterView = footV;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}


//密码确认部分弹框及点击事件

- (void)creatPassWordPopView{
    
   bgV =[[UIView alloc]init];
    bgV.frame = [UIScreen mainScreen].bounds;

    bgV.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        [[UIApplication sharedApplication].keyWindow addSubview:bgV];
    self.popView  = [[UIView alloc]init];
    if (SceneHeight>600) {
        self.popView.frame = CGRectMake(40, SceneHeight*0.25, SceneWidth-80, SceneHeight*0.3);
    }else{
        self.popView.frame = CGRectMake(20, SceneHeight*0.20, SceneWidth-40, SceneHeight*0.36);
    }
    self.popView.backgroundColor = [UIColor whiteColor];
    self.popView.layer.cornerRadius = 8 ;
    self.popView.clipsToBounds = YES;
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    app.window.backgroundColor =[UIColor colorWithWhite:0.0 alpha:0.4];
//    [app.window addSubview:self.popView];
   self.view.backgroundColor =[UIColor colorWithWhite:0.0 alpha:0.4];
      [bgV addSubview:self.popView];
    
    UILabel *titleLa =[[UILabel alloc]init];
    titleLa.frame = CGRectMake(20, 30, self.popView.width - 40, 20);
    titleLa.text = @"请输入密码";
    titleLa.textAlignment = NSTextAlignmentCenter;
    [self.popView addSubview:titleLa];
    
    self.pwcloseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.pwcloseBtn.frame = CGRectMake(self.popView.width-30, 10, 15, 15);
    [ self.pwcloseBtn setBackgroundImage:[UIImage imageNamed:@"icon_guanbi"] forState:(UIControlStateNormal)];
    [self.popView addSubview: self.pwcloseBtn];
    
    //密码框
    self.InpPw = [[InputPasswordBordView alloc]init];
    //   self.InpPw.frame = CGRectMake(0, CGRectGetMaxY(titleLa.frame)+30, popView.width -40, 40);
    self.InpPw.centerX = self.popView.width/2;
    

        self.InpPw.frame = CGRectMake(0, CGRectGetMaxY(titleLa.frame)+30, 40*6, 40);
        self.InpPw.centerX = self.popView.width/2;
        self.InpPw.squareWidth = 40;
    //进入页面自动弹出键盘
    [self.InpPw becomeFirstResponder];
    
    self.InpPw.backgroundColor=[UIColor greenColor];
    [self.popView addSubview:self.InpPw];
    self.InpPw.passWordNum = 6;
    
    self.InpPw.pointRadius = 6;
    self.InpPw.pointColor = [UIColor blackColor];
    self.InpPw.rectColor =[UIColor lightGrayColor];
    self.InpPw.pointColor = [UIColor blackColor];
    //    wclV.textStore = @"123456";
    self.InpPw.delegate =self;
   
    //提示内容
    self.alertLa =[[UILabel alloc]init];
    self.alertLa.frame = CGRectMake(self.InpPw.originX, CGRectGetMaxY(self.InpPw.frame)+10, self.popView.width , 20);
    self.alertLa.font = [UIFont systemFontOfSize:12];
//    self.alertLa.textColor =[UIColor redColor];
    [self.popView addSubview:self.alertLa];
    
    
    self.pwdoneBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    if (SceneWidth>320) {
        self.pwdoneBtn.frame = CGRectMake(0,self.popView.height-55, self.InpPw.width, 45);
    }else{
    self.pwdoneBtn.frame = CGRectMake(0,self.popView.height-55, self.InpPw.width, 40);
    }
    
    self.pwdoneBtn.centerX =  self.InpPw.centerX;
    self.pwdoneBtn.layer.cornerRadius = 8;
    self.pwdoneBtn.layer.masksToBounds = YES;
    self.pwdoneBtn.layer.borderWidth = 0.5;
    self.pwdoneBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.pwdoneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.pwdoneBtn setTitleColor:[UIColor colorWithHexStringg:@"#999999"] forState:(UIControlStateNormal)];
    [self.popView addSubview:self.pwdoneBtn];
    
    [self.pwcloseBtn addTarget:self action:@selector(passwordCloseBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.pwdoneBtn addTarget:self action:@selector(passwordPopDoneBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
     self.pwdoneBtn.enabled = NO;
    
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.inputView resignFirstResponder];
//    [self.view endEditing:YES];
//}

- (void)passwordCloseBtnClickAction:(UIButton*)sender{
    
    self.popView.hidden = YES;
    bgV.hidden = YES;
    self.froV.hidden = YES;
//    [[UIApplication sharedApplication].keyWindow resignFirstResponder];
//     [self.inputView resignFirstResponder];
}
- (void)passwordPopDoneBtnClickAction:(UIButton*)sender{
    
//       [self.inputView resignFirstResponder];
    self.popView.hidden = YES;
        bgV.hidden = YES;
    self.froV.hidden = YES;
     [self showTipInfo:@"冻结饭卡成功！"];
    self.headView.DongjieBtn.backgroundColor = GoldColor;
    [self.headView.DongjieBtn setTitle:@"解冻饭卡" forState:(UIControlStateNormal)];
    
    NSLog(@"密码验证成功  冻结按钮点击事件");
}

#pragma mark - PassWordViewDelegate
/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(InputPasswordBordView *)passWord {
    NSLog(@"======密码改变：%@",passWord.textStore);
    //判断位数
    if (passWord.textStore.length != 6) {
        self.pwdoneBtn.enabled = NO;
        [self.pwdoneBtn setTitleColor:[UIColor colorWithHexStringg:@"#999999"] forState:(UIControlStateNormal)];
    }
}

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(InputPasswordBordView *)passWord inPutStr:(NSString*)intputSreing{
    NSLog(@"+++++++密码输入完成 --%@",intputSreing);
    if ([intputSreing isEqualToString:@"123456"]) {
        
        self.pwdoneBtn.enabled = YES;
        [self.pwdoneBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
        self.alertLa.textColor =[UIColor greenColor];
          self.alertLa.text = @"提示：密码正确，请点击确认建冻结饭卡！";
    } else {
         self.pwdoneBtn.enabled = NO;
        [self.pwdoneBtn setTitleColor:[UIColor colorWithHexStringg:@"#999999"] forState:(UIControlStateNormal)];
//        [self alertViewTitle:@"确定" alretContent:@"密码错误，请重新输入"];
            self.alertLa.textColor =[UIColor redColor];
        self.alertLa.text = @"提示：密码错误请重新输入！";
    }
    
}

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(InputPasswordBordView *)passWord {
    NSLog(@"-------密码开始输入");
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
