//
//  GerengongshiNewViewController.m
//  WiseAPP
//
//  Created by app on 16/11/29.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "GerengongshiNewViewController.h"
#import "HYBSectionModel.h"
#import "HYBHeaderView.h"
#import "RequestGongshiTableViewCell.h"
#import "PeopleBanciAddCell.h"
#import "GerengongshiHeadView.h"
#import "BanciModel.h"
#import "UserModel.h"
#import "GongshiDataModel.h"
#import "RequestViewController.h"

static NSString *kCellIdentfier = @"UITableViewCell";
static NSString *kHeaderIdentifier = @"HeaderView";
@interface GerengongshiNewViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionDataSources;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableArray* firstSectionArray;
@property(nonatomic,strong)NSMutableArray* titleArray;
@property(nonatomic,strong)NSMutableArray* gongshiArray;
@property(nonatomic,strong)NSMutableArray* banciArray;
@property(nonatomic,strong)NSMutableArray* banciIdAray;


@property(nonatomic,assign)NSInteger cellCount;
@property(nonatomic,strong)GongshiDataModel*gongshiModel;
@property(nonatomic,strong)HYBHeaderView* headView;

@property(nonatomic,strong)UILabel* topTimeLa;
@property(nonatomic,strong)UIView* customHeadView;
@property(nonatomic,strong)UIView* upView;
@property(nonatomic,strong)UIView* requestHoursV;
@property(nonatomic,strong)UIImageView* requestImageV;

@property(nonatomic,strong)GerengongshiHeadView* ZView;
@property(nonatomic,strong)GerengongshiHeadView* Sview;
@property(nonatomic,strong)GerengongshiHeadView* Hview;
@property(nonatomic,strong)GerengongshiHeadView* Xview;

@property(nonatomic,assign)NSInteger allowDays; //允许工时


@end

@implementation GerengongshiNewViewController
-(NSMutableArray *)gongshiArray{
    if (!_gongshiArray) {
        _gongshiArray=[NSMutableArray array];
    }
    return _gongshiArray;
}
-(NSMutableArray *)banciArray{

    if (!_banciArray) {
        _banciArray=[NSMutableArray array];
    }
    return _banciArray;

}
//-(NSMutableArray *)banciIdAray{
//    if (_banciIdAray) {
//        _banciIdAray=[NSMutableArray array];
//    }
//    return _banciIdAray;
//}
//-(NSMutableArray *)titleArray{
//    if (!_titleArray) {
//        _titleArray=[NSMutableArray array];
//    }
//    return _titleArray;
//}
//-(void)viewWillAppear:(BOOL)animated{
//    self.titleArray=[NSMutableArray array];
//    //user
//    [self getUser];
//}
-(void)viewWillAppear:(BOOL)animated{
 [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    //gongshitongji
    [self getGongshiData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
         self.titleArray=[NSMutableArray array];
    self.banciIdAray=[NSMutableArray array];
    self.gongshiModel = [[GongshiDataModel alloc]init];
    [self getUser];
 
    //checkdata
    [self checkData];
    //time
    [self getBanciData];
    //request work hour
    [self addRequestHour];
    
   // [self addData];
    //顶部柱状图
    [self creatupview];
    self.tableView.backgroundColor =GlobBackGroundColor;
    self.tableView = [[UITableView alloc] initWithFrame:UIScreenBpunds style:(UITableViewStylePlain)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.tableView registerClass:[HYBHeaderView class] forHeaderFooterViewReuseIdentifier:kHeaderIdentifier];
    self.tableView.tableHeaderView =self.upView;
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    
    
}
-(void)saveAction:(UIBarButtonItem*)sender{

    
    [self addGenrengongshiData];

}
-(void)addGenrengongshiData{
   NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    NSMutableDictionary*pamrm =[NSMutableDictionary dictionary];
        [pamrm setObject:ID forKey:@"projectid"];
    [pamrm setObject:@(1) forKey:@"Userid[]"];
    [pamrm setObject:@"119" forKey:@"serviced[]"];
    [pamrm setObject:@"30" forKey:@"day[]"];
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"personalHoursAdd"] Token:self.tokenString parmpar:pamrm succeed:^(id data) {
        NSLog(@"%@",data);
        
    } failure:^(NSError *error) {
        
    }];
    

}
-(void)addRequestHour{
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    NSMutableDictionary* parm=[NSMutableDictionary dictionary];
    [parm setObject:ID forKey:@"projectid"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"applicationAdd/hours" ]Token:self.tokenString parmpar:parm succeed:^(id data) {
        NSLog(@"SSSSSSSS%@",data);
        
        
    } failure:^(NSError *error) {
        
    }];

    

}

-(void)addData{

    
    NSLog(@"%@mmmmmuuusss%lu",self.titleArray,(unsigned long)self.titleArray.count);
    
    self.dataArray=[NSMutableArray array];
    self.firstSectionArray =[NSMutableArray array];
    
    //self.dataArray=  (NSMutableArray*)@[@"张三",@"李四"];
    self.firstSectionArray=(NSMutableArray*)@[@"33",@"44",@"55"];
    //userArray
    // self.titleArray =(NSMutableArray*)@[@"去申请工时",@"张三",@"李四"];
    // self.cellCount =self.titleArray.count;
    
    
    _sectionDataSources = [[NSMutableArray alloc] init];
    
    //第一层 tabview  headView
    for (NSUInteger i = 0; i < self.titleArray.count+1; ++i) {
        HYBSectionModel *sectionModel = [[HYBSectionModel alloc] init];
        sectionModel.isExpanded = NO;
        if (i==0) {
            //sectionModel.gongshititle = @"去申请工时";
            sectionModel.sectionTitle = @"去申请工时";
        } else {
            UserModel*model=self.titleArray[i-1];
            sectionModel.gongshititle = [NSString stringWithFormat:@"%@时",model.username];
            sectionModel.sectionTitle = [NSString stringWithFormat:@"%@", model.name];
        }
        
        
        if (i==0) {
            sectionModel.cellModels = self.firstSectionArray;
        }else if (i==1){
            sectionModel.cellModels = self.dataArray;
        }
        
        [_sectionDataSources addObject:sectionModel];
    }
    
    
}
//查看
-(void)checkData{

    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    NSMutableDictionary*parm=[NSMutableDictionary dictionary];
    [parm setObject:ID forKey:@"ID"];
    
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"personalHourslist"] Token:self.tokenString parmpar:parm succeed:^(id data) {
        NSLog(@"KKKKK%@-%@",data,[data allValues]);
        
        
    } failure:^(NSError *error) {
        
    }];
}
//get user
-(void)getUser{
      NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    NSMutableDictionary*parm=[NSMutableDictionary dictionary];
    [parm setObject:ID forKey:@"projectid"];
    NSString*time=[NSString stringWithFormat:@"%ld-%ld-%ld",(long)self.year,(long)self.month,(long)self.days];
    [parm setObject:time forKey:@"date"];
    
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"personalHours/UserList"] Token:self.tokenString parmpar:parm succeed:^(id data) {
     
        for (NSDictionary*dic in data[@"resultMessage"]) {
                 UserModel*model=[UserModel new];
        [model setValuesForKeysWithDictionary:dic];
            [self.titleArray addObject:model];
    
        }
       
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addData];
          [self.tableView reloadData];
            if (self.titleArray==0) {
                [self AlerVCtitleString:@"提示" messageString:@"暂无员工，请添加员工" doneString:@"确定"];
            }
          
        });
         [self.gongshiModel setValuesForKeysWithDictionary:data[@"hours"]];
        NSLog(@"%@PPPPPP%@----%d",self.gongshiModel, data,self.gongshiModel.workinghours);//员工不足
        
    } failure:^(NSError *error) {
        
    }];
    


}
-(void)getGongshi{


}

// get banci
-(void)getBanciData{

    self.dataArray =[NSMutableArray array];
    
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //账号密码
    [param setObject:ID forKey:@"projectid"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"serviceList"] Token:self.tokenString parmpar:param succeed:^(id data) {
        for (NSDictionary*dic in data[@"resultMessage"]) {
            BanciModel*model=[BanciModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            [self.banciArray addObject:model.servicesname];
            [self.banciIdAray addObject:[NSString stringWithFormat:@"%d",model.banciID]];
                       }
       NSLog(@"%@UUUUUU%@",data,self.banciIdAray);
          [self.tableView  reloadData];
        
    } failure:^(NSError *error) {
        
    }];


}
//get gongshi
-(void)getGongshiData{
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    NSMutableDictionary*parm=[NSMutableDictionary dictionary];
    [parm setObject:ID forKey:@"projectid"];
    NSString*time=[NSString stringWithFormat:@"%ld-%ld-%ld",(long)self.year,(long)self.month,(long)self.days];
    [parm setObject:time forKey:@"date"];
    
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"personalHours/UserList"] Token:self.tokenString parmpar:parm succeed:^(id data) {
        
         [self.gongshiModel setValuesForKeysWithDictionary:data[@"hours"]];
        dispatch_async(dispatch_get_main_queue(), ^{
         
            [self.tableView reloadData];
            
        });
       
        NSLog(@"%@KKKLLLLNNN%@----%d",self.gongshiModel, data,self.gongshiModel.workinghours);//员工不足
        
        //add data
        self.ZView.numberLa.text =[NSString stringWithFormat:@"%d",self.gongshiModel.workinghours];
        self.Sview.numberLa.text =[NSString stringWithFormat:@"%d",self.gongshiModel.remaininghours];
        self.Hview.numberLa.text =[NSString stringWithFormat:@"%d",self.gongshiModel.approved];
        self.Xview.numberLa.text =[NSString stringWithFormat:@"%d",self.gongshiModel.actual];
        NSString*str=[NSString stringWithFormat:@"%d",self.gongshiModel.attendance];
        self.allowDays =[str intValue];
  
    } failure:^(NSError *error) {
        
    }];
    
    

}




-(void)creatupview{
    
    self.upView =[[UIView alloc]init];
    self.upView.frame =CGRectMake(0, 0, SCREEN_WIDTH, PROPORTION_HIGHT(200));
   // [self.view addSubview:self.upView];
    self.upView.backgroundColor=GlobBackGroundColor;
    self.upView.hidden = NO;
    
    //时间
    UIButton* topYMLeftBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    topYMLeftBtn.frame =CGRectMake(PROPORTION_WIDTH(100), 10, PROPORTION_WIDTH(30), PROPORTION_HIGHT(30));
    topYMLeftBtn.backgroundColor=[UIColor redColor];
    [self.upView addSubview:topYMLeftBtn];
    [topYMLeftBtn setImage:[UIImage imageNamed:@"home_gerenT_left"] forState:(UIControlStateNormal)];
    [topYMLeftBtn setImage:[UIImage imageNamed:@"home_gerenT_left"] forState:(UIControlStateHighlighted)];
    
    UIImageView*uplaBg=[[UIImageView alloc]init];
    uplaBg.frame = CGRectMake(CGRectGetMaxX(topYMLeftBtn.frame)+5, 10, PROPORTION_WIDTH(135), PROPORTION_HIGHT(30));
    //uplaBg.backgroundColor =[UIColor greenColor];
    uplaBg.image =[UIImage imageNamed:@"home_textfile_duanbg.png"];
    [self.upView addSubview:uplaBg];
    
    self.topTimeLa=[[UILabel alloc]init];
    self.topTimeLa.frame =uplaBg.bounds;
    self.topTimeLa.textAlignment=NSTextAlignmentCenter;
    [uplaBg addSubview:self.topTimeLa];
  //初始时间
    [self currentTime];

    
    UIButton*topYMRightBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    topYMRightBtn.frame = CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(100), 10, PROPORTION_WIDTH(30), PROPORTION_HIGHT(30));
    topYMRightBtn.backgroundColor=[UIColor cyanColor];
    [self.upView addSubview:topYMRightBtn];
    [topYMRightBtn setImage:[UIImage imageNamed:@"home_gerenT_right"] forState:(UIControlStateNormal)];
    [topYMRightBtn setImage:[UIImage imageNamed:@"home_gerenT_right"] forState:(UIControlStateHighlighted)];
    //four round  view
    self.ZView =[[GerengongshiHeadView alloc]init];
    self.ZView .frame =CGRectMake(10, CGRectGetMaxY(topYMLeftBtn.frame)+PROPORTION_HIGHT(30), PROPORTION_WIDTH(80), PROPORTION_HIGHT(80));
    [self.upView addSubview: self.ZView ];
     self.ZView .layer.cornerRadius =PROPORTION_WIDTH(40);
     self.ZView .layer.borderWidth = 2;
     self.ZView .layer.borderColor =[UIColor colorWithRed:23.0/255 green:134.0/255 blue:255/255 alpha:1].CGColor;
    
    self.Sview =[[GerengongshiHeadView alloc]init];
    self.Sview .frame =CGRectMake(CGRectGetMaxX(self.ZView.frame)+PROPORTION_WIDTH(11), CGRectGetMaxY(topYMLeftBtn.frame)+PROPORTION_HIGHT(30), PROPORTION_WIDTH(80), PROPORTION_HIGHT(80));
    [self.upView addSubview: self.Sview ];
   self.Sview .layer.cornerRadius =PROPORTION_WIDTH(40);
   self.Sview .layer.borderWidth = 2;
    self.Sview .layer.borderColor =[UIColor colorWithRed:23.0/255 green:134.0/255 blue:255/255 alpha:1].CGColor;

    self.Hview =[[GerengongshiHeadView alloc]init];
   self.Hview .frame =CGRectMake(CGRectGetMaxX(self.Sview.frame)+PROPORTION_WIDTH(11), CGRectGetMaxY(topYMLeftBtn.frame)+PROPORTION_HIGHT(30), PROPORTION_WIDTH(80), PROPORTION_HIGHT(80));
    [self.upView addSubview:  self.Hview ];
    self.Hview .layer.cornerRadius =PROPORTION_WIDTH(40);
  self.Hview.layer.borderWidth = 2;
   self.Hview.layer.borderColor =[UIColor colorWithRed:23.0/255 green:134.0/255 blue:255/255 alpha:1].CGColor;
    
    self.Xview =[[GerengongshiHeadView alloc]init];
     self.Xview .frame =CGRectMake(CGRectGetMaxX(self.Hview.frame)+PROPORTION_WIDTH(11), CGRectGetMaxY(topYMLeftBtn.frame)+PROPORTION_HIGHT(30), PROPORTION_WIDTH(80), PROPORTION_HIGHT(80));
    [self.upView addSubview: self.Xview ];
   self.Xview .layer.cornerRadius =PROPORTION_WIDTH(40);
    self.Xview.layer.borderWidth = 2;
    self.Xview.layer.borderColor =[UIColor colorWithRed:23.0/255 green:134.0/255 blue:255/255 alpha:1].CGColor;
    
    //添加

    //测试数据
    self.ZView.titleLa.text=@"总计工时";
    self.Sview .titleLa.text=@"剩余工时";
    self.Hview .titleLa.text=@"核定人数";
    self.Xview .titleLa.text=@"现有人数";

    [topYMLeftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [topYMRightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
//申请工时
-(void)turnRequestVc:(UITapGestureRecognizer*)sender{

  
    if (self.dataArray.count!=0) {
          RequestViewController* requestVC=[[RequestViewController alloc]init];
            requestVC.banciArray =self.banciArray;
             requestVC.banciID=self.banciIdAray;
        [self.navigationController pushViewController:requestVC animated:YES];

    } else {
        [self AlerVCtitleString:@"提示" messageString:@"暂时没有班次，请前往班次添加页面添加" doneString:@"确定"];
    }

  }

//current time
-(void)currentTime{
    if (self.month>0&&self.month<13 ) {
       
            self.topTimeLa.text=[NSString stringWithFormat:@"%ld年%ld月",(long)self.year,(long)self.month];

    }
    else if (self.month<1){
        self.year-=1;
        self.month=11;
        self.month+=1;
         self.topTimeLa.text=[NSString stringWithFormat:@"%ld年%ld月",(long)self.year,(long)self.month];
    
    }else if (self.month>12){
        self.year+=1;
        self.month=0;
        self.month++;
        self.topTimeLa.text=[NSString stringWithFormat:@"%ld年%ld月",(long)self.year,(long)self.month];
    }

}

-(void)leftBtnAction:(UIButton*)sender{
    self.month--;
    
        [self currentTime];
        
   
}
-(void)rightBtnAction:(UIButton*)sender{
    self.month++;
    [self currentTime];
    
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.sectionDataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        HYBSectionModel *sectionModell = self.sectionDataSources[section];
        return sectionModell.isExpanded ? self.firstSectionArray.count : 0;
    }else{
        HYBSectionModel *sectionModel = self.sectionDataSources[section];
        return sectionModel.isExpanded ? self.dataArray.count : 0;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        
        RequestGongshiTableViewCell *cell=[self.tableView  dequeueReusableCellWithIdentifier:@"diaohuancell"];
        
        if (cell==nil) {
            cell=[[RequestGongshiTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"diaohuancell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell.leftNameLa.text =@"666";
        }
        
        
        return cell;
    }
    PeopleBanciAddCell *cell=[self.tableView  dequeueReusableCellWithIdentifier:@"peoplecell"];
    
    if (cell==nil) {
        cell=[[PeopleBanciAddCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"peoplecell"];
    }
    BanciModel*model=self.dataArray[indexPath.row];
    cell.quebianLeftLa.text =model.servicesname;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor orangeColor];
    cell.quebianLeftLa.textColor =textCententColor;
    cell.quebianLa.text =[NSString stringWithFormat:@"%ld",(long)self.allowDays];
    
    [cell.quebianleftBtn addTarget:self action:@selector(peopleLeftBtnAction:event:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.quebianRightBtn addTarget:self action:@selector(peoprightBtnAction:event:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

-(void)peopleLeftBtnAction:(UIButton*)sender event:(id)event{

     NSSet * touches =[event allTouches];
    UITouch * touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView ];
    NSIndexPath * indexPath = [self.tableView  indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil){
        self.allowDays-=1;
    }
    [self.tableView reloadData];
}
-(void)peoprightBtnAction:(UIButton*)sender event:(id)event{
   
    NSSet * touches =[event allTouches];
    UITouch * touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_tableView];
    NSIndexPath * indexPath = [_tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil){
        self.allowDays+=1;
    }
  
       [self.tableView reloadData];
    
}



//headView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    HYBHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderIdentifier];
    
    HYBSectionModel *sectionModel = self.sectionDataSources[section];
    view.model = sectionModel;
    view.expandCallback = ^(BOOL isExpanded) {
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section]
                 withRowAnimation:UITableViewRowAnimationFade];
    };
    if ([view.titleLabel.text isEqualToString:@"去申请工时"]) {
        
    UIView*TapView =[[UIView alloc]init];
    TapView.frame=CGRectMake(0, 0, PROPORTION_WIDTH(110), PROPORTION_HIGHT(45));
    [view addSubview:TapView];
    TapView.backgroundColor=[UIColor clearColor];
    
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(turnRequestVc:)];
    [view addGestureRecognizer:tap];
    }

    
    return view;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PROPORTION_HIGHT(45);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return PROPORTION_HIGHT(45);
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
