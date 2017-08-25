//
//  CitySelectController.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/7.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "CitySelectController.h"

@interface CitySelectController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tabview;

//data

@property (strong, nonatomic) NSArray *cityArray; //市

@property(nonatomic,strong) NSString *cityNameStr;


@end

static NSString *cityCellID = @"cityCellID";
@implementation CitySelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"地区"];
    
    [self getCityData];
    [self creatUI];
}

#pragma mark - get data
- (void)getCityData {
    
    for (NSDictionary *dic in self.cityTownArray) {
        
        self.cityArray = [dic allKeys];
    }

}

- (void)creatUI{
 
    self.tabview = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.view addSubview:self.tabview];
    
    self.tabview.dataSource = self;
    self.tabview.delegate = self;
    
    [self.tabview registerClass:[UITableViewCell class] forCellReuseIdentifier:cityCellID];
    
}

#pragma mark -uitabviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.cityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[self.tabview dequeueReusableCellWithIdentifier:cityCellID];
    
    
    cell.textLabel.text = self.cityArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    NSString *city =self.cityArray[indexPath.row];
    NSString *cityStr = [NSString stringWithFormat:@"%@%@",self.provinceNameStr,city];
    self.cityNameStr =cityStr;
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"确定选择%@",cityStr] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"是", nil];
    [av show];
    

//    NSLog(@"*****%@--****___%@",self.cityArray[indexPath.row],self.cityArray);
    //town
//    for (NSDictionary *dic in self.cityTownArray) {
//        
//        NSArray *townArray = dic[city];
//        NSLog(@"UU--%@",townArray);
//    }
    

}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.cityNameStr,@"cityName", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addressNotification" object:@"addressName" userInfo:dic];
    //跳转回新增页面
    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3] animated:YES];

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
