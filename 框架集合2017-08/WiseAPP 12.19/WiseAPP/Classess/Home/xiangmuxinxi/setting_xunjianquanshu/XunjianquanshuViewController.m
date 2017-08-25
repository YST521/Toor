//
//  XunjianquanshuViewController.m
//  WiseAPP
//
//  Created by app on 16/10/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XunjianquanshuViewController.h"
#import "XunjianquanshuAddViewController.h"
#import "XunjianQuanshuModel.h"
#import "XujianquanshuFirstTableViewCell.h"
#import "XunjianquanshuShowViewController.h"

@interface XunjianquanshuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel* superLabel;
@property(nonatomic,strong)NSMutableArray*dataArray;

@property(nonatomic,strong)UITableView*  XunjianquanshuweiTabView;
@property(nonatomic,strong)UIView* footView;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)UIButton* addBtn;
@end
static NSString * quanshuAddCellID =@"quanshuAddCellID";
@implementation XunjianquanshuViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addData];
    [self creatTableView];
//    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];

    
}
//-(void)saveAction:(UIButton*)sender{
//    
//    NSLog(@"保存");
//    
//}

-(void)addData{
    self.dataArray=[NSMutableArray array];
   NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    NSDictionary*parm = @{@"projectid":ID};
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"inspectiondayList"] Token:self.tokenString parmpar:parm succeed:^(id data) {
        
        NSLog(@"巡检圈数%@",[data allValues]);
        
        for (NSDictionary*dic in data[@"resultMessage"]) {
            XunjianQuanshuModel*model=[[XunjianQuanshuModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        if (self.dataArray !=0) {
            self.headView.hidden = YES;
            self.headView.frame = CGRectMake(0, 0, 0, 0);
        }
       

    dispatch_async(dispatch_get_main_queue(), ^{
                [self.XunjianquanshuweiTabView reloadData];
        
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
    
    self.XunjianquanshuweiTabView.hidden = YES;
    self.view.backgroundColor= GlobBackGroundColor;
     self.XunjianquanshuweiTabView.backgroundColor = GlobBackGroundColor;
   self.XunjianquanshuweiTabView=[[UITableView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview: self.XunjianquanshuweiTabView];
    self.XunjianquanshuweiTabView.delegate = self;
    self.XunjianquanshuweiTabView.dataSource = self;
    [self.XunjianquanshuweiTabView registerClass:[XujianquanshuFirstTableViewCell class] forCellReuseIdentifier:quanshuAddCellID];
     self.XunjianquanshuweiTabView.tableFooterView = self.footView;
     self.XunjianquanshuweiTabView.tableHeaderView =self.headView;
    
    
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
         self.XunjianquanshuweiTabView.tableHeaderView =self.headView;
        self.headView.hidden = NO;
    }else{
        //self.tableview.tableHeaderView = [[UIView alloc]init];
        self.headView.hidden = YES;
    }
    
    [self.addBtn addTarget:self action:@selector(quanshuSettingAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
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
    UITapGestureRecognizer*tapRecognizer1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(quanshuSettingAction:)];
    //打开交互
    self.superLabel.userInteractionEnabled=YES;
    [ self.superLabel addGestureRecognizer:tapRecognizer1];
    self.superLabel.hidden = NO;
    
}

-(void)quanshuSettingAction:(id)sender
{
    XunjianquanshuAddViewController*addVC=[[XunjianquanshuAddViewController alloc]init];
    addVC.navigationItem.title = @"巡检圈数设置";
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
    XunjianQuanshuModel*model =self.dataArray[indexPath.row];
    [self deletequanShuRequestBanCiId:model.xunjianquanshuID];
    //删除
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:indexPath.row];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  XujianquanshuFirstTableViewCell*cell=[self.XunjianquanshuweiTabView  dequeueReusableCellWithIdentifier:quanshuAddCellID];
    XunjianQuanshuModel*model = self.dataArray[indexPath.row];
    
     cell.rightLa.text = [NSString stringWithFormat:@"%lu个巡检点",(unsigned long)model.info.count];
  cell.leftNumLa.text= [NSString stringWithFormat:@"第%ld圈",indexPath.row+1];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 XunjianQuanshuModel*model = self.dataArray[indexPath.row];
    XunjianquanshuShowViewController*showVC=[[XunjianquanshuShowViewController alloc]init];
    showVC.model =model;
    
    [self.navigationController pushViewController:showVC animated:YES];

}
//删除班次
-(void)deletequanShuRequestBanCiId:(int)banciId{
    
    NSMutableDictionary*param=[NSMutableDictionary dictionary];
    //   // [param setObject:@(1) forKey:@"Id"];
    [param setObject:@(banciId) forKey:@"id"];
    
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"inspectiondayDelete"] Token:self.tokenString parmpar:param succeed:^(id data) {
        NSLog(@"删除圈数---%@",data);
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
