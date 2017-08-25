//
//  BanhuiSettingViewController.m
//  WiseAPP
//
//  Created by app on 16/10/28.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BanhuiSettingViewController.h"
#import "BanhuiAddViewController.h"
#import "BanhuiModel.h"
#import "BanhuiShowViewController.h"


@interface BanhuiSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel*superLabel;
@property(nonatomic,strong)UITableView* BanhuiAddtableView;
@property(nonatomic,strong)NSMutableArray
*dataArray;
@property(nonatomic,strong)UIView* footView;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)UIButton* addBtn;
@property(nonatomic,strong)BanhuiModel*model;
@end

static NSString* banhuicellID =@"banhuicellID";
@implementation BanhuiSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   // [self addData];
    [self creatTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [self addData];
    [self.BanhuiAddtableView reloadData];

}
-(void)addData{
    
    self.dataArray=[NSMutableArray array];

   NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:ID forKey:@"projectid"];
    
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"classmeetingList"] Token:self.tokenString parmpar:param succeed:^(id data) {
        NSLog(@"查看%@",data);
        for (NSDictionary*dic in data[@"resultMessage"]) {
            BanhuiModel*model=[BanhuiModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
     
            self.model =model;
   
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.dataArray.count !=0) {
                self.headView.hidden = YES;
                self.headView.frame = CGRectMake(0, 0, 0, 0);
            }
              [self.BanhuiAddtableView reloadData];
        });
        
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
    
    self.BanhuiAddtableView.hidden = YES;
    self.view.backgroundColor= GlobBackGroundColor;
     self.BanhuiAddtableView.backgroundColor = GlobBackGroundColor;
     self.BanhuiAddtableView=[[UITableView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview: self.BanhuiAddtableView];
     self.BanhuiAddtableView.delegate = self;
   self.BanhuiAddtableView.dataSource = self;
    [ self.BanhuiAddtableView registerClass:[UITableViewCell class] forCellReuseIdentifier:banhuicellID];
    self.BanhuiAddtableView.tableFooterView = self.footView;
     self.BanhuiAddtableView.tableHeaderView =self.headView;
    
    
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
         self.BanhuiAddtableView.tableHeaderView =self.headView;
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
    BanhuiAddViewController*addVC=[[BanhuiAddViewController alloc]init];
    addVC.navigationItem.title = @"班会设置";
    [self.navigationController pushViewController:addVC animated:YES];
    
}

#pragma mark------tabviewdelegate----

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.dataArray.count;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //删除
    return UITableViewCellEditingStyleDelete;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除后台数据
    BanhuiModel*model =self.dataArray[indexPath.row];

    [self delegatelinbaoNeedID:model.banhuiID];
    //删除
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:indexPath.row];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  PROPORTION_HIGHT(45);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   UITableViewCell*cell =[self.BanhuiAddtableView dequeueReusableCellWithIdentifier:banhuicellID];
  
    BanhuiModel*model=self.dataArray[indexPath.row];
    cell.textLabel.text = model.meetingplace;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   BanhuiShowViewController* banhuiShowVC =[[BanhuiShowViewController alloc]init];
    banhuiShowVC.navigationItem.title = @"班会设置";
    BanhuiModel*model=self.dataArray[indexPath.row];
     banhuiShowVC.model =model;
    [self.navigationController pushViewController:banhuiShowVC animated:YES];
    
}


//删除后台数据
-(void)delegatelinbaoNeedID:(int)linbaoId{
    
    NSLog(@"MMMM%d",linbaoId);
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    [dic setObject:@(linbaoId) forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"classmeetingDelete"] Token:self.tokenString parmpar:dic succeed:^(id data) {
        NSLog(@"班会的查aaaaaa%@",data );
        for (NSArray*array in data) {
         NSLog(@"aaaaaa%@",array);
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
