//
//  LeftViewController.m
//  MyTeamApp
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView*tabelview;
@end
static NSString*cellID=@"leftCell";
@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    
    
    [self addView];
    
}

-(void)addView{
    
    self.tabelview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-49)];
    [self.view addSubview:self.tabelview];
    
    self.tabelview.dataSource=self;
    self.tabelview.delegate=self;
    
    [self.tabelview registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.tabelview.frame.size.width, 80)];
    view.backgroundColor=[UIColor blackColor];
    [self.view addSubview:view];
    self.tabelview.tableHeaderView=view;

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 30;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];

cell.textLabel.text =@"111111";

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
