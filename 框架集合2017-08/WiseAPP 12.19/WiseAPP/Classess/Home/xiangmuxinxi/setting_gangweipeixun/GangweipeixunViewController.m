//
//  GangweipeixunViewController.m
//  WiseAPP
//
//  Created by app on 16/10/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "GangweipeixunViewController.h"
#import "GangweiAddViewController.h"
#import "GangweiModel.h"
#import "GangweiShowViewController.h"

@interface GangweipeixunViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)UITableView* peiXunTableView;
@property(nonatomic,strong)UIView* footView;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)UILabel* superLabel;
@property(nonatomic,strong)UIButton* addBtn;

@end
static NSString* gangweicellID =@"gangweicellID";
@implementation GangweipeixunViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   // [self addData];
    [self creatTableView];
}
//刷新数据
-(void)viewWillAppear:(BOOL)animated{
    [self addData];
    [self.peiXunTableView reloadData];
    
}
-(void)addData{
    self.dataArray=[NSMutableArray array];

    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    NSMutableDictionary*parmpar =[NSMutableDictionary dictionary];
    [parmpar setObject:ID forKey:@"projectid"];
    
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"jobtrainingList"] Token:self.tokenString parmpar:parmpar succeed:^(id data) {
        
        for (NSDictionary*dic in data[@"resultMessage"]) {
                    GangweiModel*model=[GangweiModel new];
                        [model setValuesForKeysWithDictionary:dic];
                        [self.dataArray addObject:model];
            if (self.dataArray.count !=0) {
                self.headView.hidden = YES;
                self.headView.frame = CGRectMake(0, 0, 0, 0);
            }
               [self.peiXunTableView reloadData];
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
    
    self.peiXunTableView.hidden = YES;
    self.view.backgroundColor= GlobBackGroundColor;
    self.peiXunTableView.backgroundColor = GlobBackGroundColor;
  self.peiXunTableView=[[UITableView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview: self.peiXunTableView];
    self.peiXunTableView.delegate = self;
    self.peiXunTableView.dataSource = self;
    [self.peiXunTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:gangweicellID];
   self.peiXunTableView.tableFooterView = self.footView;
    self.peiXunTableView.tableHeaderView =self.headView;
 
    
    self.addBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.addBtn.frame = CGRectMake(0, 0, PROPORTION_WIDTH(60), PROPORTION_HIGHT(60));
    self.addBtn.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-100);
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"home_add.png"] forState:(UIControlStateNormal)];
    self.footView.hidden = YES;
    [self.view addSubview:self.addBtn];
    
    [self.addBtn addTarget:self action:@selector(yezhuSettingAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    if (self.dataArray.count ==0) {
        self.view.backgroundColor= GlobBackGroundColor;
        //第一次为空 提示添加
        [self  noDataPageLabel];
        self.peiXunTableView.tableHeaderView =self.headView;
        self.headView.hidden = NO;
    }else{
        //self.tableview.tableHeaderView = [[UIView alloc]init];
        self.headView.hidden = YES;
    }
    
    [self.addBtn addTarget:self action:@selector(yezhuSettingAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
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
    UITapGestureRecognizer*tapRecognizer1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(yezhuSettingAction:)];
    //打开交互
    self.superLabel.userInteractionEnabled=YES;
    [ self.superLabel addGestureRecognizer:tapRecognizer1];
     self.superLabel.hidden = NO;
    
}

-(void)yezhuSettingAction:(id)sender

{
    GangweiAddViewController*addVC=[[GangweiAddViewController alloc]init];
    addVC.navigationItem.title = @"岗位培训设置";
    [self.navigationController pushViewController:addVC animated:YES];
    
}
#pragma mark -----------------tableviewdelegate------------
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
   GangweiModel*model =self.dataArray[indexPath.row];
    [self delegateJiaojiebanNeedID:model.gangweipeixunID];
    //删除
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:indexPath.row];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[self.peiXunTableView  dequeueReusableCellWithIdentifier:gangweicellID];
    GangweiModel*model =self.dataArray[indexPath.row];
    cell.textLabel.text =model.trainingname;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GangweiModel*model=self.dataArray[indexPath.row];
    GangweiShowViewController* gangweiVC=[[GangweiShowViewController alloc]init];
    gangweiVC.model =model;
    gangweiVC.navigationItem.title =@"岗位培训设置";
    [self.navigationController pushViewController:gangweiVC animated:YES];
}
//删除后台数据
-(void)delegateJiaojiebanNeedID:(int)gangweiid{
    NSLog(@"%d",gangweiid);
    NSString*strid=[NSString stringWithFormat:@"%d",gangweiid];
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    [dic setObject:strid forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"jobtrainingDelete"] Token:self.tokenString parmpar:@{@"id":@(gangweiid)} succeed:^(id data) {
        
        for (NSArray*arrray in [data allValues]) {
            NSLog(@"hhh%@",arrray);
        }
        
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
