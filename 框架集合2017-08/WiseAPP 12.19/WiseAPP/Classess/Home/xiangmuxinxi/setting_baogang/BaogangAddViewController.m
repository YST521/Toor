//
//  BaogangAddViewController.m
//  WiseAPP
//
//  Created by app on 16/11/3.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaogangAddViewController.h"
#import "PublieTableViewCell.h"
#import "BaoGangSelectGangweiViewController.h"
#import "BaogangViewController.h"
#import "GangweiSetModel.h"
#import "GangweiModel.h"
#import "BanciModel.h"
#import "BaogangAddTimeCell.h"
#import "TimeDHViewController.h"
#import "BangangModel.h"
#import "BaogangViewController.h"

@interface BaogangAddViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,passTimHMvalue>

@property(nonatomic,strong)UITableView *baogangAddTabView;
@property(nonatomic,strong)UITableView* timeTabView;
@property(nonatomic,strong)UIView* timeTabHeadView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)UITextField* timeLa;


@property(nonatomic,strong)NSMutableArray* timeDataArray;
@property(nonatomic,strong)NSMutableArray* banciArray;
@property(nonatomic,strong)UIPickerView *pickView;
@property(nonatomic,strong)UIView* bgView;
@property(nonatomic,strong)UILabel* titleLa;
@property(nonatomic,strong)NSArray* pickArray;
@property(nonatomic,strong)UIButton* addTimeBtn;

@property(nonatomic,strong)NSMutableArray* pointArray;
@property(nonatomic,strong)NSString* baogangTime;
@property(nonatomic,strong)NSString* baogangBanci;
@property(nonatomic,strong)NSString* banciTime;
@property(nonatomic,strong)NSString* pointStr;
//报岗数组
@property(nonatomic,strong)NSMutableArray* baogangpointArray;
@property(nonatomic,strong)NSMutableArray* banciIdArray;
//
@property(nonatomic,strong)NSMutableArray* baogangbanciArray;
@property(nonatomic,strong)NSString* pickTime;
@property(nonatomic,strong)NSString* pickBanci;
@property(nonatomic,strong)NSMutableArray* baogangTimeArray;

@end
static NSString* baogangsettingCellID=@"baogangsettingCellID";
static NSString* baogangAddTimeCellID=@"baogangAddTimeCellID";
static NSString* timeCell=@"timeCell";
@implementation BaogangAddViewController
//-(NSMutableArray *)baogangTimeArray{
//    if (!_baogangTimeArray) {
//        _baogangTimeArray=[NSMutableArray array];
//    }
//    return _baogangTimeArray;
//}
-(void)viewWillAppear:(BOOL)animated{
 [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"报岗信息设置";
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    
    [self addData];
    [self addView];
    
}
//right save data
-(void)saveAction:(UIButton*)sender{

    if (self.upPageType==1) {
        [self updateBaogangData];
    } else {
        [self addbaogangData];
    }
 
    
}
//load data 
-(void)addbaogangData{

    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:ID forKey:@"projectid"];
    
    NSString*jsontimeStr=[self dictionaryOrArrrayToJSONData:self.baogangTimeArray];
    [param setObject:jsontimeStr forKey:@"reportingtime"];
    // NSString* allowTimeStr= [self.pickTime substringToIndex:1];
        [param setObject:self.pickTime forKey:@"jetlag"];
    [param setObject:@([self.pickBanci intValue]) forKey:@"serviceid"];
        [param setObject:@([self.pointStr intValue]) forKey:@"postsettingid"];
    
    
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"newspaperpostAdd"] Token:self.tokenString parmpar:param succeed:^(id data) {

            [self turnpage];
        
        
    } failure:^(NSError *error) {
        
    }];


}
//update Data
-(void)updateBaogangData{
    
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:ID forKey:@"projectid"];
        [param setObject:@(self.model.baogangID)  forKey:@"id"];
    NSString*jsontimeStr=[self dictionaryOrArrrayToJSONData:self.baogangTimeArray];
    [param setObject:jsontimeStr forKey:@"reportingtime"];
    // NSString* allowTimeStr= [self.pickTime substringToIndex:1];
    [param setObject:self.pickTime forKey:@"jetlag"];
    [param setObject:@([self.pickBanci intValue]) forKey:@"serviceid"];
    [param setObject:@([self.pointStr intValue]) forKey:@"postsettingid"];
    
    
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"newspaperpostAdd"] Token:self.tokenString parmpar:param succeed:^(id data) {

            [self turnpage];
      
    } failure:^(NSError *error) {
        
    }];
    
    
}

//编辑完成跳转到首页
-(void)turnpage{
    
    for (UIViewController*controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[BaogangViewController class]]) {
           BaogangViewController*bancVC=(BaogangViewController*)controller;
            [self.navigationController popToViewController:bancVC animated:YES];
        }
    }
    
}

-(void)addData{
    self.baogangbanciArray=[NSMutableArray array];
    self.dataArray=[NSMutableArray array];
    self.timeDataArray=[NSMutableArray array];
    self.baogangTimeArray=[NSMutableArray array];
    self.banciArray = [NSMutableArray array];
    self.banciIdArray=[NSMutableArray array];
    self.pickArray=[NSArray array];
    self.dataArray =(NSMutableArray*)@[@"11",@"22",@"33"];
    self.timeDataArray = (NSMutableArray*)@[@"5分钟",@"10分钟",@"15分钟"];
    //self.baogangTimeArray=(NSMutableArray*)@[@"08：00",@"09:00",@"10:00"];
    
    [self getBanciData];
}

//get banci data
-(void)getBanciData{

    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //账号密码
    [param setObject:ID forKey:@"projectid"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"serviceList"] Token:self.tokenString parmpar:param succeed:^(id data) {
        for (NSDictionary*dic in data[@"resultMessage"]) {
            BanciModel*model=[BanciModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.banciArray addObject:model.servicesname];
            [self.banciIdArray addObject:[NSString stringWithFormat:@"%d",model.banciID]];
        
        [self.baogangAddTabView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];

}

//turn page


-(void)addView{

    
    self.baogangAddTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PROPORTION_HIGHT(45*4)) style:(UITableViewStylePlain)];
    [self.view addSubview:self.baogangAddTabView];
    self.baogangAddTabView.backgroundColor=GlobBackGroundColor;
    //self.baogangAddTabView.tableHeaderView = self.headView;
    self.baogangAddTabView.dataSource = self;
    self.baogangAddTabView.delegate = self;
    [self.baogangAddTabView registerClass:[PublieTableViewCell class] forCellReuseIdentifier: baogangsettingCellID];
    [self.baogangAddTabView registerClass:[BaogangAddTimeCell class] forCellReuseIdentifier:baogangAddTimeCellID];
     self.baogangAddTabView.tableFooterView=[[UIView alloc]init];
    
    //timetabview
    self.timeTabHeadView =[[UIView alloc]init];
    self.timeTabHeadView.frame =CGRectMake(0,0, SCREEN_WIDTH, PROPORTION_HIGHT(45));
    self.timeTabHeadView.backgroundColor=[UIColor whiteColor];
   // [self.view addSubview:self.timeTabHeadView];
    UILabel*la=[[UILabel alloc]init];
    la.frame =CGRectMake(10, 0, SCREEN_WIDTH-20, PROPORTION_HIGHT(45));
    la.text=@"报岗开始时间";
    la.textColor=textCententColor;
    [self.timeTabHeadView addSubview:la];
    self.timeTabHeadView.hidden=NO;
    UIView*lineV=[[UIView alloc]init];
    lineV.frame=CGRectMake(0, self.timeTabHeadView.height-0.5, SCREEN_WIDTH, 0.5);
    lineV.backgroundColor=[UIColor lightGrayColor];
    [self.timeTabHeadView addSubview:lineV];
    
    self.timeTabView=[[UITableView alloc]init];
    self.timeTabView.frame =CGRectMake(0, CGRectGetMaxY(self.baogangAddTabView.frame), SCREEN_WIDTH, SCREEN_HEIGHT -self.timeTabHeadView.y-PROPORTION_HIGHT(20));
   //s self.timeTabView.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.timeTabView];
    self.timeTabView.dataSource=self;
    self.timeTabView.delegate=self;
    [self.timeTabView registerClass:[BaogangAddTimeCell class] forCellReuseIdentifier:timeCell];
      self.timeTabView.tableFooterView=[[UIView alloc]init];
    self.timeTabView.hidden=NO;
    self.timeTabView.tableHeaderView =self.timeTabHeadView;
//    if (self.baogangTimeArray.count ==0) {
//        self.timeTabHeadView.hidden=YES;
//        self.timeTabView.hidden=YES;
//    }
//    
    
//    self.addTimeBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.addTimeBtn.frame =CGRectMake(STANDARD_X, PROPORTION_HIGHT(30), STANDARD_WIDTH, STANDARD_HEIGHT);
//    KUIbutton(self.addTimeBtn);
//    KUIbuttonClick(self.addTimeBtn);
//    [self.addTimeBtn setTitle:@"添加报岗时间" forState:(UIControlStateNormal )];
//    [self.addTimeBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
//-(void)addBtnAction:(UIButton*)sender{
//
//
//
//}

#pragma mark-------tableviewdelegate----------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView ==self.baogangAddTabView){
       return  4;
    }else{
        return self.baogangTimeArray.count;
    }
 
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //删除
    return UITableViewCellEditingStyleDelete;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.timeTabView) {
        [self.baogangTimeArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:indexPath.row];

    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.baogangAddTabView) {
        PublieTableViewCell*cell=[self.baogangAddTabView  dequeueReusableCellWithIdentifier:baogangsettingCellID];
        
        cell.leftLa.textColor=textCententColor;
        cell.rightLa.textColor =textColorPlace;
        if (indexPath.section ==0) {
            if (indexPath.row ==0) {
                
                cell.leftLa.text = @"选择岗位";
                
            }else if (indexPath.row==1){
                cell.leftLa.text = @"报岗允许时间差";
                
            }else if (indexPath.row ==2){
                
                cell.leftLa.text = @"选择班次";
            }else if (indexPath.row ==3){
                
                cell.leftLa.text = @"设置时间";
            }
            
        }
        
        
        return cell;

    }
       BaogangAddTimeCell*cell=[self.timeTabView dequeueReusableCellWithIdentifier:timeCell];
    
        if (self.baogangTimeArray.count !=0) {
            for (NSString*str in self.baogangTimeArray) {
                NSLog(@"MMMMMMMMMMM%@",str);
            }
         NSLog(@"%@nnnnnn%lu", self.baogangTimeArray,(unsigned long)self.baogangTimeArray.count);
            cell.leftLa.text=self.baogangTimeArray[indexPath.row];
            [cell.rightBtn addTarget:self action:@selector(cellButtonClicked:event:) forControlEvents:(UIControlEventTouchUpInside)];
        }
  
    
        return cell;
   
   

}
//delete time

- (void)cellButtonClicked:(id)sender event:(id)event {
    NSSet * touches =[event allTouches];
    UITouch * touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.timeTabView];
    NSIndexPath * indexPath = [self.timeTabView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil) {
        [self.baogangTimeArray removeObjectAtIndex:indexPath.row];
        
        [self.timeTabView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:indexPath.row];

        
    }
    [self.timeTabView reloadData];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==self.baogangAddTabView) {
        
    
    if (indexPath.row ==0) {
    
         [self addJobs];
    
    }else if (indexPath.row==1){
     
            [self addDevitainTime];
    }else if (indexPath.row==2){
        [self addBanci];
    
    }else{
        [self addTim];
       
    }
    }


}
-(void)addTim{

    TimeDHViewController* timeVC=[[TimeDHViewController alloc]init];
    timeVC.timeTitle=@"报岗时间";
    timeVC.delegate=self;
    [self presentViewController:timeVC animated:YES completion:nil];

}
-(void)passTime:(NSString *)timeString type:(NSString *)typeString{

    NSIndexPath*index =[self.baogangAddTabView indexPathForSelectedRow];
    PublieTableViewCell*cell=[self.baogangAddTabView cellForRowAtIndexPath:index];
    cell.rightLa.text =timeString;
        [self.baogangTimeArray addObject:timeString];
    cell.rightLa.textColor=textColorPlace;
  
       [self.baogangAddTabView reloadData];
        [self.timeTabView  reloadData];

}
-(void)addDevitainTime{
 
   // [self addPickView:@"允许偏差时间选择" dataArray:self.timeDataArray];
    self.pickArray = @[@"5分钟",@"10分钟",@"15分钟"];
    [self creatPickView:@"允许偏差时间选择"];
   
}

-(void)addBanci{
   //[self addPickView:@"班次选择" dataArray:self.banciArray];
      self.pickArray = self.banciArray;
    [self creatPickView:@"班次选择"];

  
}


//pickViewdelegate 学历
-(void)creatPickView:(NSString*)title {
    self.bgView=[[UIView alloc]initWithFrame:UIScreenBpunds];
    self.bgView.backgroundColor = popBGColore;
    [self.view addSubview:self.bgView];
    self.bgView.userInteractionEnabled = YES;
    
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(300));
    bgView.backgroundColor=[UIColor whiteColor];
    [self.bgView addSubview:bgView];
    
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
   self.pickView.userInteractionEnabled = YES;
    self.bgView.hidden = NO;
    
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
    
    
    [XueLibackBtn addTarget:self action:@selector(xueliBackAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [XueLidoneBtn addTarget:self action:@selector(xueliDoneAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)xueliBackAction:(UIButton*)sender{

 self.bgView.hidden = YES;
    
}
-(void)xueliDoneAction:(UIButton*)sender{
  
  self.bgView.hidden = YES;
 [self.baogangAddTabView reloadData];
}

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
    
    NSIndexPath *indexPath = [self.baogangAddTabView indexPathForSelectedRow];
    PublieTableViewCell *cell = [self.baogangAddTabView cellForRowAtIndexPath: indexPath];
    cell.rightLa.text = self.pickArray[row];
    
    cell.rightLa.textColor= textCententColor;
    if ([[self.pickArray firstObject]isEqualToString:@"5分钟"]) {
        self.pickTime =title;
    } else {
        
        self.pickBanci=self.banciIdArray[row];
    }
    return title;
}


-(void)addJobs{

    BaoGangSelectGangweiViewController* selectGangweiVC=[[BaoGangSelectGangweiViewController alloc]init];
   selectGangweiVC.navigationItem .title =@"岗位选择";
    selectGangweiVC.pointIdStr=^(NSString*str,NSString*name){
        self.pointStr = str;
        
        
        NSIndexPath* index=[self.baogangAddTabView indexPathForSelectedRow];
       PublieTableViewCell*cell=[self.baogangAddTabView cellForRowAtIndexPath:index];
        cell.rightLa.text =name;
        cell.rightLa.textColor =textCententColor;
        [self.baogangAddTabView reloadData];
        
    };
    
    
    [self.navigationController pushViewController:selectGangweiVC animated:YES];
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
