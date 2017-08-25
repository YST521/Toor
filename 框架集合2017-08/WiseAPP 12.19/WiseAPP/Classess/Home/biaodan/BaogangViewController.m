//
//  BaogangViewController.m
//  WiseAPP
//
//  Created by app on 16/10/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaogangViewController.h"
#import "BaogangAddViewController.h"
#import "BangangModel.h"
#import "BaogangShowViewController.h"

@interface BaogangViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)UITableView* baogangTabView;
@property(nonatomic,strong)UIView * footView;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)UILabel* superLabel;
@property(nonatomic,strong)UIButton* addBtn;

@end
static NSString*baogangAddCellID=@"baogangAddCellID";
@implementation BaogangViewController

-(void)viewWillAppear:(BOOL)animated{
    [self addData];
    [self.baogangTabView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"报岗设置";
//    [self addData];
    [self creatTableView];
}
-(void)addData{
    self.dataArray=[NSMutableArray array];

    NSDictionary*parm = @{@"projectid":@"1"};
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"newspaperpostList"] Token:self.tokenString parmpar:parm succeed:^(id data) {
        
        for (NSArray*array in [data allValues]) {
            NSLog(@"报岗 %@",array);
        }
        for (NSDictionary*dic in data[@"resultMessage"]) {
            BangangModel*model=[BangangModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            if (self.dataArray.count!=0) {
                self.headView.hidden =YES;
                self.headView.frame =CGRectMake(0, 0, 0, 0);
            }
            
            [self.baogangTabView reloadData];
            NSLog(@"报岗数据%@",data[@"resultMessage"]);
            
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
    
    self.baogangTabView.hidden = YES;
    self.view.backgroundColor= GlobBackGroundColor;
    self.baogangTabView.backgroundColor = GlobBackGroundColor;
 self.baogangTabView=[[UITableView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview: self.baogangTabView];
   self.baogangTabView.delegate = self;
  self.baogangTabView.dataSource = self;
    [ self.baogangTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:baogangAddCellID];
  self.baogangTabView.tableFooterView = self.footView;
self.baogangTabView.tableHeaderView =self.headView;
    
    
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
        self.baogangTabView.tableHeaderView =self.headView;
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
    BaogangAddViewController*addVC=[[BaogangAddViewController alloc]init];
    addVC.navigationItem.title = @"临保设置";
    [self.navigationController pushViewController:addVC animated:YES];
    
}
#pragma mark -----tableviewDelegate -----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSLog(@"BBBAAAA%lu",(unsigned long)self.dataArray.count);
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
    BangangModel*model =self.dataArray[indexPath.row];
    [self delegateBaogangNeedID:model.baogangID];
    
    NSLog(@"***********%d",model.baogangID);
    //删除
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:indexPath.row];
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell*cell=[self.baogangTabView dequeueReusableCellWithIdentifier:baogangAddCellID];
    BangangModel*model=self.dataArray[indexPath.row];
    cell.textLabel.text = model.postsetting[@"post"];
    cell.textLabel.textColor=textCententColor;
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BangangModel*model=self.dataArray[indexPath.row];

    BaogangShowViewController* baogangshowVC=[[BaogangShowViewController alloc]init];
    baogangshowVC.model =model;
    [self.navigationController pushViewController:baogangshowVC animated:YES];
}

//删除后台数据
-(void)delegateBaogangNeedID:(int)gangweiId{
    
        NSLog(@"***********%d",gangweiId);
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    [dic setObject:@(gangweiId) forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"newspaperpostDelete"] Token:self.tokenString parmpar:dic succeed:^(id data) {
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
