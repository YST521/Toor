//
//  OrderSelectViewController.m
//  YouxiniFood
//
//  Created by 何青 on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "OrderSelectViewController.h"
#import "LikeTableViewCell.h"
#import "DishesViewController.h"
#import "LikeHeadView.h"

@interface OrderSelectViewController ()<UITableViewDelegate,UITableViewDataSource,LikeTableViewCellDelegate>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation OrderSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _mytitle;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createTableView];
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 84, SceneWidth-40, SceneHeight-104) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"LikeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.layer.cornerRadius = CardLayerCornerRadius;
    _tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _tableView.layer.borderWidth = 0.3;
    _tableView.clipsToBounds = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.isTwo = YES;
    cell.delegate = self;
    cell.index = indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LikeHeadView *headView = [[[NSBundle mainBundle] loadNibNamed:@"LikeHeadView" owner:self options:nil] lastObject];
    headView.frame = CGRectMake(0, 0, SceneWidth- 40, 40);
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DishesViewController *vc =[DishesViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - LikeTableViewCellDelegate
- (void)LikeTableViewCelldidSelectClickBuyBtn:(NSInteger)index{
    DishesViewController *vc =[DishesViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
