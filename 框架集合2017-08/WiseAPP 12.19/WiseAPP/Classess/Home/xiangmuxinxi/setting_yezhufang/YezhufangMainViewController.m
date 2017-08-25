//
//  YezhufangMainViewController.m
//  WiseAPP
//
//  Created by app on 16/10/27.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "YezhufangMainViewController.h"
#import "YezhuMainTableViewCell.h"
#import "YezhufangViewController.h"
#import "YezhuShowMessageViewController.h"
#import "YezhuModel.h"
#import "YezhuEditorViewController.h"

@interface YezhufangMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel*label2;
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSMutableArray
*dataArray;
@property(nonatomic,strong)UIView* footView;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)UIButton* addBtn;
@property(nonatomic,strong)UIView* superlabelview;



@end

static NSString* yezhuMainCell =@"yezhuMainCell";
@implementation YezhufangMainViewController

//每次加载刷新赋值
-(void)viewWillAppear:(BOOL)animated{

    [self addData];
    [self.tableview reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= GlobBackGroundColor;
    
    

    
    [self creatTableView];
    
}


-(void)addData{
    
    self.dataArray=[NSMutableArray array];
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:ID forKey:@"projectsid"];
    
    [RequestManger GetWithUrl:[ self urlRequestChildreurl:@"ownerIndexList"] Token:self.tokenString parmpar:param succeed:^(id data) {
        for (NSDictionary*dic in data[@"resultMessage"]) {
            YezhuModel*model=[YezhuModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.dataArray.count !=0) {
                self.headView.hidden = YES;
                self.headView.frame = CGRectMake(0, 0, 0, 0);
            }
            
            [self.tableview reloadData];
            
        });
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
-(void)creatTableView{
    
    self.headView =[[UIView alloc]init];
    self.headView .frame = UIScreenBpunds;
    self.headView.backgroundColor= GlobBackGroundColor;
    //self.headView.backgroundColor=[UIColor redColor];
    self.headView.hidden = YES;
    //添加footview
    self.footView=[[UIView alloc]init];
    self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    self.footView.backgroundColor = GlobBackGroundColor;
    self.footView.hidden = NO;
    
    
    self.superlabelview.hidden = YES;
    self.view.backgroundColor= GlobBackGroundColor;
    self.tableview.backgroundColor = GlobBackGroundColor;
    self.tableview=[[UITableView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview:self.tableview];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[YezhuMainTableViewCell class] forCellReuseIdentifier:yezhuMainCell];
    self.tableview.tableFooterView = self.footView;
    
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
        self.tableview.tableHeaderView =self.headView;
        self.headView.hidden = NO;
    }else{
        //self.tableview.tableHeaderView = [[UIView alloc]init];
        self.headView.hidden = YES;
    }
    
    
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
//超链接跳转
-(void)yezhuSettingAction:(id)sender

{
   YezhuEditorViewController* yezhuVC =[[YezhuEditorViewController alloc]init];
    [self.navigationController pushViewController:yezhuVC animated:YES];
    
}
#pragma mark---------tabviewdelegate-------
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
    YezhuModel*model =self.dataArray[indexPath.row];
    [self delegateDataOwerId:model.yezhuID];
    //删除
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:indexPath.row];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  PROPORTION_HIGHT(80);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YezhuMainTableViewCell*cell =[self.tableview dequeueReusableCellWithIdentifier:yezhuMainCell];
    cell.leftLab.textColor =textCententColor;
    YezhuModel*model=self.dataArray[indexPath.row];
    if (self.dataArray.count !=0) {
        cell.leftLab.text = model.name;
        [cell.rightImage sd_setImageWithURL:[NSURL URLWithString:[self urlStringWithImageUrl:model.images]] placeholderImage:[UIImage imageNamed:@"home_head_image"]];
        //NSLog(@"%@", [self urlRequestChildreurl:model.images]);
    }else{
        NSLog(@"数据为空");
    }
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YezhuModel*model =self.dataArray[indexPath.row];
    //展示业主信息
    YezhuShowMessageViewController* showVC=
    [[YezhuShowMessageViewController alloc]init];
    showVC.model = model;
    showVC.navigationItem.title = @"业主信息";
    [self.navigationController pushViewController:showVC animated:YES];
}
//base64转image
-(UIImage*)baseToImageBString:(NSString*)baseString{
    
    if(baseString.length ==0 ){
        NSLog(@"数据为空");
    }
    NSData *decodedImageData = [[NSData alloc]
                                
                                initWithBase64EncodedString:baseString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    
    return decodedImage;
}
//删除后台数据
-(void)delegateDataOwerId:(int)ownerid{
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    [dic setObject:@(ownerid) forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"ownerDelete"] Token:self.tokenString parmpar:dic succeed:^(id data) {
        
        NSLog(@"%@--",data);
        for (NSArray*arry in [data allValues]) {
            NSLog(@"%@--%d",arry,ownerid);
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
