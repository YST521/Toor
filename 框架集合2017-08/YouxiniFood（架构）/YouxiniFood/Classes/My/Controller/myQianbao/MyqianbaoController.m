//
//  MyqianbaoController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyqianbaoController.h"
#import "QianbaoHeadView.h"
#import "MyqianbaoDetailController.h" //明细
#import "PayCardViewController.h"
#import "TixianViewController.h"

@interface MyqianbaoController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView  *qianbaoTabview;

@property(nonatomic,strong)QianbaoHeadView *headView;
@end

static NSString *QianbaoCellID = @"QianbaoCellID";
@implementation MyqianbaoController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNaItem];
    [self creatUI];
    
}

-(void)creatNaItem{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"明细" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightItemClickAction:)];

}

- (void)creatUI{
  
    self.qianbaoTabview =[[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.qianbaoTabview.backgroundColor = BgColor;
    [self.view addSubview:self.qianbaoTabview];
    
    self.qianbaoTabview.dataSource = self;
    self.qianbaoTabview.delegate = self;
    
    [self.qianbaoTabview registerClass:[UITableViewCell class]forCellReuseIdentifier:QianbaoCellID];
    
    self.headView =[[QianbaoHeadView alloc]init];
     self.headView.frame = CGRectMake(0, 0, SceneWidth, 160);
     self.headView.backgroundColor =[UIColor whiteColor];
    self.qianbaoTabview.tableHeaderView =  self.headView;
    
    self.qianbaoTabview.separatorStyle = UITableViewCellSelectionStyleNone;
 

}


#pragma mark -----------clickAction------------------

-(void)rightItemClickAction:(UIBarButtonItem*)sender{

    MyqianbaoDetailController *detailVC =[[MyqianbaoDetailController alloc]init];
   detailVC.title = @"钱包明细";
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark ---------------tabviewDelegate---------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[self.qianbaoTabview dequeueReusableCellWithIdentifier:QianbaoCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"充值";
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"提现";
    }
    
    cell.textLabel.textColor =[UIColor colorWithHexStringg:@"#333333"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.qianbaoTabview.tableFooterView =[[UIView alloc]init];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        PayCardViewController *chongZhiVC = [[PayCardViewController alloc]init];
        chongZhiVC.title = @"钱包充值";
        [self.navigationController pushViewController:chongZhiVC animated:YES];

      
    }
    
    if (indexPath.row == 1) {
        TixianViewController *TixianZhiVC = [[TixianViewController alloc]init];
        TixianZhiVC.title = @"验证支付密码";
        [self.navigationController pushViewController:TixianZhiVC animated:YES];
    }

}

-(void)turnUpPage{
    
    
    for (UIViewController*collector in self.navigationController.viewControllers) {
        if ([collector isKindOfClass:[PayCardViewController class]]) {
            PayCardViewController* messageVC =( PayCardViewController*)collector;
            [self.navigationController popToViewController:messageVC animated:YES];
        }
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
