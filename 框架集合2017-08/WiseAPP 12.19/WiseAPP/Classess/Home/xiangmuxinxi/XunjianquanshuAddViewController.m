//
//  XunjianquanshuAddViewController.m
//  WiseAPP
//
//  Created by app on 16/11/4.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XunjianquanshuAddViewController.h"
#import "XunjianquanshuTableViewCell.h"

@interface XunjianquanshuAddViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)UITableView* xunjianquanshuTabView;
@end
static NSString* xunjianquanshucellID=@"xunjianquanshucellID";
@implementation XunjianquanshuAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.title =@"选择巡检点";
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    [self addData];
    [self addView];
    
}
-(void)saveAction:(UIButton*)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)addData{
    self.dataArray=[NSMutableArray array];
    self.dataArray=(NSMutableArray*) @[@"11",@"22",@"33",@"55",@"66"];

}
-(void) addView{
   
    self.xunjianquanshuTabView=[[UITableView alloc]initWithFrame:UIScreenBpunds style:(UITableViewStylePlain)];
    [self.view addSubview:self.xunjianquanshuTabView];
    self.xunjianquanshuTabView.dataSource =self;
    self.xunjianquanshuTabView.delegate = self;
    [self.xunjianquanshuTabView registerClass:[XunjianquanshuTableViewCell class] forCellReuseIdentifier:xunjianquanshucellID];

}

#pragma mark ---------tableviewDelegate--------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XunjianquanshuTableViewCell*cell=[self.xunjianquanshuTabView dequeueReusableCellWithIdentifier:xunjianquanshucellID];
    
    self.xunjianquanshuTabView.tableFooterView=[[UIView alloc]init];

    return  cell;
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
