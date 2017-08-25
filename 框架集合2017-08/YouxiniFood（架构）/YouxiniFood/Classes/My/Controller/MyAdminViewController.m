//
//  MyAdminViewController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyAdminViewController.h"
#import "MyadminCell.h"

@interface MyAdminViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tabview;

@end

static NSString *myAdminCellid = @"myAdminCellid";
@implementation MyAdminViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
     self.navigationController.navigationBarHidden = NO;
    [self creatTabview];
}

- (void)creatTabview{
    self.tabview =[[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.view addSubview:self.tabview];
    
    self.tabview.dataSource = self;
    self.tabview.delegate = self;
    [self.tabview registerClass:[MyadminCell class] forCellReuseIdentifier:myAdminCellid];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyadminCell *cell =[self.tabview dequeueReusableCellWithIdentifier:myAdminCellid];
    
    self.tabview.tableFooterView=[[UIView alloc]init];
    
    if (indexPath.row == 0) {
        cell.textContentLa.text = @"银行卡管理";
        cell.leftIamageV.image =[UIImage imageNamed:@"icon_yinghangkaguangli"];
    }
    if (indexPath.row == 1) {
        cell.textContentLa.text = @"支付密码管理";
        cell.leftIamageV.image =[UIImage imageNamed:@"icon_zhifumimaguanli"];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
