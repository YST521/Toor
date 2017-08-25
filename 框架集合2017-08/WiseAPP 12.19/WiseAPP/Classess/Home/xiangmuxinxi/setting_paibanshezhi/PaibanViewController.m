//
//  PaibanViewController.m
//  WiseAPP
//
//  Created by app on 16/10/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "PaibanViewController.h"
#import "BanciAddPeopleViewController.h"
#import "TimeTableViewCell.h"
#import "RightTableViewCell.h"
#import "UIimageScaleImage.h"
#import "BanciModel.h"
#import "PaibanheadeModel.h"
#import "PaibanheadView.h"

@interface PaibanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)LDCalendarView    *calendarView;//日历控件
@property (nonatomic, strong)NSMutableArray *seletedDays;//选择的日期

@property(nonatomic,strong)UITableView*
timeTaView;
@property(nonatomic,strong)UITableView*rightTabView;
@property(nonatomic,strong)NSMutableArray* timeDataArray;
@property(nonatomic,strong)NSMutableArray* rightDataArray;
@property(nonatomic,strong)NSMutableArray* banciArray;
@property (nonatomic, strong) NSMutableArray *sectionDataSources;

@property(nonatomic,strong)UIButton* changRiBtn;
@property(nonatomic,strong)UIButton* ribanBtn;
@property(nonatomic,strong)UIButton* yebanBtn;
//
@property(nonatomic,strong)UILabel* topTimeLa;
//right headView
@property(nonatomic,strong)UIView * rightHeadView;
@property(nonatomic,strong)UILabel* headviewLa;
@property(nonatomic,strong)UILabel* headviewNum;
@property(nonatomic,strong)UIButton* headViewBtn;
//@property(nonatomic,assign)NSInteger year;
//@property(nonatomic,assign)NSInteger month;
@property(nonatomic,strong)UIImage* timeCellImage;

@end
static NSString *kHeaderIdentifier = @"paibanHeaderView";
@implementation PaibanViewController

//-(NSMutableArray *)timeDataArray{
//    if (_timeDataArray) {
//        _timeDataArray =[NSMutableArray array];
//    }
//    return _timeDataArray;
//}
//-(NSMutableArray *)rightDataArray{
//    if (!_rightDataArray) {
//        _rightDataArray =[NSMutableArray array];
//    }
//
//    return _rightDataArray;
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    [self getBanciData];
    [self addData];
    [self addView];
    
}
-(void)saveAction:(UIButton*)sender{
    
   // [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)addData{
    self.timeDataArray=[NSMutableArray array];
    self.rightDataArray=[NSMutableArray array];
   self.banciArray =[NSMutableArray array];
    
    
    self.timeDataArray=(NSMutableArray*)@[@"1",@"2",@"3"];
    
    
    self.rightDataArray=(NSMutableArray*)@[@"张三",@"李四",@"张三",@"张"];
   
    //时间
    self.year =[NSDateYMD nowYear];
    self.month =[NSDateYMD nowMonth];
    //[self addRittabviewData];
}
-(void)addRittabviewData{
    _sectionDataSources = [[NSMutableArray alloc] init];

    //班次
    for (NSUInteger i = 0; i < self.banciArray.count; ++i) {
        PaibanheadeModel *sectionModel = [[PaibanheadeModel alloc] init];
        sectionModel.isExpanded = NO;
        BanciModel*model =self.banciArray[i];
        sectionModel.sectionTitle = [NSString stringWithFormat:@"%@(0/5)", model.servicesname];
        NSMutableArray *itemArray = [[NSMutableArray alloc] init];
        //人员
        NSLog(@"rrrrrr%@",self.rightDataArray);
        for (NSUInteger j = 0; j < self.rightDataArray.count; ++j) {
           PaiBanCellModel *cellModel = [[PaiBanCellModel alloc] init];
            cellModel.title = [NSString stringWithFormat:@"**%@**section=%ld, row=%ld",self.rightDataArray[i], i, j];
            [itemArray addObject:cellModel];
        }
        sectionModel.cellModels = itemArray;
        
        [_sectionDataSources addObject:sectionModel];
    }
    
    
}
// get banci
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
            [self.banciArray addObject:model];
            
            if (self.banciArray.count ==0) {
                [self AlerVCtitleString:@"提示" messageString:@"暂无班次信息，前往班次添加页面添加" doneString:@"确定"];
            }
            [self addRittabviewData];//RIGHT DATA
            [self.rightTabView  reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(void)addView{
    //时间
    UIButton* topYMLeftBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    topYMLeftBtn.frame =CGRectMake(PROPORTION_WIDTH(100), 10, PROPORTION_WIDTH(30), PROPORTION_HIGHT(30));
    //topYMLeftBtn.backgroundColor=[UIColor redColor];
    [self.view addSubview:topYMLeftBtn];
    [topYMLeftBtn setImage:[UIImage imageNamed:@"home_gerenT_left"] forState:(UIControlStateNormal)];
    [topYMLeftBtn setImage:[UIImage imageNamed:@"home_gerenT_left"] forState:(UIControlStateHighlighted)];
    
    UIImageView*uplaBg=[[UIImageView alloc]init];
    uplaBg.frame = CGRectMake(CGRectGetMaxX(topYMLeftBtn.frame)+5, 10, PROPORTION_WIDTH(135), PROPORTION_HIGHT(30));
    uplaBg.image =[UIImage imageNamed:@"home_textfile_duanbg.png"];
    [self.view addSubview:uplaBg];
    
    self.topTimeLa=[[UILabel alloc]init];
    self.topTimeLa.frame =uplaBg.bounds;
    [uplaBg addSubview:self.topTimeLa];
    self.topTimeLa.textAlignment = NSTextAlignmentCenter;
    self.topTimeLa.text =[NSString stringWithFormat:@"%ld年%ld月",(long)self.year,(long)self.month];
    //NSLog(@"DDDDDDMM%ld--%ld--%ld",(long)[NSDateYMD nowYear],(long)[NSDateYMD nowMonth],(long)[NSDateYMD nowDay]);
    
    UIButton*topYMRightBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    topYMRightBtn.frame = CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(100), 10, PROPORTION_WIDTH(30), PROPORTION_HIGHT(30));
   // topYMRightBtn.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:topYMRightBtn];
    
    [topYMRightBtn setImage:[UIImage imageNamed:@"home_gerenT_right"] forState:(UIControlStateNormal)];
    [topYMRightBtn setImage:[UIImage imageNamed:@"home_gerenT_right"] forState:(UIControlStateHighlighted)];
    
    self.timeTaView = [[UITableView alloc]initWithFrame:CGRectMake(0, PROPORTION_HIGHT(50),SCREEN_WIDTH/3, SCREEN_HEIGHT -PROPORTION_HIGHT(80)) style:(UITableViewStylePlain)];
    [self.view addSubview:self.timeTaView];
    self.timeTaView.dataSource =self;
    self.timeTaView.delegate = self;
    [self.timeTaView registerClass:[TimeTableViewCell class] forCellReuseIdentifier:@"timeCell"];
    
    self.rightTabView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3+10,self.timeTaView.y,SCREEN_WIDTH/3*2-10, SCREEN_HEIGHT -PROPORTION_HIGHT(50)-PROPORTION_HIGHT(150)) style:(UITableViewStylePlain)];
    [self.view addSubview:self.rightTabView];
    self.rightTabView.dataSource =self;
    self.rightTabView.delegate = self;
    [self.rightTabView registerClass:[RightTableViewCell class] forCellReuseIdentifier:@"rightCell"];
    self.rightTabView.tableFooterView=[[UIView alloc]init];
    self.rightTabView.backgroundColor=GlobBackGroundColor;
      [self.rightTabView registerClass:[PaibanheadView class] forHeaderFooterViewReuseIdentifier:kHeaderIdentifier];

    [topYMLeftBtn addTarget:self action:@selector(upLaftBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
     [topYMRightBtn addTarget:self action:@selector(upRightBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //RIGHT TABVIEW BUTTON
    UIButton*rightFootBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    rightFootBtn.frame=CGRectMake( CGRectGetMaxX(self.timeTaView.frame)+PROPORTION_WIDTH(10), SCREEN_HEIGHT-PROPORTION_HIGHT(130), self.rightTabView.width-PROPORTION_WIDTH(20), PROPORTION_HIGHT(45));
    KUIbutton(rightFootBtn);
    KUIbuttonClick(rightFootBtn);
    [rightFootBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.view addSubview:rightFootBtn];
    [rightFootBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
//right done button
-(void)rightBtnAction:(UIButton*)sender{
    NSLog(@"保存班次人数");


}


//head time
-(void)upLaftBtnAction:(UIButton*)sender{
  
    //左
    if (self.month > 1) {
        self.month -= 1;
    }else {
        self.month = 12;
        self.year -= 1;
    }
  self.topTimeLa.text =[NSString stringWithFormat:@"%ld年%ld月",(long)self.year,(long)self.month];
}
-(void)upRightBtnAction:(UIButton*)sender{

    if (self.month < 12) {
        self.month += 1;
    }else {
        self.month = 1;
        self.year += 1;
    }
  self.topTimeLa.text =[NSString stringWithFormat:@"%ld年%ld月",(long)self.year,(long)self.month];
}




#pragma mark ---------------------tableViewdelegate----------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView ==self.timeTaView) {
        return 1;
    }else{
    
        return self.banciArray.count;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PROPORTION_HIGHT(45);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == self.timeTaView) {
        return self.timeDataArray.count;
    } else {
        PaibanheadeModel *sectionModel = self.sectionDataSources[section];
        
        return sectionModel.isExpanded ? sectionModel.cellModels.count : 0;

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.timeTaView) {
        return 0;
    }else{
        return PROPORTION_HIGHT(45);
    }

}
//删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.rightTabView) {
    //删除
    return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.rightTabView) {
    
        //删除
        
//        [self.rightDataArray[indexPath.section] removeObjectAtIndex:indexPath.row];
//   
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:indexPath.row];
    }
    
    
}

//headView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView ==self.rightTabView) {
        PaibanheadView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderIdentifier];
        
       PaibanheadeModel *sectionModel = self.sectionDataSources[section];
        view.model = sectionModel;
        view.expandCallback = ^(BOOL isExpanded) {
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:section]
                     withRowAnimation:UITableViewRowAnimationFade];
        };

//        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectPeopleTapAction:)];
//        [view.arrowImageView addGestureRecognizer:tap];
        [view.arrowImageView addTarget:self action:@selector(selectPeopleTapAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return view;
    }else{
        return nil;
    }
}
-(void)selectPeopleTapAction:(UIButton*)sender{
       BanciAddPeopleViewController* addPeopleVC=[[BanciAddPeopleViewController alloc]init];
    addPeopleVC.navigationItem.title = @"选择人员";
    [self.navigationController pushViewController:addPeopleVC animated:YES];


}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView ==self.timeTaView) {
       TimeTableViewCell*cell=[self.timeTaView dequeueReusableCellWithIdentifier:@"timeCell" ];
        //cell.backgroundColor=[UIColor redColor];
        //cell.timeLa.text = self.timeDataArray[indexPath.row];
       // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       // cell.detailTextLabel.text = @"去选择";
        self.timeTaView.tableFooterView=[[UIView alloc]init];
        //UIImage*image =[UIimageScaleImage scaleToSize:[UIImage imageNamed:@"home_paiban_time.png"] size:CGSizeMake(SCREEN_WIDTH/4, PROPORTION_HIGHT(30))];
      //self.timeCellImage =[UIImage imageNamed:@"home_paiban_time.png"];
     

        //cell.timeBgImage.hidden = YES;
         cell.timeLa.text=@"12月12日";
        cell.timeweekLa.text = @"周三";
        //self.timeTaView.backgroundColor=[UIColor clearColor];
       // cell.backgroundColor =[UIColor clearColor];
        return cell;

    } else {
        
       RightTableViewCell*cell=[self.rightTabView dequeueReusableCellWithIdentifier:@"rightCell"];
     
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        PaibanheadeModel *sectionModel = self.sectionDataSources[indexPath.section];
        PaiBanCellModel *cellModel = sectionModel.cellModels[indexPath.row];
        cell.peopleLa.text = cellModel.title;
       
        return cell;
    }
    
}
//delete people
-(void)deleteCellAction:(UIButton*)sender{

    sender.selected =!sender;
    NSIndexPath*index=[self.rightTabView indexPathForSelectedRow];
    
    if (sender.selected == YES) {
        //删除
        [self.rightDataArray[index.section] removeObjectAtIndex:index.row];
        [self.rightTabView  deleteRowsAtIndexPaths:@[index] withRowAnimation:(UITableViewRowAnimationTop)];
        [self.rightTabView reloadData];
    } else {
      
        
    }



}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
       if (tableView ==self.timeTaView) {
           TimeTableViewCell*cell =[self .timeTaView cellForRowAtIndexPath:indexPath];
           cell.selected =!cell.selected;
         if(cell.selected ==YES){
               cell.timeBgImage.image =[UIImage imageNamed:@"home_paiban_time.png"];
           }else{
               cell.timeBgImage.image =[UIImage imageNamed:@" "];
           }
           // add people data
         //  self.rightDataArray=(NSMutableArray*)@[@"张三",@"2",@"3",@"6"];
           [self.rightTabView reloadData];
    } else {
//        BanciAddPeopleViewController* addPeopleVC=[[BanciAddPeopleViewController alloc]init];
//        addPeopleVC.navigationItem.title = @"选择人员";
//        [self.navigationController pushViewController:addPeopleVC animated:YES];

    }
   


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
