//
//  XunjianquanshuShowViewController.m
//  WiseAPP
//
//  Created by yst911521 on 2016/11/27.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XunjianquanshuShowViewController.h"
#import "XunjianquwnashuShowTableViewCell.h"
#import "XunjianQuanshuModel.h"
#import "XunjianquanshuAddViewController.h"

@interface XunjianquanshuShowViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*showTabview;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)NSMutableArray* timeArray;
@end
static NSString* showcellID= @"showcellID";
@implementation XunjianquanshuShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"巡检点设置";
    [self addData];
    [self creatUI];
    
}

-(void)addData{
    self.dataArray=[NSMutableArray array];
    for (NSDictionary*dic in self.model.info) {
       
        [self.dataArray addObject:dic];
    }


}
-(void)creatUI{
    self.showTabview=[[UITableView alloc]initWithFrame:UIScreenBpunds style:(UITableViewStylePlain)];
    [self.view addSubview:self.showTabview];
    self.showTabview.backgroundColor =GlobBackGroundColor;
    self.showTabview.dataSource=self;
    self.showTabview.dataSource =self;
    [self.showTabview registerClass:[XunjianquwnashuShowTableViewCell class] forCellReuseIdentifier:showcellID];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XunjianquwnashuShowTableViewCell* cell=[self.showTabview dequeueReusableCellWithIdentifier:showcellID];
    cell.leftNumLa.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        NSDictionary*dic =self.dataArray[indexPath.row];
        cell.leftAdressLa.text = dic[@"inspectionname"];
        cell.rightLa.text =dic[@"inspectiontime"];
        
    
    self.showTabview.tableFooterView =[[UIView alloc]init];
    cell.leftBtn.tag = 1100+indexPath.row;

    
    return cell;
}



//next page
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XunjianquanshuAddViewController*addVC =[[XunjianquanshuAddViewController alloc]init];
    addVC.uppageType =1;
    addVC.model =self.model;
    
    [self.navigationController pushViewController:addVC animated:YES];

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
