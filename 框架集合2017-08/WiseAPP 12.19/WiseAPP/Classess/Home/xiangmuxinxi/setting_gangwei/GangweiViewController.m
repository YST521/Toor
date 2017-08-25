//
//  GangweiViewController.m
//  WiseAPP
//
//  Created by app on 16/10/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "GangweiViewController.h"
#import "GangweiSetAddViewController.h"
#import "GangweiSetModel.h"
#import "GangweiSetShowViewController.h"

@interface GangweiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* gangweiStTableView;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)UIView* footView;

@property(nonatomic,strong)UILabel* superLabel;
@property(nonatomic,strong)UIButton* addBtn;
@property(nonatomic,strong)UIView* headView;

@end
static NSString*gangweiSettCellID=@"gangweiCellID";
@implementation GangweiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor whiteColor];
   // [self addData];
    [self creatTableView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self addData];
    [self creatTableView];
    [self.gangweiStTableView reloadData];
}
-(void)addData{
   
   self.dataArray=[NSMutableArray array];
        NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    NSDictionary*parm = @{@"projectid":ID};
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"postList"] Token:self.tokenString parmpar:parm succeed:^(id data) {
        for (NSDictionary*dic in data[@"resultMessage"]) {
            GangweiSetModel*model=[GangweiSetModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            
            if (self.dataArray.count !=0) {
                self.headView.hidden = YES;
                self.headView.frame=CGRectMake(0, 0, 0, 0);
            }
            
        }

        for (NSArray*array in [data allValues]) {
            NSLog(@"岗位************** %@",array);
        }
        [self.gangweiStTableView reloadData];

        
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
    
    self.gangweiStTableView.hidden = YES;
    self.view.backgroundColor= GlobBackGroundColor;
      self.gangweiStTableView.backgroundColor = GlobBackGroundColor;
      self.gangweiStTableView=[[UITableView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview:  self.gangweiStTableView];
      self.gangweiStTableView.delegate = self;
      self.gangweiStTableView.dataSource = self;
    [  self.gangweiStTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:gangweiSettCellID];
   self.gangweiStTableView.tableFooterView = self.footView;
    self.gangweiStTableView.tableHeaderView =self.headView;
    
    
    self.addBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.addBtn.frame = CGRectMake(0, 0, PROPORTION_WIDTH(60), PROPORTION_HIGHT(60));
    self.addBtn.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-100);
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"home_add.png"] forState:(UIControlStateNormal)];
    self.footView.hidden = YES;
    [self.view addSubview:self.addBtn];
    
    if (self.dataArray.count ==0) {
        self.view.backgroundColor= GlobBackGroundColor;
        //第一次为空 提示添加
        [self  noDataPageLabel];
        self.gangweiStTableView.tableHeaderView =self.headView;
        self.headView.hidden = NO;
    }else{
        //self.tableview.tableHeaderView = [[UIView alloc]init];
        self.headView.hidden = YES;
    }
    
    [self.addBtn addTarget:self action:@selector(baogangSettingAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
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
    UITapGestureRecognizer*tapRecognizer1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baogangSettingAction:)];
    //打开交互
    self.superLabel.userInteractionEnabled=YES;
    [ self.superLabel addGestureRecognizer:tapRecognizer1];
    self.superLabel.hidden = NO;
    
}

-(void)baogangSettingAction:(id)sender

{
   GangweiSetAddViewController*addVC=[[GangweiSetAddViewController alloc]init];
    addVC.navigationItem.title = @"报岗设置";
    [self.navigationController pushViewController:addVC animated:YES];
    
}



#pragma mark -----------tableView----

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
   GangweiSetModel*model =self.dataArray[indexPath.row];
    [self delegateGangweiNeedID:model.gangweiID];
    //删除
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:indexPath.row];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[self.gangweiStTableView dequeueReusableCellWithIdentifier:gangweiSettCellID];
    GangweiSetModel*model=self.dataArray[indexPath.row];
    
//cell.textLabel.text = [NSString stringWithFormat:@"%d",model.id];
    cell.textLabel.text = model.post;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     GangweiSetModel*model=self.dataArray[indexPath.row];
  GangweiSetShowViewController*showVC=[[GangweiSetShowViewController alloc]init];
   showVC.navigationItem.title =@"岗位设置";
    showVC.model =model;
    
    [self.navigationController pushViewController:showVC animated:YES];
}

//删除后台数据
-(void)delegateGangweiNeedID:(int)gangweiId{
    
    
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    [dic setObject:@(gangweiId) forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"postDelete"] Token:self.tokenString parmpar:dic succeed:^(id data) {
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
