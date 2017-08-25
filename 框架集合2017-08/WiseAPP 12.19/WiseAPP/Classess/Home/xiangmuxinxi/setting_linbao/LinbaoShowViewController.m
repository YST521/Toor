//
//  LinbaoShowViewController.m
//  WiseAPP
//
//  Created by app on 16/11/21.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "LinbaoShowViewController.h"
#import "LinbaoShowTableViewCell.h"
#import "LinbaoModel.h"
#import "LinBaoAddViewController.h"
#import "LinbaoViewController.h"

@interface LinbaoShowViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong)UITableView* linbaoShowTabview;
@property(nonatomic,strong)NSMutableArray* dataArray;
//@property(nonatomic,strong)UIView* footView;
@property(nonatomic,strong)UIButton* linbaoDeBtn;
@property(nonatomic,strong)UIButton* linbaoEdBtn;
@property(nonatomic,strong)UICollectionView*collectionView;
@property(nonatomic,strong)UIScrollView *scrollview;
@end

static NSString* linbaoshoeId = @"linbaoshoeCellID";
@implementation LinbaoShowViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(UITableView *)linbaoShowTabview{
    if (!_linbaoShowTabview) {
        _linbaoShowTabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:(UITableViewStylePlain)];
        
    }
    
    return _linbaoShowTabview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=GlobBackGroundColor;
 
    [self addView];
    
}

-(void)addView{
//    self.scrollview=[[UIScrollView alloc]initWithFrame:UIScreenBpunds];
//    [self.view addSubview:self.scrollview];
//    self.scrollview.showsHorizontalScrollIndicator=NO;
//    self.scrollview.contentSize =CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+PROPORTION_HIGHT(150));
    [self.view addSubview:self.linbaoShowTabview];
    self.linbaoShowTabview.dataSource =self;
    self.linbaoShowTabview.delegate =self;
    
    [self.linbaoShowTabview registerClass:[LinbaoShowTableViewCell class] forCellReuseIdentifier:linbaoshoeId];
   self.linbaoShowTabview.backgroundColor=GlobBackGroundColor;

    self.linbaoDeBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.linbaoDeBtn.frame =CGRectMake(PROPORTION_WIDTH(15), SCREEN_HEIGHT-PROPORTION_HIGHT(155),SCREEN_WIDTH/2-PROPORTION_WIDTH(20), PROPORTION_HIGHT(45));
    self.linbaoDeBtn.backgroundColor=[UIColor blueColor];
    [self.view addSubview:self.linbaoDeBtn];
    KUIbutton(self.linbaoDeBtn);
    KUIbuttonClick(self.linbaoDeBtn);
    [self.linbaoDeBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    
    
    self.linbaoEdBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.linbaoEdBtn.frame =CGRectMake(SCREEN_WIDTH/2+PROPORTION_WIDTH(5), SCREEN_HEIGHT-PROPORTION_HIGHT(155),SCREEN_WIDTH/2-PROPORTION_WIDTH(15), STANDARD_HEIGHT);
    self.linbaoEdBtn.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:self.linbaoEdBtn];
    KUIbutton(self.linbaoEdBtn);
    KUIbuttonClick(self.linbaoEdBtn);
    [self.linbaoEdBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
    
   
     [self.linbaoDeBtn addTarget:self action:@selector(deleteAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.linbaoEdBtn addTarget:self action:@selector(editorAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
//删除
-(void)deleteAction:(UIButton*)sender{
 

    [self delegatelinbaoNeedID:self.linbaoModel.id];
}
//编辑
-(void)editorAction:(UIButton*)sender{
 
    LinBaoAddViewController*linbaoAddVC=[[LinBaoAddViewController alloc]init];
    linbaoAddVC.model =self.linbaoModel;
    linbaoAddVC.pageType =1;
    [self.navigationController pushViewController:linbaoAddVC animated:YES];

}



//删除后台数据
-(void)delegatelinbaoNeedID:(int)linbaoId{
    
    
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    [dic setObject:@(linbaoId) forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"proinsuranceDelete"] Token:self.tokenString parmpar:dic succeed:^(id data) {
       
        [self turnUpPage];
        
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)turnUpPage{
    for (UIViewController*collector in self.navigationController.viewControllers) {
        if ([collector isKindOfClass:[LinbaoViewController class]]) {
            LinbaoViewController*linbaoVC =(LinbaoViewController*)collector;
            [self.navigationController popToViewController:linbaoVC animated:YES];
        }
    }
}


#pragma mark ---tabviewdelegate-------
#pragma mark ---tabviewdelegate-------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        
        
        return PROPORTION_HIGHT(150);
        
    }
    
    return PROPORTION_HIGHT(45);
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LinbaoShowTableViewCell*cell=[self.linbaoShowTabview dequeueReusableCellWithIdentifier:linbaoshoeId];
    if (indexPath.row ==0) {
        cell.leftLa.text = @"活动名称";
        cell.rightLa.text = self.linbaoModel.projectname;
    }else if (indexPath.row ==1){
        cell.leftLa.text = @"活动地点";
        cell.rightLa.text = self.linbaoModel.address;
        
    }else if (indexPath.row==2){
        cell.leftLa.text = @"任务执行人";
        cell.rightLa.text = self.linbaoModel.projectleader;
        
    }else if (indexPath.row==3){
        cell.leftLa.text = @"临保人数";
        cell.rightLa.text = [NSString stringWithFormat:@"%@",self.linbaoModel.number];
        
    }else if (indexPath.row==4){
        cell.leftLa.text = @"电话号码";
        cell.rightLa.text = self.linbaoModel.phone;
        
    }else if (indexPath.row==5){
        cell.rightLa.text = [NSString stringWithFormat:@"%@-%@",self.linbaoModel.startingtime,self.linbaoModel.endtime];
        cell.leftLa.text = @"活动时间";
        cell.rightLa.adjustsFontSizeToFitWidth =YES;
        
    }else{
        cell.rightLa.height = PROPORTION_HIGHT(150);
        cell.leftLa.text = @"培训内容";
        cell.rightLa.text = self.linbaoModel.des;
        NSLog(@"kkkkkk%@",self.linbaoModel.des);
        cell.rightLa.textAlignment = NSTextAlignmentCenter;
    }
    //[cell setDataWithModel:self.linbaoModel];
    
    
    return cell;
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
