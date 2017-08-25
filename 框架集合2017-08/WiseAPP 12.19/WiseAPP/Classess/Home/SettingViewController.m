//
//  SettingViewController.m
//  WiseAPP
//
//  Created by app on 16/10/10.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "YezhufangViewController.h"
#import "BanCiViewController.h"
#import "BaogangViewController.h"
#import "GangweiViewController.h"
#import "KaoqinViewController.h"
#import "LinbaoGangweiViewController.h"
#import "XunjiandianweiViewController.h"
#import "XunjianquanshuViewController.h"
#import "JiaojiebanViewController.h"
#import "XiangmugongshiViewController.h"
#import "GangweipeixunViewController.h"
#import "PaibanViewController.h"
#import "YezhufangMainViewController.h"
#import "BanhuiSettingViewController.h"
#import "LinbaoViewController.h"
#import "XiangmuMainModel.h"
#import "KaoqinViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*settingTabview;
@property(nonatomic,strong)NSArray*dataArray;
@end

static NSString*setttingID = @"settingcellID";

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString*title=[NSString stringWithFormat:@"%@项目信息设置",self.model.projectname];
    self.title = title;
    [self creatView];
}
-(void)creatView{
    

    self.settingTabview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStylePlain)];
    //self.settingTabview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
   
    self.settingTabview.delegate =self;
    self.settingTabview.dataSource =self;
    self.dataArray = [NSArray array];
    self.dataArray = @[@"业主方信息",@"交接班",@"岗位培训设置",@"临保设置",@"班次设置",@"考勤设置",@"项目工时设置",@"排班设置",@"岗位设置",@"报岗设置",@"巡检点位设置",@"巡检圈数设置",@"班会设置"];
    
    [self.settingTabview  registerClass:[SettingTableViewCell class] forCellReuseIdentifier:setttingID];
     [self.view addSubview:self.settingTabview];
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return  self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingTableViewCell*cell = [self.settingTabview  dequeueReusableCellWithIdentifier:setttingID forIndexPath:indexPath ];
    
cell.titleLabel.text = self.dataArray[indexPath.row];

//    //显示最右边的箭头
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //

//
//    //去除多余cell
   self.settingTabview.tableFooterView = [[UIView alloc]init];
    self.settingTabview.tableFooterView.backgroundColor = GlobBackGroundColor;

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45*SCREEN_HEIGHT/667;

}
//点击cell进入下一页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row == 0){
        YezhufangMainViewController*yezhuMainVC = [[YezhufangMainViewController alloc]init];
        
         yezhuMainVC.navigationItem.title = @"业主方信息设置";
        
        [self.navigationController pushViewController:yezhuMainVC animated:YES];
     
     }else if (indexPath.row == 1){
         
         JiaojiebanViewController*jiaojiebanVC = [[JiaojiebanViewController alloc]init];
         jiaojiebanVC.navigationItem.title = @"交接班注意事项设置";
         [self.navigationController pushViewController:jiaojiebanVC animated:YES];
    
       }else if (indexPath.row == 2){
        GangweipeixunViewController*xiangmugongshiVC = [[GangweipeixunViewController alloc]init];
        xiangmugongshiVC.navigationItem.title = @"岗位培训设置";
        [self.navigationController pushViewController:xiangmugongshiVC animated:YES];
        

       }else if (indexPath.row == 3){
           //临保
           LinbaoViewController*linbaoVC=[[LinbaoViewController alloc]init];
           linbaoVC.navigationItem.title= @"临保设置";
           [self.navigationController pushViewController:linbaoVC animated:YES];

       }else if (indexPath.row == 4){
        BanCiViewController*banciVC=[[BanCiViewController alloc]init];
        
        [self.navigationController pushViewController:banciVC animated:YES];

     }else if (indexPath.row == 5){
        
        KaoqinViewController*kaoqinVC = [[KaoqinViewController alloc]init];
         kaoqinVC.navigationItem.title =@"考勤设置";
        [self.navigationController pushViewController:kaoqinVC animated:YES];
    }else if (indexPath.row == 6){
        XiangmugongshiViewController*xiangmugongshiVC = [[XiangmugongshiViewController alloc]init];
        xiangmugongshiVC.navigationItem.title = @"项目工时设置";
        [self.navigationController pushViewController:xiangmugongshiVC animated:YES];
        
  
    }else if (indexPath.row == 7){
        PaibanViewController*xiangmugongshiVC = [[PaibanViewController alloc]init];
        xiangmugongshiVC.navigationItem.title = @"排班设置";
        [self.navigationController pushViewController:xiangmugongshiVC animated:YES];
     
    }else if (indexPath.row == 8){
        
        GangweiViewController*gangweiVC = [[GangweiViewController alloc]init];
        gangweiVC.navigationItem .title = @"岗位设置";
        [self.navigationController pushViewController:gangweiVC animated:YES];
      

    }else if (indexPath.row == 9){

        BaogangViewController*xunjiandianweiVC = [[ BaogangViewController alloc]init];
        self.navigationItem.title =@"报岗设置";
        
        [self.navigationController pushViewController:xunjiandianweiVC animated:YES];
    
    }else if (indexPath.row == 10){
        XunjiandianweiViewController*dianweiVC = [[ XunjiandianweiViewController alloc]init];
       dianweiVC.navigationItem.title = @"巡检点位";
        [self.navigationController pushViewController:dianweiVC animated:YES];

   
    }else if (indexPath.row == 11){
        
        XunjianquanshuViewController*xunjianquanshuVC = [[XunjianquanshuViewController alloc]init];
        xunjianquanshuVC.navigationItem.title =@"巡检圈数设置";
        [self.navigationController pushViewController:xunjianquanshuVC animated:YES];

    }else if (indexPath.row == 12){
        BanhuiSettingViewController*banhuiVC =[[BanhuiSettingViewController alloc]init];
        banhuiVC.navigationItem.title = @"班会设置";
        
        [self.navigationController pushViewController:banhuiVC animated:YES];
    }

}

////    下面的代理方法设置，界面效果会马上响应
//- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
//{
//    cell.backgroundColor = [UIColor blackColor];
//    cell.textLabel.backgroundColor = [UIColor redColor];
//    cell.detailTextLabel.backgroundColor = [UIColor blueColor];
//}

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
