//
//  LinbaoViewController.m
//  WiseAPP
//
//  Created by app on 16/10/31.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "LinbaoViewController.h"
#import "LinBaoAddViewController.h"
#import "LinbaoModel.h"
#import "LinbaoShowViewController.h"

@interface LinbaoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel* superLabel;
@property(nonatomic,strong)NSMutableArray*dataArray;

@property(nonatomic,strong)UITableView* linBaoTabView;
@property(nonatomic,strong)UIView* footView;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)UIButton* addBtn;
@end
static NSString*linaocellID =@"linaocellID";
@implementation LinbaoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
 
    //[self addData];
    [self creatTableView];
}
//刷新数据
-(void)viewWillAppear:(BOOL)animated{
    [self addData];
    [self.linBaoTabView reloadData];

}
-(void)addData{
    self.dataArray=[NSMutableArray array];
    //self.dataArray= (NSMutableArray*)@[@"11",@"22"];
     NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //账号密码
    [param setObject:ID forKey:@"projectid"];

    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"proinsuranceList"] Token:self.tokenString parmpar:param succeed:^(id data) {
        for (NSDictionary*dic in data[@"resultMessage"]) {
                                LinbaoModel*model=[LinbaoModel new];
                                [model setValuesForKeysWithDictionary:dic];
                                [self.dataArray addObject:model];
            if (self.dataArray.count !=0) {
                self.headView.hidden = YES;
                 self.linBaoTabView.tableHeaderView = [[UIView alloc]init];
            }
                                [self.linBaoTabView reloadData];
            
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
    
    self.linBaoTabView.hidden = YES;
    self.view.backgroundColor= GlobBackGroundColor;
     self.linBaoTabView.backgroundColor = GlobBackGroundColor;
     self.linBaoTabView=[[UITableView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview:  self.linBaoTabView];
    self.linBaoTabView.delegate = self;
     self.linBaoTabView.dataSource = self;
    [ self.linBaoTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:linaocellID];
   self.linBaoTabView.tableFooterView = self.footView;
     self.linBaoTabView.tableHeaderView =self.headView;
    
    
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
        self.linBaoTabView.tableHeaderView =self.headView;
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
    LinBaoAddViewController*addVC=[[ LinBaoAddViewController alloc]init];
    addVC.navigationItem.title = @"临保设置";
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
    LinbaoModel*model =self.dataArray[indexPath.row];
    [self delegatelinbaoNeedID:model.id];
    //删除
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:indexPath.row];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return PROPORTION_HIGHT(45);
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[self.linBaoTabView  dequeueReusableCellWithIdentifier:linaocellID];
    cell.textLabel.textColor =textCententColor;
    LinbaoModel*model=self.dataArray[indexPath.row];
    cell.textLabel.text = model.projectname;
 cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//cell的右边有一个小箭头，距离右边有十几像素；  
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   LinbaoModel*model=self.dataArray[indexPath.row];
    LinbaoShowViewController*linbaoShowVC=[[LinbaoShowViewController alloc]init];
    linbaoShowVC.linbaoModel = model;
    linbaoShowVC.navigationItem.title = @"临保设置";
    [self.navigationController pushViewController:linbaoShowVC animated:YES];

}

//删除后台数据
-(void)delegatelinbaoNeedID:(int)linbaoId{
    
    
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    [dic setObject:@(linbaoId) forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"proinsuranceDelete"] Token:self.tokenString parmpar:dic succeed:^(id data) {
        NSLog(@"临保的查aaaaaa%@",[data allValues]);
        
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
