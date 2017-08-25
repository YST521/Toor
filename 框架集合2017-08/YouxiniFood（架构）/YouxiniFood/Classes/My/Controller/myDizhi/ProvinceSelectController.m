//
//  ProvinceSelectController.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/7.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "ProvinceSelectController.h"
#import "CitySelectController.h"

@interface ProvinceSelectController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tabview;

//data
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray; //省
@property (strong, nonatomic) NSArray *cityArray; //市
@property (strong, nonatomic) NSArray *townArray;  //区
@property (strong, nonatomic) NSArray *selectedArray;

@end

static NSString *provinceCellID = @"provincecityCellID";
@implementation ProvinceSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"地区"];
    
    [self getCityData];
    [self creatUI];
}

#pragma mark - get data
- (void)getCityData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
//    NSLog(@"******####++++%@",self.pickerDic);
}

- (void)creatUI{
    
    self.tabview = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.view addSubview:self.tabview];
    
    self.tabview.dataSource = self;
    self.tabview.delegate = self;
    
    [self.tabview registerClass:[UITableViewCell class] forCellReuseIdentifier:provinceCellID];
    
}

#pragma mark -uitabviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.provinceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[self.tabview dequeueReusableCellWithIdentifier:provinceCellID];
    
    
    cell.textLabel.text = self.provinceArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    
        CitySelectController *citySelectVC = [[CitySelectController alloc]init];
    NSString *provincename = self.provinceArray[indexPath.row];;
    citySelectVC.cityTownArray = self.pickerDic[provincename];
    citySelectVC.provinceNameStr = provincename;
        [self.navigationController pushViewController:citySelectVC animated:YES];
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
