//
//  MyfuliquanController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyfuliquanController.h"
#import "FuliquanCell.h"

@interface MyfuliquanController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *addressTabview;
@property(nonatomic,strong)UILabel     *cellTilteLa;

@end

static NSString * fuliquanCellID = @"fuliquanCellID";
@implementation MyfuliquanController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BgColor;
    
   
    [self creatUI];
}




-(void)creatUI{
    
    self.addressTabview =[[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.view addSubview:self.addressTabview];
    
    self.addressTabview.dataSource = self;
    self.addressTabview.delegate   =  self;
    self.addressTabview.backgroundColor =[UIColor groupTableViewBackgroundColor ];
    [self.addressTabview registerClass:[FuliquanCell class] forCellReuseIdentifier:fuliquanCellID];
    self.addressTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark ---------------ClickAction-----------------

- (void)rightBarItemAction:(UIBarButtonItem*)sender{
    
    
}

#pragma mark --------------tabvireDelegate--------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FuliquanCell *cell =[self.addressTabview dequeueReusableCellWithIdentifier:fuliquanCellID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *cellHeadView =[[UIView alloc]init];
    cellHeadView.frame = CGRectMake(0, 0, SceneWidth, 40);
    cellHeadView.backgroundColor = BgColor;
    
    UIView *suqareView =[[UIView alloc]init];
    suqareView.frame = CGRectMake(0, 0, 18, 13);
    suqareView.center = CGPointMake(20+9, cellHeadView.frame.size.height/2);
    suqareView.backgroundColor = SquareColorGray;
    suqareView.layer.cornerRadius = 3;
    suqareView.clipsToBounds = YES;
    [cellHeadView addSubview:suqareView];
    
    self.cellTilteLa =[[UILabel alloc]init];
    self.cellTilteLa.frame = CGRectMake(CGRectGetMaxX(suqareView.frame)+10, 10, SceneWidth/2, 20);
    self.cellTilteLa.textColor =[UIColor colorWithHexStringg:@"#333333"];
    self.cellTilteLa.font =[UIFont systemFontOfSize:14];
    [cellHeadView addSubview:self.cellTilteLa];
    
    if (section == 0) {
         self.cellTilteLa.text = @"可用优惠券 （10张）";
    }
    if (section == 1) {
       self.cellTilteLa.text = @"过期优惠券 （10张）";  
    }
    
    return cellHeadView;
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
