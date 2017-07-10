//
//  NextViewController.m
//  DisplayLayout
//
//  Created by youxin on 2017/7/10.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

#import "NextViewController.h"
#import "NextTableViewCell.h"
#import "DataSupport.h"
#import "TestDataModel.h"

@interface NextViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tabview;
@property (nonatomic, strong) DataSupport *dataSupport;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self creatUI];
        [self createDataSupport];
    
}

- (void)createDataSupport {
    self.dataSupport = [[DataSupport alloc] init];
    __weak typeof (self) weak_self = self;
    [self.dataSupport setUpdataDataSourceBlock:^(NSMutableArray *dataSource) {
        weak_self.dataSource = dataSource;
        [weak_self.tabview reloadData];
    }];
    [self addTestData];
}

- (void)addTestData {
    [self.dataSupport addTestData];
}

- (void)creatUI{
    
    self.tabview =[[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.view addSubview:self.tabview];
    self.tabview.dataSource = self;
    self.tabview.delegate  = self;
    [self.tabview registerClass:[NextTableViewCell class] forCellReuseIdentifier:@"CELL"];
    


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //缓存cell行高
    if (indexPath.row < self.dataSource.count) {
        TestDataModel *model = self.dataSource[indexPath.row];
        return model.cellHeight;
    }
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NextTableViewCell *cell =[self.tabview dequeueReusableCellWithIdentifier:@"CELL"];
    
    [cell configCellData:self.dataSource[indexPath.row]];
    
    if (indexPath.row == self.dataSource.count - 30) {
        [self addTestData];
    }

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
