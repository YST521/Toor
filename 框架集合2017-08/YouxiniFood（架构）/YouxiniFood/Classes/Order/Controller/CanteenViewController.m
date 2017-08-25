//
//  CanteenViewController.m
//  YouxiniFood
//
//  Created by 何青 on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "CanteenViewController.h"
#import "SubmitOrderViewController.h"
#import "DiancanTypeCell.h"
#import "DiancanCell1.h"
#import "ShoppingCartView.h"
#import "ThrowLineTool.h"
#import "ViewModel.h"
#import "OrderModel.h"

@interface CanteenViewController ()<UITableViewDelegate,UITableViewDataSource,ThrowLineToolDelegate,ShoppingCartViewDelegate>
{
    NSInteger _number;
}
@property (nonatomic,strong)UITableView *leftTb;
@property (nonatomic,strong)UITableView *rightTb;
@property (nonatomic,strong) ShoppingCartView *shoppcartview;
//订单数据
@property (nonatomic,strong) NSMutableArray *ordersArray;
//数据源
@property(nonatomic,strong) NSMutableArray *dataArray;
//抛物线红点
@property (strong, nonatomic) UIImageView *redView;
//总数量
@property (nonatomic,assign) NSInteger totalOrders;

@end

@implementation CanteenViewController
- (UIImageView *)redView
{
    if (!_redView) {
        _redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _redView.image = [UIImage imageNamed:@"adddetail"];
        _redView.backgroundColor = GoldColor;
        _redView.layer.cornerRadius = 10;
    }
    return _redView;
}

-(NSMutableArray *)ordersArray
{
    if (!_ordersArray) {
        _ordersArray = [NSMutableArray new];
    }
    return _ordersArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"优信食堂";
    _iconImgArr = @[@"bg_taocan",@"bg_xiaochi",@"bg_yinliao",@"bg_tese"];
    [self createTableView];
    [ThrowLineTool sharedTool].delegate = self;
    [self CustomModel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdatemainUI:) name:@"updateUI" object:nil];
    _number = 0;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

#pragma  mark - 初始化数据
/**
 *  当前店铺商品数据
 */
-(void)CustomModel{
    WeakSelf;
    [ViewModel GetShoppdata:^(NSMutableArray *array){
        wSelf.dataArray = array;
    }];
    
}

- (void)createTableView{
//    self.navigationController.navigationBar.translucent = NO;
    
    _leftTb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, SceneHeight-50-64) style:UITableViewStylePlain];
    _leftTb.delegate = self;
    _leftTb.dataSource = self;
    _leftTb.tableFooterView = [UIView new];
    _leftTb.showsVerticalScrollIndicator = NO;
    _leftTb.rowHeight = 50;
    _leftTb.separatorColor = [UIColor whiteColor];
    _leftTb.backgroundColor = BgColor;
    [_leftTb registerClass:[DiancanTypeCell class] forCellReuseIdentifier:@"leftCell"];
    [self.view addSubview:_leftTb];
    [_leftTb selectRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    _rightTb = [[UITableView alloc] initWithFrame:CGRectMake(80, 0, SceneWidth-80, SceneHeight-50-64) style:UITableViewStylePlain];
    _rightTb.delegate = self;
    _rightTb.dataSource = self;
    _rightTb.tableFooterView = [UIView new];
    _rightTb.showsVerticalScrollIndicator = NO;
    _rightTb.rowHeight = 100;
    _rightTb.separatorColor = [UIColor clearColor];
    [_rightTb registerNib:[UINib nibWithNibName:@"DiancanCell1" bundle:nil] forCellReuseIdentifier:@"rightCell"];
    [self.view addSubview:_rightTb];
    
    self.shoppcartview  = [[ShoppingCartView alloc] initWithFrame:CGRectMake(0,SceneHeight - 50-64, SceneWidth, 50) inView:self.view];
    self.shoppcartview.delegate = self;
    [self.view addSubview:self.shoppcartview];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _leftTb) {
        return _typeArr.count;
    }
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _leftTb) {
        return 1;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTb) {
        DiancanTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
        cell.nameLable.text = _typeArr[indexPath.row];
        cell.iconImgView.image = [UIImage imageNamed:_iconImgArr[indexPath.row]];
        return cell;
    }else if (tableView == _rightTb){
        DiancanCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell"];
        cell.section = indexPath.section;
        cell.row = indexPath.row;
        cell.ggblock = ^(NSInteger row, NSInteger section) {//点击选择规格
        };
        __weak __typeof(&*cell)weakCell =cell;
        WeakSelf;
        cell.addblock = ^(NSInteger row, NSInteger section,NSInteger number) {//点+
            _number ++;
            NSMutableDictionary * dic = self.dataArray[0];//获取点餐数据
            [dic setObject:[NSNumber numberWithInteger:_number] forKey:@"orderCount"];//设置点餐数目
            
            CGRect parentRectA = [weakCell convertRect:weakCell.addBtn.frame toView:wSelf.view];
            CGRect parentRectB = [wSelf.shoppcartview convertRect:wSelf.shoppcartview.shoppingCartBtn.frame toView:wSelf.view];
            [wSelf.view addSubview:wSelf.redView];
          [[ThrowLineTool sharedTool] throwObject:wSelf.redView from:parentRectA.origin to:parentRectB.origin];
            wSelf.ordersArray = [ViewModel storeOrders:dic OrderData:self.ordersArray isAdded:YES];
            
            wSelf.shoppcartview.OrderList.objects = wSelf.ordersArray;
            [wSelf.shoppcartview updateFrame:wSelf.shoppcartview.OrderList];
            [wSelf.shoppcartview.OrderList.tableView reloadData];
            wSelf.shoppcartview.badgeValue =  [ViewModel CountOthersWithorderData:wSelf.ordersArray];
            double price = [ViewModel GetTotalPrice:wSelf.ordersArray];
            [wSelf.shoppcartview setTotalMoney:price];
        };
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _rightTb) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SceneWidth-100, 40)];
        headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        lb.backgroundColor = [UIColor orangeColor];
        lb.layer.cornerRadius = 5;
        lb.clipsToBounds = YES;
        [headView addSubview:lb];
        
        lb = [[ UILabel alloc] initWithFrame:CGRectMake(40, 10, 200, 20)];
        lb.textColor = [UIColor grayColor];
        lb.text = @"智能小炒";
        [headView addSubview:lb];
        
        return headView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _rightTb) {
        return 40;
    }
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 设置购物车动画
- (void)animationDidFinish
{
    [self.redView removeFromSuperview];
    [UIView animateWithDuration:0.1 animations:^{
        self.shoppcartview.shoppingCartBtn.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.shoppcartview.shoppingCartBtn.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}

#pragma mark - 通知更新
-(void)UpdatemainUI:(NSNotification *)Notification{
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary: Notification.userInfo];
    //重新计算订单数组。
    self.ordersArray = [ViewModel storeOrders:dic[@"update"] OrderData:self.ordersArray isAdded:[dic[@"isAdd"] boolValue]];
    self.shoppcartview.OrderList.objects = self.ordersArray;
    //设置高度。
    [self.shoppcartview updateFrame:self.shoppcartview.OrderList];
    [self.shoppcartview.OrderList.tableView reloadData];
    //设置数量、价格
    self.shoppcartview.badgeValue =  [ViewModel CountOthersWithorderData:self.ordersArray];
    _number = [ViewModel CountOthersWithorderData:self.ordersArray];
    double price = [ViewModel GetTotalPrice:self.ordersArray];
    [self.shoppcartview setTotalMoney:price];
    //重新设置数据源
    self.dataArray = [ViewModel UpdateArray:self.dataArray atSelectDictionary:dic[@"update"]];
    [self.rightTb reloadData];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:@"updateUI"];
}

#pragma mark - ShoppingCartViewDelegate(点击了选好了按钮,提交订单)
- (void)shoppingClickSelectCompleteWithArray:(NSArray *)orderArray{
    SubmitOrderViewController *vc = [SubmitOrderViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"选择了 %@",orderArray);
}
@end
