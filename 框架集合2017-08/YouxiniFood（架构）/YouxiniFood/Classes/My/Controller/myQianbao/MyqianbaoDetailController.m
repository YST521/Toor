//
//  MyqianbaoDetailController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyqianbaoDetailController.h"
#import "QianbaoDetailCell.h"

@interface MyqianbaoDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tabview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

static NSString *myQianbaoDetailCellID = @"qianbaoDetailCellID";
@implementation MyqianbaoDetailController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
}

- (void)creatUI{
    
    self.tabview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight - 59) style:(UITableViewStylePlain)];
    [self.view addSubview:self.tabview];
    
    self.tabview.dataSource = self;
    self.tabview.delegate  = self;
    
    [self.tabview registerClass:[QianbaoDetailCell class] forCellReuseIdentifier:myQianbaoDetailCellID];

    //cellheight
    self.tabview.rowHeight = 50;
    
}


#pragma mark ------------tabviewdelegate-------------------
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 50;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QianbaoDetailCell *cell =[self.tabview dequeueReusableCellWithIdentifier:myQianbaoDetailCellID];

    
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
