//
//  WorkTypeMessageController.m
//  WiseAPP
//
//  Created by app on 16/10/17.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "WorkTypeMessageController.h"
#import "WoryTypeMessageCell.h"
#import "SucessPopView.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "CellShenGaoView.h"
#import "CellShowCompanyNameView.h"
#import "CellShowDizhiView.h"
#import "CellJinjiLianxirenView.h"
#import "HangyeViewController.h"
#import "QudaoView.h"
#import "QudaoFirstView.h"
#import "JINengViewController.h"
#import "LoginViewController.h"
#import "YingpingQudaoViewController.h"
#import "RegestModel.h"
#import "FindPasswordViewController.h"

@interface WorkTypeMessageController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate>
@property(nonatomic,strong)UITableView* customTableview;
@property(nonatomic,strong)SucessPopView* popView;
@property(nonatomic,strong)CellShenGaoView* heightView;
@property(nonatomic,strong)CellShowCompanyNameView* companyNameView;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)NSMutableArray* leftIconArray;
@property(nonatomic,strong)NSArray* titleArray;
@property(nonatomic,strong)NSArray* pickArray;
@property(nonatomic,strong)UIView* pickBGView;
@property(nonatomic,strong)UIPickerView* pickView;
@property(nonatomic,strong)CellShowDizhiView* dizhiView;
@property(nonatomic,strong)CellJinjiLianxirenView* contentView;
@property(nonatomic,strong)QudaoView* qudaoView;
@property(nonatomic,strong)QudaoFirstView* qudaoFirstView;
@property(nonatomic,strong)NSString* qudaoFriendName;
@property(nonatomic,strong)NSString* qudaoFrientPnum;

@property(nonatomic,strong)NSString* xueliString;
@property(nonatomic,strong)NSString* hunyingString;
@property(nonatomic,assign)NSInteger  requestType;
@property(nonatomic,strong)NSMutableArray* hangyeArray;
@property(nonatomic,strong)NSMutableArray* jinengArray;
@property(nonatomic,strong)NSString* jinjiLixirenType;
@property(nonatomic,strong)NSString* qudaoType;
@property(nonatomic,strong)NSString* resultCodeInt;
@property(nonatomic,strong)RegestModel* model;
@end

static NSString*workTypeCellID= @"workTypeCellID";


@implementation WorkTypeMessageController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title =@"个人信息完善";
    self.model=[RegestModel new];
    [self addDate];
    [self addView];
   
}
-(void)addDate{
    self.dataArray=[NSMutableArray array];
    self.leftIconArray=[NSMutableArray array];
    self.titleArray=[NSArray array];
    self.pickArray =[NSArray array];
    self.hangyeArray=[NSMutableArray array];
    self.jinengArray=[NSMutableArray array];
    
    self.leftIconArray = (NSMutableArray*)@[@"iconfont-shengaoo.png",@"iconfont-xueli.png",@"iconfont-hunyin.png",@"iconfont-dizhi.png",@"iconfont-lianxiren.png",@"iconfont-danweitijian.png",@"iconfont-xingye.png",@"iconfont-woquan.png",@"iconfont-qudao.png"];
    self.titleArray =@[@"身高",@"学历",@"婚姻状况",@"现居住地址",@"紧急联系人",@"现单位名称",@"行业",@"技能",@"应聘渠道"];

}
-(void)addView{

    
    self.customTableview=[[UITableView alloc]initWithFrame:UIScreenBpunds style:(UITableViewStylePlain)];
    [self.view addSubview:self.customTableview];
    [self.customTableview registerClass:[WoryTypeMessageCell class] forCellReuseIdentifier:workTypeCellID];
    self.customTableview.dataSource= self;
    self.customTableview .delegate = self;
    
    UIView*footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    //footview.backgroundColor=[UIColor redColor];
    self.customTableview.tableFooterView = footview;
    
    UIButton*commitBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    commitBtn.frame = CGRectMake(STANDARD_X, PROPORTION_HIGHT(20), STANDARD_WIDTH, STANDARD_HEIGHT);
    KUIbutton(commitBtn);
    KUIbuttonClick(commitBtn);
    [commitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [footview addSubview:commitBtn];
    [commitBtn addTarget:self action:@selector(commitBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)commitBtnAction:(UIButton*)sender{
     NSString*string =[NSString stringWithFormat:@"%@/%@/%@",self.qudaoType,self.qudaoView.FriendName,self.qudaoView.frientNum];
    NSLog(@"AASSS%@--BB-%@-MM-%@",string,self.xueliString,self.hunyingString);

//判断 参数是否为空
    [self dataValidation];
   
    
}
//条件判断
-(void)dataValidation{
    if (self.heightView.heightFile.text.length !=0) {
        [self Vadizhi];
    } else {
        [self AlerVCtitleString:@"提示" messageString:@"身高不能为空" doneString:@"确定"];
    }
}
-(void)Vadizhi{
    NSLog(@"UUUUUU%@",self.dizhiView.heightFile.text);
    if (self.dizhiView.heightFile.text.length !=0) {
        [self vaContent];
    } else {
        [self AlerVCtitleString:@"提示" messageString:@"现居住地址不能为空" doneString:@"确定"];
    }

}
-(void)vaContent{

    if (self.contentView.contanctName.text.length !=0&&self.contentView.contentPhone.text.length !=0) {
        [self vaHangye];
    } else {
        [self AlerVCtitleString:@"提示" messageString:@"联系人姓名和手机号码不能为空" doneString:@"确定"];
    }

}
-(void)vaHangye{
    
    if (self.hangyeArray.count !=0) {
        [self vaJinneng];
    } else {
        [self AlerVCtitleString:@"提示" messageString:@"行业不能为空" doneString:@"确定"];
    }
    
}
-(void)vaJinneng{
    
    if (self.jinengArray.count !=0) {
        [self vaQudao];
    } else {
        [self AlerVCtitleString:@"提示" messageString:@"技能不能为空" doneString:@"确定"];
    }
    
}
//当所有不为空时方可请求数据
-(void)vaQudao{
    
    if (self.jinengArray.count !=0) {
        //请求数据
        [self uploadImageee];
        
    } else {
        [self AlerVCtitleString:@"提示" messageString:@"渠道不能为空" doneString:@"确定"];
    }
    
}

-(void)backAction:(UIButton*)sender{

    self.popView.hidden = YES;
}

-(void)doneBtnAction:(UIButton*)sender{
//跳转到首页

    //        //跳转到登陆页面
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[LoginViewController class]]) {
                    LoginViewController *loginVC =(LoginViewController *)controller;
                    [self.navigationController popToViewController:loginVC animated:YES];
                }
            }

    
}


#pragma marl-----tableview delegate -----

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.leftIconArray.count;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return PROPORTION_HIGHT(45);
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WoryTypeMessageCell*cell=[self.customTableview dequeueReusableCellWithIdentifier:workTypeCellID];
    cell.leftIcon.image = [UIImage imageNamed:self.leftIconArray[indexPath.row]];
    cell.leftLabel.text = self.titleArray[indexPath.row];
    cell.rightImage.image=[UIImage imageNamed:@"icon_right"];
    
    return cell;
}
#pragma mark ------cellAction--------------

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        self.heightView=[[CellShenGaoView alloc]initWithFrame:UIScreenBpunds];
        self.heightView.titleLabel.text= @"身高";
       
        [self.view addSubview:self.heightView];
        
        [self.heightView.backBtn addTarget:self action:@selector(backHBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.heightView.doneBtn addTarget:self action:@selector(doneHBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        YSTLog(@"666666");
        
    }else if (indexPath.row == 1){
        
        self.pickArray= @[@"初中",@"高中",@"大学"];
        [self  creatPickView:@"学历" ];
        
    }else if (indexPath.row == 2){
        
        self.pickArray= @[@"未婚",@"已婚"];
        [self  creatPickView:@"婚姻状况" ];
        
    }else if (indexPath.row == 3){
        self.dizhiView=[[CellShowDizhiView alloc]initWithFrame:UIScreenBpunds];
        self.dizhiView.titleLabel.text= @"现居住地址";
         self.dizhiView.heightFile.text=@"请输入现居住地址";
        self.dizhiView.heightFile.delegate=self;        [self.view addSubview:self.dizhiView];
        
        [self.dizhiView.backBtn addTarget:self action:@selector(dizhiBackCaction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.dizhiView.doneBtn addTarget:self action:@selector(dizhiDoneCAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
    }else if (indexPath.row == 4){
        
    self.contentView=[[CellJinjiLianxirenView alloc]initWithFrame:UIScreenBpunds];
        [self.view addSubview:self.contentView];
        [self.contentView.saveBtn addTarget:self action:@selector( ContentSaveBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView.motherBtn addTarget:self action:@selector(motherBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView.fatherBtn addTarget:self action:@selector(fatherBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView.sisterBtn addTarget:self action:@selector(sisterBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.contentView.brotherBtn addTarget:self action:@selector(brotherBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    }else if (indexPath.row == 5){
        self.companyNameView=[[CellShowCompanyNameView alloc]initWithFrame:UIScreenBpunds];
        
    [self.view addSubview:self.companyNameView];
        
        [self.companyNameView.backCBtn addTarget:self action:@selector(backCaction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.companyNameView.doneCBtn addTarget:self action:@selector(doneCAction:) forControlEvents:(UIControlEventTouchUpInside)];
   
    }else if (indexPath.row == 6){
        
        HangyeViewController*hangyeVC=[[HangyeViewController alloc]init];
        hangyeVC.passHangyeBlock = ^(NSMutableArray * s){
            self.hangyeArray = s;
            
            NSIndexPath *indexPath = [self.customTableview indexPathForSelectedRow];
            WoryTypeMessageCell *cell = [self.customTableview cellForRowAtIndexPath: indexPath];
            cell.rightLabel.textColor = textCententColor;
            cell.rightLabel.text =self.hangyeArray[0];
            [self.customTableview reloadData];
            
        };

        [self.navigationController pushViewController:hangyeVC animated:YES];

        
    }else if (indexPath.row == 7){
        
       JINengViewController*hangyeVC=[[JINengViewController alloc]init];
    
         hangyeVC.passBlock = ^(NSMutableArray * s){
           self.jinengArray = s;
      
             NSIndexPath *indexPath = [self.customTableview indexPathForSelectedRow];
             WoryTypeMessageCell *cell = [self.customTableview cellForRowAtIndexPath: indexPath];
             cell.rightLabel.textColor = textCententColor;
             cell.rightLabel.text =self.jinengArray[0];
            [self.customTableview reloadData];
         
        };

        [self.navigationController pushViewController:hangyeVC animated:YES];
        
    }else if (indexPath.row == 8){
        
        self.pickArray= @[@"58同城",@"劳务中介",@"朋友"];
        [self  creatPickView:@"应聘渠道" ];
        
    }
    
}


//渠道first点击事件

-(void)qudaoFBackAction:(UIButton*)sender{
    self.qudaoFirstView.hidden = YES;
}
-(void)qudaoFdoneAction:(UIButton*)sender{
    self.qudaoFirstView.hidden = YES;
    self.qudaoFirstView.firstBtn.backgroundColor=textCententColor;
}

//选择紧急联系人点击事件
-(void)ContentSaveBtnAction:(UIButton*)sender{
    
    if (self.jinjiLixirenType.length !=0) {
        if([self valiMobile:self.contentView.contentPhone.text]){
        
            NSIndexPath *indexPath = [self.customTableview indexPathForSelectedRow];
            
            WoryTypeMessageCell *cell = [self.customTableview cellForRowAtIndexPath: indexPath];
            
            cell.rightLabel.text = self.contentView.contanctName.text ;
      
            self.contentView.contanctName.delegate=self;
            cell.rightLabel.textColor = textColorPlace;
            self.contentView.hidden = YES;
            
            [self.customTableview reloadData];
        }else{
         [self AlerVCtitleString:@"提示" messageString:@"联系方式格式不对，请重新填写" doneString:@"确定"];
        }
    
     }else{
        [self AlerVCtitleString:@"提示" messageString:@"请选择一个联系人" doneString:@"确定"];
    }
}
-(void)motherBtnAction:(UIButton*)sender{

    sender.selected = !sender.selected;
        
        if (sender.selected == YES) {
         self.jinjiLixirenType = @"母亲";
        }else{
       self.jinjiLixirenType=@"";
        }

}
-(void)fatherBtnAction:(UIButton*)sender{
    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        self.jinjiLixirenType = @"父亲";
    }else{
        self.jinjiLixirenType=@"";
    }
    
}
-(void)sisterBtnAction:(UIButton*)sender{
    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        self.jinjiLixirenType = @"姐妹";
    }else{
        self.jinjiLixirenType=@"";
    }
    
}
-(void)brotherBtnAction:(UIButton*)sender{
    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        self.jinjiLixirenType = @"兄弟";
    }else{
        self.jinjiLixirenType=@"";
    }
    
}
//身高点击事件
-(void)backHBtnAction:(UIButton*)sender{


    self.heightView.hidden=YES;

}

-(void)doneHBtnAction:(UIButton*)sender{

    if (self.heightView.heightFile.text.length !=0) {
        NSIndexPath *indexPath = [self.customTableview indexPathForSelectedRow];
        
        WoryTypeMessageCell *cell = [self.customTableview cellForRowAtIndexPath: indexPath];
        
        cell.rightLabel.text = self.heightView.heightFile.text;
        self.heightView.heightFile.delegate =self;
        self.heightView.heightFile.delegate =self;
        cell.rightLabel.textColor = textCententColor;
        [self.customTableview reloadData];
        self.heightView.hidden =YES;
    } else {
       [self AlerVCtitleString:@"提示" messageString:@"请填写你的身高" doneString:@"确定"];
    }
    

    
}
//公司名称
-(void)backCaction:(UIButton*)sender{
self.companyNameView.hidden=YES;

}

-(void)doneCAction:(UIButton*)sender{
    if ( self.companyNameView.heightFile.text.length !=0) {
        NSIndexPath *indexPath = [self.customTableview indexPathForSelectedRow];
        
        WoryTypeMessageCell *cell = [self.customTableview cellForRowAtIndexPath: indexPath];
        
        cell.rightLabel.text = self.companyNameView.heightFile.text;
       self.companyNameView.heightFile.delegate =self;
        cell.rightLabel.textColor = textCententColor;
        [self.customTableview reloadData];
        self.companyNameView.hidden =YES;
    } else {
        [self AlerVCtitleString:@"提示" messageString:@"请填写当前公司名称" doneString:@"确定"];
    }
    

}
//现居住位置点击事件

-(void)dizhiBackCaction:(UIButton*)sender{
    self.dizhiView.hidden=YES;
    
}
#pragma mark - UITextViewDelegate-----
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"请输入现居住地址";
        textView.textColor = [UIColor grayColor];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
  if([textView.text isEqualToString:@"请输入现居住地址"]){
                textView.text=@"";
         
    textView.textColor=[UIColor blackColor];
          }
    NSLog(@"aaa******%@",textView.text);
}

//现居住地址
-(void)dizhiDoneCAction:(UIButton*)sender{
    if ( self.dizhiView.heightFile.text.length !=0) {
        
        NSIndexPath *indexPath = [self.customTableview indexPathForSelectedRow];
        
        WoryTypeMessageCell *cell = [self.customTableview cellForRowAtIndexPath: indexPath];
        
        cell.rightLabel.text = self.dizhiView.heightFile.text;
        self.dizhiView.heightFile.delegate = self;
        self.dizhiView.heightFile.delegate =self;
        cell.rightLabel.textColor = textCententColor;
        [self.customTableview reloadData];
        self.dizhiView.hidden =YES;

        
    } else {
        [self AlerVCtitleString:@"提示" messageString:@"请填地址，现居住地址不能为空" doneString:@"确定"];
    }
    
    
}
//pickViewdelegate 学历
-(void)creatPickView:(NSString*)title {
    self.pickBGView=[[UIView alloc]initWithFrame:UIScreenBpunds];
    self.pickBGView.backgroundColor = popBGColore;
    [self.view addSubview:self.pickBGView];
    
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(300));
    bgView.backgroundColor=[UIColor whiteColor];
    [self.pickBGView addSubview:bgView];
    
    UIImageView*titleBg=[[UIImageView alloc]init];
    titleBg.frame = CGRectMake(0, 0, bgView.width,  STANDARD_HEIGHT);
    titleBg.image =[UIImage imageNamed:@"nabackgroundImage.png"];
    [bgView addSubview:titleBg];
    
  UILabel* titleLabel=[[UILabel alloc]initWithFrame:titleBg.bounds];
   titleLabel.text =  title;
   titleLabel.textAlignment =NSTextAlignmentCenter;
   titleLabel.textColor =  [UIColor whiteColor];
    [bgView addSubview: titleLabel];
    
    self.pickView=[[UIPickerView alloc]init];
    self.pickView.frame = CGRectMake(0, CGRectGetMaxY(titleBg.frame), bgView.width, PROPORTION_HIGHT(45*self.pickArray.count));
    [bgView addSubview:self.pickView];
    self.pickView.delegate =self;
    self.pickView.dataSource = self;
    self.pickBGView.userInteractionEnabled = YES;
    
   UIButton* XueLibackBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
  XueLibackBtn.frame = CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(self.pickView.frame)+PROPORTION_HIGHT(50), (bgView.width-PROPORTION_WIDTH(16)*2-10)/2, STANDARD_HEIGHT);
    KUIbutton( XueLibackBtn);
    KUIbuttonClick(XueLibackBtn);
    [ XueLibackBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [bgView addSubview: XueLibackBtn];
    
   UIButton* XueLidoneBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
  XueLidoneBtn.frame=CGRectMake(CGRectGetMaxX( XueLibackBtn.frame)+10,  XueLibackBtn.y,  XueLibackBtn.width,  XueLibackBtn.height);
    KUIbutton(XueLidoneBtn);
    KUIbuttonClick(XueLidoneBtn);
    [XueLidoneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [bgView addSubview:XueLidoneBtn];
    self.pickBGView.hidden = NO;
    
    [XueLibackBtn addTarget:self action:@selector(xueliBackAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
        [XueLidoneBtn addTarget:self action:@selector(xueliDoneAction:) forControlEvents:(UIControlEventTouchUpInside)];

}

-(void)xueliBackAction:(UIButton*)sender{

 self.pickBGView.hidden = YES;

}
-(void)xueliDoneAction:(UIButton*)sender{

     self.pickBGView.hidden = YES;
    [self.customTableview reloadData];
}
#pragma mark --------pickviewdelegate-----
//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;//第一个展示字母、第二个展示数字
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
  
return self.pickArray.count;
}
#pragma mark UIPickerView Delegate Method 代理方法

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title = nil;
   title = self.pickArray[row];
    NSIndexPath *indexPath = [self.customTableview indexPathForSelectedRow];
     WoryTypeMessageCell *cell = [self.customTableview cellForRowAtIndexPath: indexPath];
   
    if ([title isEqualToString:@"朋友"]) {
        
        self.qudaoView=[[QudaoView alloc]init];
        self.qudaoView.frame = UIScreenBpunds;
        [self.view addSubview:self.qudaoView];
          self.qudaoView.hidden =NO;
                [self.qudaoView.cannelBtn addTarget:self action:@selector(qudaoCanBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
                [self.qudaoView.doneBtn addTarget:self action:@selector(qudaoDonbeBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
           cell.rightLabel.text = title;
        self.qudaoType=title;
    } else {
        self.qudaoView.hidden =YES;
   
        cell.rightLabel.text = title;
        if ([[self.pickArray firstObject ]isEqualToString:@"初中"]) {
              self.xueliString = title;
        } else if([[self.pickArray firstObject ]isEqualToString:@"未婚"]) {
               self.hunyingString=title;
        }else{
        self.qudaoType=title;
            
        }

    
        cell.rightLabel.textColor= textCententColor;
    }

   return title;
}

//应聘渠道
-(void)qudaoCanBtnAction:(UIButton*)sender{
    NSLog(@"66666");
 self.qudaoView.hidden = YES;
 
}

-(void)qudaoDonbeBtnAction:(UIButton*)sender{

   self.pickBGView.hidden = YES;
    self.qudaoView.hidden=YES;

}

//接口测试
- (void)uploadImageee{
    NSLog(@"XXXXXX%@",self.qudaoType);
    NSLog(@"XXXX%@",self.jinjiLixirenType);
    NSLog(@"xxxxx%@",self.xueliString);
    NSLog(@"xxxxx%@",self.hangyeArray);
    NSLog(@"xxxxx%@",self.jinengArray);
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //账号密码
    [dict setObject:self.workPhoneName forKey:@"username"];
    [dict setObject:self.workPassword forKey:@"password"];
    //身份证信息
    [dict setObject:self.modelA.name forKey:@"name"];
    [dict setObject:self.modelA.gender forKey:@"gender"];
    NSString*dateString =[NSString stringWithFormat:@"%@.%@.%@",self.modelA.byear,self.modelA.bmonth,self.modelA.bday];
    [dict setObject:dateString forKey:@"birthday"];
    [dict setObject:self.modelA.address forKey:@"address"];
    [dict setObject:self.modelA.idnumber forKey:@"number"];
    
    [dict setObject:self.modelB.authority forKey:@"publisher"];
    
    [dict setObject:self.modelB.validdate forKey:@"validate"];
    //用户具体信息
    //身高
    NSString *Membership_Id1  = self.heightView.heightFile.text;
    int  Membership_Id11 = [Membership_Id1 intValue];
    
    //用NSNnmber 来转int 类型的   这样子Membership_Id  就可以放进字典里面｀
    NSNumber * Membership_Id =  [NSNumber numberWithInt:Membership_Id11];
    [dict setObject:Membership_Id forKey:@"height"];
    //学历
    [dict setObject:self.xueliString forKey:@"graduate"];
    //电话号码
    [dict setObject:self.workPhoneName forKey:@"telephone"];
    //现居住地址
    [dict setObject:self.dizhiView.heightFile.text forKey:@"living_address"];
    //紧急联系人
    NSDictionary*diem=[NSDictionary dictionary];
    diem = @{@"name":self.contentView.contanctName.text,@"relation":self.jinjiLixirenType,@"telephone":self.contentView.contentPhone.text};
    NSString*json=[self dictionaryToJson:diem];
    [dict setObject:json forKey:@"emergency_contact"];
    NSArray*array=[NSArray array];
   // array=@[@"11",@"33"];
    array = self.hangyeArray;
    NSData*dataJS=[self toJSONData:array];
    
    NSString *jsonString = [[NSString alloc] initWithData:dataJS
                                                 encoding:NSUTF8StringEncoding];
    
    [dict setObject:jsonString forKey:@"industry"];
    
    NSArray*arrayyy=[NSArray array];
    //arrayyy=@[@"11",@"33"];
    arrayyy =self.jinengArray;
    NSData*dataJSss=[self toJSONData:array];
    
    NSString *jsonStringgg = [[NSString alloc] initWithData:dataJSss
                                                   encoding:NSUTF8StringEncoding];
    
    [dict setObject:jsonStringgg forKey:@"skill"];
    //应聘渠道
    if ([self.qudaoType isEqualToString:@"pengy"]) {
        NSString*string =[NSString stringWithFormat:@"%@/%@/%@",self.qudaoType,self.qudaoView.FriendName,self.qudaoView.frientNum];
         [dict setObject:string forKey:@"channel"];
    }else{
    [dict setObject:self.qudaoType forKey:@"channel"];
    }
    NSLog(@"字典数据验证%@",dict);
    /*
     此段代码如果需要修改，可以调整的位置
     1. 把upload.php改成网站开发人员告知的地址
     2. 把file改成网站开发人员告知的字段名
     */
    //AFN3.0+基于封住HTPPSession的句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    [[UserIDmanger shareUseridMangwer ].userIDarray addObject:self.workPhoneName];
    [[UserIDmanger shareUseridMangwer ].userIDarray addObject:self.workPassword];

    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:@"http://118.178.88.132:8000/api/register/user" parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        UIImage* idCardImageA=[self baseToImageBString:self.modelA.croppedImage];
        UIImage* idCardImageB=[self baseToImageBString:self.modelB.croppedImage];
        UIImage* idCardHeadImage=[self baseToImageBString:self.modelA.headImage];
        UIImage *image1 =[UIimageScaleImage scaleImage:idCardImageA toKb:180];
        UIImage *image2 =[UIimageScaleImage scaleImage:idCardImageB toKb:180];
        UIImage *image3 =[UIimageScaleImage scaleImage:idCardHeadImage toKb:180];
        
        NSData*data1=UIImageJPEGRepresentation(image1, 0.2);
        NSData*data2=UIImageJPEGRepresentation(image2, 0.2);
        NSData*data3=UIImageJPEGRepresentation(image3, 0.2);
        //上传
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 对应网站上[upload.php中]处理文件的[字段"file"]
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        
       [formData appendPartWithFileData:data1 name:@"id_card_positive" fileName:@"id_card_positive" mimeType:@"image/jpg"];
        [formData appendPartWithFileData:data2 name:@"id_card_negative" fileName:@"222png" mimeType:@"image/jpg"];
        [formData appendPartWithFileData:data3 name:@"id_card_head_image" fileName:@"id_card_head_image" mimeType:@"image/jpg"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"图片上传上传成功 %@", responseObject);
      for (NSArray*array in [responseObject allValues]) {
            
            NSLog(@"图片上传 %@",array);

        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.model setValuesForKeysWithDictionary:responseObject];
            [self result];
            
            
        });
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"图片上传上传失败 %@", error);
        }];
    
    
}
-(void)result{
    if (self.model.resultCode == 0) {
        
//        //跳转到登陆页面
//        for (UIViewController *controller in self.navigationController.viewControllers) {
//            if ([controller isKindOfClass:[LoginViewController class]]) {
//                LoginViewController *loginVC =(LoginViewController *)controller;
//                [self.navigationController popToViewController:loginVC animated:YES];
//            }
//        }
        self.popView=[[SucessPopView alloc]initWithFrame:UIScreenBpunds];
        
            [self.view addSubview:self.popView];
        
            [self.popView.backBtn addTarget:self action:@selector(backAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.popView.doneBtn addTarget:self action:@selector(doneBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
    }else if(self.model.resultCode == 1){
        
        //跳转到登陆页面
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[LoginViewController class]]) {
                LoginViewController *A =(LoginViewController *)controller;
                [self.navigationController popToViewController:A animated:YES];
            }
        }
        
        
        [self AlerVCtitleString:@"提示" messageString:@"用户已存在，请更换手机号重新注册！" doneString:@"确定"];
    }else{
        
        [self AlerVCtitleString:@"提示" messageString:@"注册失败请仔细核对注册信息" doneString:@"确定"];
    }
    
    
    

}
//base64转image
-(UIImage*)baseToImageBString:(NSString*)baseString{
    
    if([baseString isEqualToString:@""]){
        NSLog(@"数据为空");
    }
    NSData *decodedImageData = [[NSData alloc]
                                
                                initWithBase64EncodedString:baseString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    
    return decodedImage;
}

// 将字典或者数组转化为JSON串
- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
    
    
}

//字典转json
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//键盘回收
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.heightView.heightFile resignFirstResponder];
    [self.dizhiView.heightFile resignFirstResponder];
    [self.contentView.contanctName resignFirstResponder];
    [self.contentView.contentPhone resignFirstResponder];
    [self.companyNameView.heightFile resignFirstResponder];

    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}
-(void)AlerVCtitleString:(NSString*)title messageString:(NSString*)message doneString:(NSString*)doneString{
    
    UIAlertController*alerVC= [UIAlertController alertControllerWithTitle:title message:message preferredStyle:( UIAlertControllerStyleAlert)];
    UIAlertAction*al= [UIAlertAction actionWithTitle:doneString style:(UIAlertActionStyleDefault) handler:nil];
    [alerVC addAction:al];
    [self presentViewController:alerVC animated:YES completion:nil];
    
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
