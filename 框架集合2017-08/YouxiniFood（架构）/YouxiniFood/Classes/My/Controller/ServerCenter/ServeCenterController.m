//
//  ServeCenterController.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "ServeCenterController.h"

@interface ServeCenterController ()<UITableViewDelegate,UITableViewDataSource>{

    UIButton *lineServerBtn,*contanctBtn;
    UILabel *userLa;
    UIView *userBG;
}

@property(nonatomic,strong)UITableView *tabview;

@end
static NSString *serverCelleID = @"serverCelleID";

@implementation ServeCenterController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    [self creatTabview];
    
    
}

-(void)creatTabview{

    self.tabview =[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(userBG.frame), SceneWidth, SceneHeight-userBG.originY) style:(UITableViewStylePlain)];
    [self.view addSubview:self.tabview];
    
    self.tabview.dataSource = self;
    self.tabview.delegate = self;
    self.tabview.backgroundColor = BgColor;
    
    [self.tabview registerClass:[UITableViewCell class] forCellReuseIdentifier:serverCelleID];
    

}

#pragma mark------------------tabviewdelegate-------------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[self.tabview dequeueReusableCellWithIdentifier:serverCelleID];

    cell.backgroundColor =[UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    if (indexPath.row == 0) {
        cell.textLabel.text= @"饭卡充值不成功怎么办？";
    }
    
    if (indexPath.row == 1) {
          cell.textLabel.text= @"提现流程？";
    }
    
    cell.textLabel.textColor =[UIColor colorWithHexStringg:@"#999999"];
    cell.textLabel.font =[UIFont systemFontOfSize:14];
    self.tabview.tableFooterView =[[UIView alloc]init];
    
    return  cell;
}






- (void)creatUI{
    
    lineServerBtn =[[UIButton alloc]init];
    lineServerBtn.frame = CGRectMake(1, 1, SceneWidth/2-2, 78);
    lineServerBtn.backgroundColor=[UIColor whiteColor];
    [lineServerBtn setTitle:@"在线客服" forState:(UIControlStateNormal)];
    [lineServerBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
    [self.view addSubview:lineServerBtn];
    
    contanctBtn =[[UIButton alloc]init];
    contanctBtn.frame = CGRectMake(SceneWidth/2+1, 1, SceneWidth/2-2, 78);
     contanctBtn.backgroundColor=[UIColor whiteColor];
    [ contanctBtn setTitle:@"联系客服" forState:(UIControlStateNormal)];
    [ contanctBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
    [self.view addSubview: contanctBtn];
    
    userBG =[[UIView alloc]init];
    userBG.frame = CGRectMake(0, CGRectGetMaxY(contanctBtn.frame)+2, SceneWidth, 40);
    userBG.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:userBG];
    
    userLa =[[UILabel alloc]init];
    userLa.frame = CGRectMake(20, 0, SceneWidth-40, 40);
    userLa.text = @"常见问题";
    userLa.font = [UIFont systemFontOfSize:14];
//    userLa.textAlignment = NSTextAlignmentCenter;
    userLa.backgroundColor =[UIColor whiteColor];
    userLa.textColor =[UIColor colorWithHexStringg:@"#666666"];
    [userBG addSubview:userLa];
    
    
    
    
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
