//
//  XiangmugongshiViewController.m
//  WiseAPP
//
//  Created by app on 16/10/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XiangmugongshiViewController.h"
#import "ZongGongshiViewController.h"
#import "GerengongshiNewViewController.h"
#import "GRGSViewController.h"

@interface XiangmugongshiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*gongShiTabView;

@end
static NSString* gongshiCellId=@"gomngshiCellID";
@implementation XiangmugongshiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addView];
}
-(void)addView{
    self.gongShiTabView=[[UITableView alloc]initWithFrame:UIScreenBpunds style:(UITableViewStylePlain)];
    [self.view addSubview:self.gongShiTabView];
    
    self.gongShiTabView.dataSource =self;
    self.gongShiTabView.delegate = self;
    [self.gongShiTabView registerClass:[PublieTableViewCell class] forCellReuseIdentifier:gongshiCellId];

}

#pragma mark==========delggate====
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublieTableViewCell*cell=[self.gongShiTabView dequeueReusableCellWithIdentifier:gongshiCellId];
    if (indexPath.row==0) {
        cell.leftLa.text = @"项目总工时";
    }else{
     cell.leftLa.text = @"个人工时";
    
    }
    self.gongShiTabView.tableFooterView=[[UIView alloc]init];
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        ZongGongshiViewController*zongGongShiVC=[[ZongGongshiViewController alloc]init];
        zongGongShiVC.navigationItem.title =@"项目总工时设置";
        [self.navigationController pushViewController:zongGongShiVC animated:YES];
        
    }else if (indexPath.row == 1){
//        GerenGongshiViewController*geRenGongShiVC=[[GerenGongshiViewController alloc]init];
//       geRenGongShiVC.navigationItem.title = @"个人工时设置";
//        [self.navigationController pushViewController:geRenGongShiVC animated:YES];
       GerengongshiNewViewController*geRenGongShiVC=[[GerengongshiNewViewController alloc]init];
        geRenGongShiVC.navigationItem.title = @"个人工时设置";
        [self.navigationController pushViewController:geRenGongShiVC animated:YES];
//       GRGSViewController*geRenGongShiVC=[[GRGSViewController alloc]init];
//        geRenGongShiVC.navigationItem.title = @"个人工时设置";
//        [self.navigationController pushViewController:geRenGongShiVC animated:YES];
    
    }



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
