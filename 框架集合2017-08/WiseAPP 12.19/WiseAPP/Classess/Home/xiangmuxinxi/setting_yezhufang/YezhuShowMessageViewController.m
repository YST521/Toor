//
//  YezhuShowMessageViewController.m
//  WiseAPP
//
//  Created by app on 16/11/17.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "YezhuShowMessageViewController.h"
#import "YezhushowTableViewCell.h"
#import "YezhuModel.h"
#import "YezhufangViewController.h"
#import "YezhuEditorViewController.h"


@interface YezhuShowMessageViewController()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView*yezhushowTabview;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)UIView* footView;
@property(nonatomic,strong)UIButton* yezhhuDeleteBtn;
@property(nonatomic,strong)UIButton* yezhuEditorBtn;
@property(nonatomic,assign)CGRect frame;
@property(nonatomic,strong)UIImageView* headimageV;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)UILabel* headla;


@end
static NSString* yezhhuShowID = @"yezhushowCell";
@implementation YezhuShowMessageViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(UITableView *)yezhushowTabview{
    if (!_yezhushowTabview) {
        _yezhushowTabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:(UITableViewStylePlain)];
        
    }

    return _yezhushowTabview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=GlobBackGroundColor;
    [self addView];
    
}

-(void)addView{
    self.headView=[[UIView alloc]init];
    self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, PROPORTION_HIGHT(80));
    
    self.headla =[[UILabel alloc]init];
    self.headla.frame =CGRectMake(10, PROPORTION_HIGHT(30), PROPORTION_WIDTH(150), PROPORTION_HIGHT(20));
    self.headimageV =[[UIImageView alloc]init];
    self.headimageV.frame = CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(70), PROPORTION_HIGHT(10), PROPORTION_WIDTH(60), PROPORTION_HIGHT(60));
    self.headimageV.layer.cornerRadius =self.headimageV.width/2;
    self.headimageV.layer.masksToBounds = YES;
    
    [self.headView addSubview:self.headimageV];
    [self.headView addSubview:self.headla];
      [self.headimageV sd_setImageWithURL:[NSURL URLWithString:[self urlStringWithImageUrl:self.model.images]] placeholderImage:[UIImage imageNamed:@"home_head_image"]];
    self.headla.text = @"业主方头像";
    
    self.footView =[[UIView alloc]init];
    self.footView.frame =CGRectMake(0, 0, SCREEN_WIDTH, 250);
    self.footView.backgroundColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    self.yezhhuDeleteBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    //self.footView.backgroundColor=[UIColor redColor];
   
    [self.view addSubview:self.yezhushowTabview];
    self.yezhushowTabview.dataSource =self;
    self.yezhushowTabview.delegate =self;
    self.yezhushowTabview.tableFooterView =self.footView;
    self.yezhushowTabview.tableHeaderView = self.headView;
    
    [self.yezhushowTabview registerClass:[YezhushowTableViewCell class] forCellReuseIdentifier:yezhhuShowID];
    self.yezhhuDeleteBtn.frame =CGRectMake(10, PROPORTION_HIGHT(30),SCREEN_WIDTH/2-PROPORTION_WIDTH(20), STANDARD_HEIGHT);
    [self.footView addSubview:self.yezhhuDeleteBtn];
    KUIbutton(self.yezhhuDeleteBtn);
    KUIbuttonClick(self.yezhhuDeleteBtn);
    [self.yezhhuDeleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];

    self.yezhuEditorBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.yezhuEditorBtn.frame =CGRectMake(CGRectGetMaxX(self.yezhhuDeleteBtn.frame)+10, PROPORTION_HIGHT(30),SCREEN_WIDTH/2-PROPORTION_WIDTH(20), STANDARD_HEIGHT);
    self.yezhuEditorBtn.backgroundColor=[UIColor cyanColor];
    [self.footView addSubview:self.yezhuEditorBtn];
    KUIbutton(self.yezhuEditorBtn);
    KUIbuttonClick(self.yezhuEditorBtn);
    [self.yezhuEditorBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
    [self.yezhhuDeleteBtn addTarget:self action:@selector(delegateBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.yezhuEditorBtn addTarget:self action:@selector(editorBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)delegateBtnAction:(UIButton*)sender{

    [self delegateDataOwerId];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)editorBtnAction:(UIButton*)sender{
    
    YezhufangViewController*yezhuaddVC=[[YezhufangViewController alloc]init];
    yezhuaddVC.model =self.model;
    yezhuaddVC.nextPageType = 1;
    [self.navigationController pushViewController:yezhuaddVC animated:YES];
//    YezhuEditorViewController*yezhuaddVC=[[ YezhuEditorViewController alloc]init];
//    yezhuaddVC.model =self.model;
//    yezhuaddVC.nextPageType = 1;
//    [self.navigationController pushViewController:yezhuaddVC animated:YES];

    
    
}

#pragma mark ---tabviewdelegate-------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    return PROPORTION_HIGHT(45);

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YezhushowTableViewCell*cell=[self.yezhushowTabview dequeueReusableCellWithIdentifier:yezhhuShowID];
    [cell getValueModel:self.model cellIndex:indexPath];
    //
    return cell;
}

//删除后台数据
-(void)delegateDataOwerId{
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    [dic setObject:@(self.model.yezhuID) forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"ownerDelete"] Token:self.tokenString parmpar:dic succeed:^(id data) {
        
        NSLog(@"%@--",data);
        for (NSArray*arry in [data allValues]) {
            NSLog(@"%@--",arry);
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
