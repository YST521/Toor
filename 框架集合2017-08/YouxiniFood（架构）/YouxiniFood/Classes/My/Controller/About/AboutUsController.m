//
//  AboutUsController.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "AboutUsController.h"

@interface AboutUsController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView  *tabview;
@property(nonatomic,strong)UIView       *NavView;
@property(nonatomic,strong)UIView       *headView;

@end

static NSString * aboutCelleID = @"aboutCelleI";
@implementation AboutUsController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self creatTabView];
    
}

- (void)creatTabView{
    
    self.tabview =[[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.view addSubview:self.tabview];
   
    self.tabview.dataSource = self;
    self.tabview.delegate = self;
    
    [self.tabview registerClass:[UITableViewCell class] forCellReuseIdentifier:aboutCelleID];
    self.headView =[[UIView alloc]init];
    self.headView.frame =CGRectMake(0, 0, SceneWidth, 200);
    self.headView.backgroundColor = GoldColor;
    
    self.tabview.tableHeaderView = self.headView;
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, SceneWidth-100, 40)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"关于我们";
    lab.textColor = NaTitleColor;
    [ self.headView addSubview:lab];
    
    UIButton *backBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(20, 32, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"icon_houtui"] forState:(UIControlStateNormal)];
    [ self.headView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];

    UILabel *versionLa =[[UILabel alloc]init];
    versionLa.frame = CGRectMake(0, self.headView.height-40, SceneWidth, 20);
    versionLa.font =[UIFont systemFontOfSize:14];
    versionLa.textColor =NaTitleColor;
    versionLa.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:versionLa];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
 
    // app名称
   // NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
   // NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    versionLa.text = [NSString stringWithFormat:@"V %@",app_Version];
    
    
}

-(void)backBtnAction:(UIButton*)sendder{
    
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark ----------tabviewdelegate--------------------------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[self.tabview dequeueReusableCellWithIdentifier:aboutCelleID];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"项目简介";
    }
    
    
    cell.textLabel.font =[UIFont systemFontOfSize:14];
    cell.textLabel.textColor =[UIColor colorWithHexStringg:@"#999999"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.tabview.tableFooterView =[[UIView alloc]init];
    
    return cell;
}

-(void)setNav {
    self.NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SceneWidth, 64)];
    self.NavView.backgroundColor = GoldColor;
    //      self.NavView.backgroundColor =  [UIColor whiteColor];
    self.NavView.backgroundColor = [self.NavView.backgroundColor colorWithAlphaComponent:0];
    [self.view addSubview:self.NavView];
    
    
    
    
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
