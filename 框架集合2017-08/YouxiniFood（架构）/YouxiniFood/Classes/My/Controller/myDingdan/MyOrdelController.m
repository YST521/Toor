//
//  MyOrdelController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyOrdelController.h"
#import "AllOrderCell.h"
#import "WaitPayCell.h"
#import "OracelQrController.h"
#import "CanteenViewController.h"



/** -顶部标题的高度 */
CGFloat const TitilesViewH = 40;
/** -顶部标题的Y */
CGFloat const TitilesViewY = 0;


@interface MyOrdelController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,cellClickQrActionDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;

@property(nonatomic,strong)NSArray      *titlesArray;

@property(nonatomic,strong)UITableView  *allOrderTabView;
@property(nonatomic,strong)UITableView  *waitPayTabView;

@end

static NSString *allOrdelCellID = @"allOrdelCellID";
static NSString *witeCellID = @"witeCellID";

@implementation MyOrdelController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titlesArray = @[@"全部订单",@"待支付"];

    
    // 设置顶部的标签栏
    [self setupTitlesView];
    
    // 底部的scrollView
    [self setupContentView];

    [self creatUI]; //创建tabview
}

-(void)creatUI{
    
     self.contentView.backgroundColor = BgColor;
    
    //全部订单
    
    self.tb .frame =CGRectMake(SceneWidth, CGRectGetMaxY(self.titlesView.frame)+20, SceneWidth, SceneHeight - self.titlesView.height -10-64);
    
    self.allOrderTabView =[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titlesView.frame)+20, SceneWidth, SceneHeight - self.titlesView.height -10-64) style:(UITableViewStylePlain)];
       
        [self.contentView addSubview:self.allOrderTabView];
      self.allOrderTabView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.allOrderTabView.dataSource = self;
    self.allOrderTabView.delegate = self;
    
    [self.allOrderTabView registerClass:[AllOrderCell class] forCellReuseIdentifier:allOrdelCellID];
 
    //未支付
    self.waitPayTabView =[[UITableView alloc]initWithFrame:CGRectMake(SceneWidth, CGRectGetMaxY(self.titlesView.frame)+20, SceneWidth, SceneHeight - self.titlesView.height -10-64) style:(UITableViewStylePlain)];
    
    [self.contentView addSubview:  self.waitPayTabView];
    
    //取消分割线
      self.waitPayTabView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.waitPayTabView.delegate = self;
    self.waitPayTabView.dataSource = self;
    
    [self.waitPayTabView registerClass:[WaitPayCell class] forCellReuseIdentifier:witeCellID];
    
    //
//        self.allOrderTabView.backgroundColor = [UIColor redColor];
//        self.waitPayTabView.backgroundColor = [UIColor blueColor];
    
}

#pragma mark------------tabviewdelegate------------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.allOrderTabView) {
        
        return 5;
    }else{
        return 10;
    }

  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.allOrderTabView) {
       
        return 500;
    } else {
        return 500;
    }

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.allOrderTabView) {
        
        AllOrderCell *cell =[self.allOrderTabView dequeueReusableCellWithIdentifier:allOrdelCellID];
        //取消点击效果
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
//        UIView *footV=[[UIView alloc]init];
//        footV.frame = CGRectMake(0, 0, SceneWidth, 50);
//        footV.backgroundColor = BgColor;
//        
//        self.allOrderTabView.tableFooterView = footV;
        cell.OrcalCellQrDelegate = self;
        return cell;
        
    } else {
        
       WaitPayCell *cell =[self.waitPayTabView dequeueReusableCellWithIdentifier:witeCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
    

}

- (void)qrBtnClickAction:(id)sel{

    OracelQrController *creatQrVC =[[OracelQrController alloc]init];
    [self.navigationController pushViewController:creatQrVC animated:YES];
}

- (void)allAddressClickAction:(id)sel{
 
#pragma  warning  !!!
    //跳转 tabbar 此跳转方法有误
    
    CanteenViewController *cantingVC =[[CanteenViewController alloc]init];
//    cantingVC.navigationController.navigationBar.translucent = YES;
//    cantingVC.view.frame = CGRectMake(0, 0, SceneWidth, SceneHeight);
    cantingVC.selectIndex = 0;
   NSArray* typeArr = @[@"套餐",@"小吃",@"饮料",@"特色"];
    cantingVC.typeArr = typeArr;
    [self.navigationController pushViewController:cantingVC animated:YES];
    
}


/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height =  TitilesViewH;
    titlesView.originY = TitilesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor  blackColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.originY = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    CGFloat width = titlesView.width /  self.titlesArray.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i< self.titlesArray.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.originX = i * width;
       NSString *vc =  self.titlesArray[i];
        [button setTitle: vc forState:UIControlStateNormal];
        //      [button layoutIfNeeded]; // 强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
}

- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 * 底部的scrollView
 */
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
//    [self scrollViewDidEndScrollingAnimation:contentView];
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
