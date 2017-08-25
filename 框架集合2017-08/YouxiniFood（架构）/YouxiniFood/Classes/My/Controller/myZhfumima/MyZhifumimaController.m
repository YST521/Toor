//
//  MyZhifumimaController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/29.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyZhifumimaController.h"
#import "ChangeZhifuPwController.h"
#import "ForgetPayPwController.h"
#import "MYViewController.h"

@interface MyZhifumimaController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *zhifumimaTabview;

@end

@implementation MyZhifumimaController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    MYViewController *myVC =[[MYViewController alloc]init];
    
      [self.navigationController popToViewController:myVC animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.title = @"支付密码管理";
    [self creatNaBar];
    [self creatTabview];
}
- (void)creatNaBar{
//    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_houtui"] style:(UIBarButtonItemStylePlain) target:self action:@selector(backUpPageAction:)];
    
    //得到当前视图控制器中的所有控制器
//    NSMutableArray *array = [self.navigationController.viewControllers mutableCopy];
//    //把B从里面删除
//    [array removeObjectAtIndex:1];
//      [array removeObjectAtIndex:2];
//    //把删除后的控制器数组再次赋值
//    [self.navigationController setViewControllers:[array copy] animated:YES];
  
}
- (void)backUpPageAction:(UIBarButtonItem*)sender{
//    MYViewController *myVC =[[MYViewController alloc]init];
//    
//    [self.navigationController popToViewController:myVC animated:YES];
}

-(void)creatTabview{
    
    self.zhifumimaTabview =[[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain )];
    [self.view addSubview:self.zhifumimaTabview];
    self.zhifumimaTabview.dataSource = self;
    self.zhifumimaTabview.delegate = self;
   
}


#pragma mark ----------------tabviewDeltgate----------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell =[self.zhifumimaTabview dequeueReusableCellWithIdentifier:@"zhifumimacell"];

    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"zhifumimacell"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"修改支付密码";
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = @"忘记支付密码";
    }
    self.zhifumimaTabview .tableFooterView =[[UIView alloc]init];
    cell.textLabel.textColor =[UIColor colorWithHexStringg:@"#666666"];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ChangeZhifuPwController *chanVC =[[ChangeZhifuPwController alloc]init];
        chanVC.title = @"修改支付密码";
        [self.navigationController pushViewController:chanVC animated:YES];
        
    }
    
    if (indexPath.row == 1) {
        
        ForgetPayPwController *forgetVC =[[ForgetPayPwController alloc]init];
        forgetVC.title = @"填写个人信息";
        [self.navigationController pushViewController:forgetVC animated:YES];
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
