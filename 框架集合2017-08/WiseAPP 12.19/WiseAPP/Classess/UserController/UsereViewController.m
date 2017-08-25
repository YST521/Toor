//
//  UsereViewController.m
//  WiseAPP
//
//  Created by app on 16/10/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "UsereViewController.h"
#import "MiddleCollectionViewCell.h"

@interface UsereViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView; // 阅读主题列表
@property (nonatomic, strong) NSMutableArray *dataArray; // 阅读主题数据源
@property(nonatomic,assign)CGRect frame;
@end

@implementation UsereViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    /*
    UILabel*titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 22, SCREEN_WIDTH, 42);
    titleLabel.text = @"应用";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
     */
     self.navigationItem.title = @"应用";
    [self addData];
    [self creatCollectView];
    
}
-(void)addData{
    
    self.dataArray=[NSMutableArray array];
    self.dataArray =(NSMutableArray*)@[@"2",@"3",@"4",@"2",@"3",@"4",@"2",@"3",@"4",@"2",@"3",@"4",@"2",@"3",@"4",@"2",@"3",@"4",@"2",@"3",@"4",@"2",@"3",@"4",@"3",@"4",@"2",@"3",@"4",@"2",@"3",@"4",@"2",@"3",@"4",@"2",@"3",@"4",@"2",@"3",@"4",@"2",@"3",@"4",@"2",@"3",@"4"];
}
-(void)creatCollectView{
   // self.collectDataArray = [NSMutableArray array];
    
    //创建布局对象
    UICollectionViewFlowLayout*flowlayout=[[UICollectionViewFlowLayout alloc]init];
    
    
    //距离屏幕上下左右的间距
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //flowlayout.itemSize =CGSizeMake(SCREEN_WIDTH-50*SCREEN_WIDTH/375, 78*SCREEN_HEIGHT*667);
    flowlayout.itemSize =CGSizeMake((SCREEN_WIDTH-50)/4,(SCREEN_WIDTH-50)/4);
    
    //设置滑动方向
    //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    if(SCREEN_WIDTH>374){
        self.frame =CGRectMake(0, 0, SCREEN_WIDTH, PROPORTION_HIGHT((SCREEN_WIDTH-50)/2)+30) ;
        
    }else{
        self. frame =CGRectMake(0, 0, SCREEN_WIDTH, PROPORTION_HIGHT((SCREEN_WIDTH-50)/2)+50) ;
    }
    
    //初始化
    self.collectionView =[[UICollectionView alloc]initWithFrame: self.view.bounds   collectionViewLayout:flowlayout];
    
    
    
    //  self.collectionView.backgroundColor=[UIColor greenColor];
    
    //背景色
    self.collectionView.backgroundColor=GlobBackGroundColor;
    
    self.collectionView.dataSource =self;
    
    self.collectionView.delegate =self;
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[MiddleCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    
}

#pragma mark - 代理方法 -
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
   // return 100;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
       MiddleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor cyanColor];
 
    
    cell.titleLabel.text = @"测试";
     cell.iconImageView .image = [UIImage imageNamed:@"collect_icon_kaoqin"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

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
