//
//  XunjiandianweiViewController.m
//  WiseAPP
//
//  Created by app on 16/10/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XunjiandianweiViewController.h"
#import "XunjianDainweiAddViewController.h"
#import "XunjiandanModel.h"
#import "XunjiandianShowViewController.h"

@interface XunjiandianweiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel* superLabel;
@property(nonatomic,strong)NSMutableArray*dataArray;

@property(nonatomic,strong)UITableView*  XunjiandianweiTabView;
@property(nonatomic,strong)UIView* footView;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)UIButton* addBtn;
@end
static NSString* xunjianquanshuID =@"xunjianquanshuID";
@implementation XunjiandianweiViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self addData];
    [self creatTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [self addData];
      [self creatTableView];
   // [self.XunjiandianweiTabView reloadData];

}
-(void)addData{
    self.dataArray=nil;
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    NSDictionary*parm = @{@"projectid":ID};
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"inspectionpointsList"] Token:self.tokenString parmpar:parm succeed:^(id data) {
        
        for (NSArray*array in [data allValues]) {
            NSLog(@"报岗 %@",array);
        }
        for (NSDictionary*dic in data[@"resultMessage"]) {
            XunjiandanModel*model=[XunjiandanModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            if (self.dataArray.count!=0) {
                self.headView.hidden =YES;
                self.headView.frame =CGRectMake(0, 0, 0, 0);
            }
            [self.XunjiandianweiTabView reloadData];
     NSLog(@"hhhhhhh%lu",(unsigned long)self.dataArray.count);
            NSLog(@"MMMM%@",data[@"resultMessage"]);
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];

}
-(void)creatTableView{
    
    self.headView =[[UIView alloc]init];
    self.headView .frame = UIScreenBpunds;
    self.headView.backgroundColor= GlobBackGroundColor;
    self.headView.hidden = YES;
    //添加footview
    self.footView=[[UIView alloc]init];
    self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    self.footView.backgroundColor = GlobBackGroundColor;
    self.footView.hidden = NO;
    
    self.XunjiandianweiTabView.hidden = YES;
    self.view.backgroundColor= GlobBackGroundColor;
   self.XunjiandianweiTabView.backgroundColor = GlobBackGroundColor;
   self.XunjiandianweiTabView=[[UITableView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview: self.XunjiandianweiTabView];
    self.XunjiandianweiTabView.delegate = self;
  self.XunjiandianweiTabView.dataSource = self;
    [self.XunjiandianweiTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:xunjianquanshuID];
   self.XunjiandianweiTabView.tableFooterView = self.footView;
   self.XunjiandianweiTabView.tableHeaderView =self.headView;
    
    
    self.addBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.addBtn.frame = CGRectMake(0, 0, PROPORTION_WIDTH(60), PROPORTION_HIGHT(60));
    self.addBtn.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-100);
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"home_add.png"] forState:(UIControlStateNormal)];
    self.footView.hidden = YES;
    [self.view addSubview:self.addBtn];
    
    [self.addBtn addTarget:self action:@selector(linbaoSettingAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    if (self.dataArray.count ==0) {
        self.view.backgroundColor= GlobBackGroundColor;
        //第一次为空 提示添加
        [self  noDataPageLabel];
         self.XunjiandianweiTabView.tableHeaderView =self.headView;
        self.headView.hidden = NO;
    }else{
        //self.tableview.tableHeaderView = [[UIView alloc]init];
        self.headView.hidden = YES;
    }
    
    [self.addBtn addTarget:self action:@selector(linbaoSettingAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)noDataPageLabel{
    
    //超链接label
    //添加手势的方法
    self.superLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 40)];
    [self.headView addSubview:self.superLabel];
    self.superLabel.textAlignment = NSTextAlignmentCenter;
    //Using NSAttributed String
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"还没有任何信息,去添加信息!"];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 7)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(8,3)];
    
    self.superLabel.attributedText = str;
    UITapGestureRecognizer*tapRecognizer1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(linbaoSettingAction:)];
    //打开交互
    self.superLabel.userInteractionEnabled=YES;
    [ self.superLabel addGestureRecognizer:tapRecognizer1];
    self.superLabel.hidden = NO;
    
}

-(void)linbaoSettingAction:(id)sender

{
   XunjianDainweiAddViewController*addVC=[[ XunjianDainweiAddViewController alloc]init];
    addVC.navigationItem.title = @"临保设置";
    [self.navigationController pushViewController:addVC animated:YES];
    
}
#pragma mark -----------------tableviewdelegate------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.dataArray.count;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //删除
    return UITableViewCellEditingStyleDelete;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除后台数据
    XunjiandanModel*model =self.dataArray[indexPath.row];
    [self delegatexunjianDianweiNeedID:model.xunjiandianID];
    //删除
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:indexPath.row];
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[self.XunjiandianweiTabView  dequeueReusableCellWithIdentifier:xunjianquanshuID];
    XunjiandanModel*model =self.dataArray[indexPath.row];
    
    cell.textLabel.text = model.inspectionname;
   cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XunjiandanModel*model=self.dataArray[indexPath.row];
    XunjiandianShowViewController*xunjianShowVC=[[XunjiandianShowViewController alloc]init];
    xunjianShowVC.model =model;
    xunjianShowVC.navigationItem.title =@"巡检点位设置";
    [self.navigationController pushViewController:xunjianShowVC animated:YES];
}

//删除后台数据
-(void)delegatexunjianDianweiNeedID:(int)dianweiId{
    
    
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    [dic setObject:@(dianweiId) forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"inspectionpointsDelete"] Token:self.tokenString parmpar:dic succeed:^(id data) {
        NSLog(@"aaaaaa%@",[data allValues]);
        
    } failure:^(NSError *error) {
        
    }];
    
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

