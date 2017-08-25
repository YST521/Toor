//
//  MessageViewController.m
//  WiseAPP
//
//  Created by app on 16/10/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* MessageTabView;
@property(nonatomic,strong)NSMutableArray* dataArray;
@end

@implementation MessageViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(void)viewWillAppear:(BOOL)animated{
  [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];

}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"消息";
    [self addData];
    [self addView];
}
-(void)addData{
    
    
    
    
}
-(void)addView{
    
    self.MessageTabView =[[UITableView alloc]init];
    self.MessageTabView.frame = self.view.bounds;
    [self.view addSubview:self.MessageTabView];
    self.MessageTabView.dataSource=self;
    self.MessageTabView.delegate =self;
    [self.MessageTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[self.MessageTabView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    
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
