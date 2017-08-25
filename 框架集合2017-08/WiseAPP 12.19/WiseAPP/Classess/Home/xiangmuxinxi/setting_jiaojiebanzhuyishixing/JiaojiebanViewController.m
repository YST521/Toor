//
//  JiaojiebanViewController.m
//  WiseAPP
//
//  Created by app on 16/10/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "JiaojiebanViewController.h"
#import "JiaojiebanModel.h"
#import "JiaojiebanAddViewController.h"
#import "JiaojiebanShowViewController.h"

@interface JiaojiebanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel* superLabel;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)UITableView* jiaoJieBanTabView;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)UIView* footView;
@property(nonatomic,strong)UIButton* addBtn;

@property(nonatomic,strong)UILabel*label2;

@end
static NSString *jiaojiebanID=@"jiaojiebanID";
@implementation JiaojiebanViewController
//-(NSMutableArray *)dataArray{
//
//    if (_dataArray) {
//        _dataArray=[NSMutableArray array];
//    }
//    return _dataArray;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self addData];
    [self addview];
    
}
-(void)viewWillAppear:(BOOL)animated{
  [self addData];
    [self.jiaoJieBanTabView reloadData];

}
-(void)addData{
    
    self.dataArray=[NSMutableArray array];
        NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //账号密码
    [param setObject:ID forKey:@"projectid"];
    
    [RequestManger GetWithUrl:[ self urlRequestChildreurl:@"precautionList"] Token:self.tokenString parmpar:param succeed:^(id data) {
        for (NSDictionary*dic in data[@"resultMessage"]) {
                               JiaojiebanModel*model=[JiaojiebanModel new];
                                [model setValuesForKeysWithDictionary:dic];
                                [self.dataArray addObject:model];
            if (self.dataArray.count !=0) {
                self.headView.hidden = YES;
                self.headView.frame = CGRectMake(0, 0, 0, 0);
            }
            [self.jiaoJieBanTabView reloadData];
                                        }
        } failure:^(NSError *error) {
        
    }];
    
}

-(void)addview{

        [self creatTableView ];

    
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
    
     self.jiaoJieBanTabView.hidden = YES;
    self.view.backgroundColor= GlobBackGroundColor;
     self.jiaoJieBanTabView.backgroundColor = GlobBackGroundColor;
    self.jiaoJieBanTabView=[[UITableView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview: self.jiaoJieBanTabView];
    self.jiaoJieBanTabView.delegate = self;
     self.jiaoJieBanTabView.dataSource = self;
    [ self.jiaoJieBanTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:jiaojiebanID];
     self.jiaoJieBanTabView.tableFooterView = self.footView;
    [self.jiaoJieBanTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:jiaojiebanID];
    
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
        self.jiaoJieBanTabView.tableHeaderView =self.headView;
        self.headView.hidden = NO;
    }else{
        //self.tableview.tableHeaderView = [[UIView alloc]init];
        self.headView.hidden = YES;
    }
    
    [self.addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
-(void)addBtnAction:(UIButton*)sender{
    
    JiaojiebanAddViewController*addVC=[[JiaojiebanAddViewController alloc]init];
    addVC.navigationItem.title = @"交接班注意事项添加";
    [self.navigationController pushViewController:addVC animated:YES];
    
}

-(void)noDataPageLabel{
    
    //超链接label
    //添加手势的方法
    self.label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 40)];
    [self.headView addSubview:self.label2];
    self.label2.textAlignment = NSTextAlignmentCenter;
    //Using NSAttributed String
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"还没有任何信息,去添加信息!"];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 7)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(8,3)];
    
    self.label2.attributedText = str;
    UITapGestureRecognizer*tapRecognizer1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(yezhuSettingAction:)];
    //打开交互
    self.label2.userInteractionEnabled=YES;
    [self.label2 addGestureRecognizer:tapRecognizer1];
    self.label2.hidden = NO;
    
}
-(void)yezhuSettingAction:(id)sender

{
    JiaojiebanAddViewController*addVC=[[JiaojiebanAddViewController alloc]init];
    addVC.navigationItem.title = @"交接班注意事项添加";
    [self.navigationController pushViewController:addVC animated:YES];
    
}

#pragma MARK ----jiaojiebanDELEGATE-----
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
   JiaojiebanModel*model =self.dataArray[indexPath.row];
  [self delegateJiaojiebanNeedID:model.jiaojiebanID];
    //删除
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:indexPath.row];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PROPORTION_HIGHT(45);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[self.jiaoJieBanTabView dequeueReusableCellWithIdentifier:jiaojiebanID];

//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue2) reuseIdentifier:@"cell"];
//    }
    //显示最右边的箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //
    JiaojiebanModel*model=self.dataArray[indexPath.row];
    cell.textLabel.text = model.mattername;
    
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = textCententColor;
    cell.textLabel.textColor =  [UIColor blackColor];
    
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JiaojiebanModel*model=self.dataArray[indexPath.row];
    JiaojiebanShowViewController*jiaojiebanShowVC=[[JiaojiebanShowViewController alloc]init];
    jiaojiebanShowVC.model = model;

    [self.navigationController pushViewController:jiaojiebanShowVC animated:YES];
}
//删除后台数据
-(void)delegateJiaojiebanNeedID:(int)jiaojiebanId{
    
    
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    [dic setObject:@(jiaojiebanId) forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"precautionDelete"] Token:self.tokenString parmpar:dic succeed:^(id data) {
        
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
