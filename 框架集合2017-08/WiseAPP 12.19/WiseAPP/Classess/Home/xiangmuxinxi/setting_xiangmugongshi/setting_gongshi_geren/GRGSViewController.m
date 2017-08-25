//
//  GRGSViewController.m
//  WiseAPP
//
//  Created by app on 16/11/29.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "GRGSViewController.h"

@interface GRGSViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* grTabview;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)UILabel* hleftNameLa;
@property(nonatomic,strong)UILabel* hleftgongshiLa;
@property(nonatomic,strong)UIImageView* hRightImage;

@end

@implementation GRGSViewController
//-(UITableView *)grTabview{
//    if (_grTabview) {
//        _grTabview=[[UITableView alloc]initWithFrame:UIScreenBpunds style:(UITableViewStylePlain)];
//        _grTabview.dataSource =self;
//        _grTabview.delegate =self;
//    }
//
//    return _grTabview;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self addData];
    [self addView];
}
-(void)addData{

  self.dataArray=[NSMutableArray array];
    self.dataArray=(NSMutableArray*)@[@"11",@"33",@"55"];
}
-(void)addView{
    _grTabview=[[UITableView alloc]initWithFrame:UIScreenBpunds style:(UITableViewStylePlain)];
    _grTabview.dataSource =self;
    _grTabview.delegate =self;
    [self.view addSubview:self.grTabview];
    [self.grTabview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.headView=[[UIView alloc]init];
    self.headView.frame =CGRectMake(0, 0, SCREEN_WIDTH, PROPORTION_HIGHT(45));
    self.hRightImage=[[UIImageView alloc]init];
    self.hRightImage.frame =CGRectMake(SCREEN_WIDTH-30, STANDRD_H_20_y, PROPORTION_WIDTH(13), PROPORTION_WIDTH(15));
    [self.headView addSubview:self.hRightImage];
    [self.hRightImage setImage:[UIImage imageNamed:@"icon_up"] ];
    //创建一个手势进行点击，这里可以换成button
  //  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(action_tap:)];
   // self.customHeadView.tag = 300 + section;

    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell*cell=[self.grTabview dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text =self.dataArray[indexPath.row];

    return cell;
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
