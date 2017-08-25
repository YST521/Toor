//
//  BaogangShowViewController.m
//  WiseAPP
//
//  Created by app on 16/11/25.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaogangShowViewController.h"
#import "BaogangshowTableViewCell.h"
#import "BangangModel.h"
#import "BaogangAddViewController.h"

@interface BaogangShowViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* baogangShowtabview;
@property(nonatomic,strong)NSArray* timeArray;
@property(nonatomic,strong)UIButton*  deleteBtn;
@property(nonatomic,strong)UIButton*  editorBtn;
@end
static NSString* baogangShowCellID= @"baogangShowCellID";
@implementation BaogangShowViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title =@"报岗设置";
    [self addData];
    [self addView];
}
-(void)addData{
    self.timeArray=[NSMutableArray array];

    //json转dataq
     NSData *jsonData = [self.model.reportingtime dataUsingEncoding:NSUTF8StringEncoding];
    //data转array
    self.timeArray =[self toArrayOrNSDictionary:jsonData];


}
- (void)addView{
    //tabview
    self.baogangShowtabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-PROPORTION_HIGHT(150)) style:(UITableViewStylePlain)];
    //self.baogangShowtabview.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:self.baogangShowtabview];
    self.baogangShowtabview.dataSource =self;
    self.baogangShowtabview.delegate =self;
    [self.baogangShowtabview registerClass:[BaogangshowTableViewCell class] forCellReuseIdentifier:baogangShowCellID];

    self.deleteBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.deleteBtn.frame =CGRectMake(10, SCREEN_HEIGHT-PROPORTION_HIGHT(120),SCREEN_WIDTH/2-PROPORTION_WIDTH(10), PROPORTION_HIGHT(45));
    [self.view addSubview:self.deleteBtn];
    KUIbutton(self.deleteBtn);
    KUIbuttonClick(self.deleteBtn);
    [self.deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    
    self.editorBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.editorBtn.frame =CGRectMake(CGRectGetMaxX(self.deleteBtn.frame)+10, SCREEN_HEIGHT-PROPORTION_HIGHT(120), SCREEN_WIDTH/2-PROPORTION_WIDTH(15), PROPORTION_HIGHT(45));
    self.editorBtn.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:self.editorBtn];
    KUIbutton(self.editorBtn);
    KUIbuttonClick(self.editorBtn);
    [self.editorBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
    
    [self.deleteBtn addTarget:self action:@selector(delegateAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.editorBtn addTarget:self action:@selector(editorAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)delegateAction:(UIButton*)sender{
    [self delegateBaogangNeedID:[NSString stringWithFormat:@"%d",self.model.baogangID]];
}
    
-(void)editorAction:(UIButton*)sender{
    BaogangAddViewController* addVC=[[BaogangAddViewController alloc]init];
    addVC.model =self.model;
    addVC.upPageType=1;
    [self.navigationController pushViewController:addVC animated:YES];

}

#pragma mark ------tabviewdelegate------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return PROPORTION_HIGHT(10);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 3;
    } else {
          return self.timeArray.count;
    }
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return PROPORTION_HIGHT(45);
    }else{
    return 0;
    }
    
}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView*view=[[UIView alloc]init];
    if (section ==1) {
        
        view.frame =CGRectMake(0, 0, SCREEN_WIDTH, PROPORTION_HIGHT(45));
        view.backgroundColor=[UIColor whiteColor];
        UILabel*la=[[UILabel alloc]init];
        la.frame=CGRectMake(10, 0, view.width-10, view.height);
        la.text =@"报岗时间";
        la.textColor=textCententColor;
        la.font=[UIFont systemFontOfSize:16];
                  [view addSubview:la];
        UIView*lineView=[[UIView alloc]init];
        lineView.backgroundColor=[UIColor lightGrayColor];
        lineView.frame=CGRectMake(0, view.height-0.5, SCREEN_WIDTH, 0.5);
        [view addSubview:lineView];
        
        return view;
    }else {
    view.frame =CGRectMake(0, 0, 0, 0);
    
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return PROPORTION_HIGHT(45);
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   BaogangshowTableViewCell*cell =[self.baogangShowtabview dequeueReusableCellWithIdentifier:baogangShowCellID];
    cell.leftLa.textColor=textCententColor;
    cell.rightLa.textColor=textColorPlace;
    if (indexPath.section==0) {
        //第一分区
        if (indexPath.row ==0) {
            cell.leftLa.text =@"选择岗位";
            cell.rightLa.text =self.model.postsetting[@"post"];
        }else if (indexPath.row ==1){
            cell.leftLa.text =@"报岗时间允许差值";
            cell.rightLa.text = self.model.jetlag;;
            
        }else if (indexPath.row ==2){
            
            cell.leftLa.text =@"选择班次";
            NSLog(@"QQ%@",self.model.postsetting);
            cell.rightLa.text = self.model.service[@"servicesname"];
        }

        
    } else {
        //第二分区
        if (indexPath.row ==0) {
            cell.leftLa.text =@"报岗时间";
            //cell.rightLa.text = self.model.jetlag;
            NSLog(@"%@",self.model.reportingtime);

        }
       
            cell.leftLa.text = self.timeArray[indexPath.row];
            

        
        
    }
    
    
    return cell;
}

//删除后台数据
-(void)delegateBaogangNeedID:(NSString*)gangweiId{
    
    
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    [dic setObject:@([gangweiId intValue]) forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"newspaperpostDelete"] Token:self.tokenString parmpar:dic succeed:^(id data) {
        NSLog(@"aaaaaa%@",[data allValues]);
        [self.navigationController popViewControllerAnimated:YES];
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
