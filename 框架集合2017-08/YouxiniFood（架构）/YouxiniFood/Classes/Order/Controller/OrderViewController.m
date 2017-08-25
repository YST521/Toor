//
//  OrderViewController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/26.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "OrderViewController.h"
#import "MenuCollectionViewCell.h"
#import "CouponCollectionViewCell.h"
#import "FlashSaleCell.h"
#import "EnjoyCollectionViewCell.h"
#import "CanteenViewController.h"
#import "OrderSelectViewController.h"
#import "DishesViewController.h"
#import "DiscountCouponAlterView.h"
#import "SearchHistoryController.h"

@interface OrderViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDataSourcePrefetching,MenuCollectionViewCellDelegate,CouponCollectionViewCellDelegate,EnjoyCollectionViewCellDelegate,readQRmessageDelegate,DiscountCouponAlterViewDelegate,FlashSaleCellDelegate>
{
    NSArray *typeArr;
    NSArray *titleArr;
    UISearchBar *searchBar;
    CGFloat row1Height,row2Height,row3Height,row4Height;
}
@property (nonatomic, strong)UIButton *leftbtn;
@property (nonatomic, strong)UIButton *rightbtn;
@property (nonatomic,strong)UICollectionView *collectionView;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // searchBar
    [self creatNav];
    [self setupnav];

    [self createCollectionView];
    typeArr = @[@"套餐",@"小吃",@"饮料",@"特色"];
    titleArr = @[@"限时抢购",@"今日推荐",@"智能小炒",@"自助火锅"];
    
    row1Height = (SceneWidth -40)/4*0.8+55;
    row2Height = (SceneWidth - 40)/2*0.5+60;
    row3Height = (SceneWidth - 32)/3*0.8+95;
    row4Height = 110*5+40;
}


- (void)creatNav{
    
    UIView *la = [[UIView alloc]init];
    la.frame = CGRectMake(50, 20, SceneWidth-180, 44);

    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, la.width, la.height)];
    searchBar.placeholder = @"搜索美食";
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.tintColor = GoldColor;
    [la addSubview:searchBar];
    searchBar.delegate = self;
   
    searchBar.barTintColor = [UIColor colorWithWhite:0.95 alpha:1.0];
     searchBar.backgroundColor = GoldColor;
    [ searchBar setBackgroundImage:[[UIImage alloc] init]];

    UIButton*  btnClear = [[UIButton alloc] initWithFrame:CGRectMake(searchBar.width-40, 0, 40, 40)];
    [btnClear addTarget:self action:@selector(clearTextAcion:) forControlEvents:UIControlEventTouchUpInside];
    [searchBar addSubview:btnClear];
    
  self.navigationItem.titleView =   la;
    
}


-(void)setupnav {
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(20, 0, 50, 30);
    [leftbtn setImage:[UIImage imageNamed:@"icon_xiala"] forState:UIControlStateNormal];
    [leftbtn setImage:[UIImage imageNamed:@"icon_xiala"] forState:UIControlStateSelected];
    [leftbtn setTitleColor:NaTitleColor forState:(UIControlStateNormal)];
    leftbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [leftbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    leftbtn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    [leftbtn setTitle:@"东莞" forState:UIControlStateNormal];
    leftbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftbtn addTarget:self action:@selector(btn_leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.leftbtn = leftbtn;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];

    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(SceneWidth-80, 0, 80, 30);
    [rightbtn setImage:[UIImage imageNamed:@"icon_shaoyishao"] forState:UIControlStateNormal];
    [rightbtn setImage:[UIImage imageNamed:@"icon_shaoyishao"] forState:UIControlStateSelected];
    rightbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [rightbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    rightbtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [rightbtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [rightbtn setTitleColor:NaTitleColor forState:(UIControlStateNormal)];
    rightbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightbtn addTarget:self action:@selector(btn_rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightbtn = rightbtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    }
- (void)clearTextAcion:(UIButton*)btn
{
    if (searchBar.text.length) {
        searchBar.text = nil;
    }
}
- (void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = BgColor;
    [_collectionView setPrefetchingEnabled:NO];
    [_collectionView registerClass:[MenuCollectionViewCell class] forCellWithReuseIdentifier:@"orderCell1"];
    [_collectionView registerClass:[CouponCollectionViewCell class] forCellWithReuseIdentifier:@"orderCell2"];
    [_collectionView registerClass:[FlashSaleCell class] forCellWithReuseIdentifier:@"orderCell3"];
    [_collectionView registerClass:[EnjoyCollectionViewCell class] forCellWithReuseIdentifier:@"orderCell4"];
    [self.view addSubview:_collectionView];
}
#pragma mark - searchBarDelegate;
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar00
{
    if ( ! searchBar00.isFirstResponder)
        if ([self.navigationController.viewControllers lastObject] == self) {
            SearchHistoryController *vc = [[SearchHistoryController alloc] init];
            //             SearchFacViewController *vc = [[SearchFacViewController alloc] init];
            
            vc.delegate = self;
            vc.PushClassNameIsHistoryKey =@"OrdelControllerler_history_keys";
            [self.navigationController pushViewController:vc animated:YES];
        }
    return NO;
}

- (void)searchViewController:(SearchHistoryController*)searchViewController searchText:(NSString*)searchText
{
    
    if ([searchText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]) {
        if ([searchText hasSuffix:@"\n"]) {
            searchText = [searchText substringToIndex:searchBar.text.length - 1];
        }
        if (searchText.length != 0) {
            NSLog(@"####******%@",searchBar.text);
        }else {
           
        }
        
    }
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"orderCell1" forIndexPath:indexPath];
        cell.titleViewColor = [UIColor darkGrayColor];
        cell.delegate = self;
        cell.iconArr = @[@"icon_taocan",@"icon_xiaochi",@"icon_yinliao",@"icon_tese"];
        cell.contentArr = typeArr;
        return cell;
    }else if (indexPath.row == 1){
        CouponCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"orderCell2" forIndexPath:indexPath];
        cell.delegate = self;
        [cell refreshUI];
        return cell;
    }else if (indexPath.row > 1 && indexPath.row < 6){
        FlashSaleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"orderCell3" forIndexPath:indexPath];
        [cell refreshUIWithImgArr:@[] title:titleArr[indexPath.row - 2] withFoodNameArr:@[] withPrice:@[] withDiscount:@[] withRow:indexPath.row];
        cell.delegate = self;
        return cell;
    }else{
        EnjoyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"orderCell4" forIndexPath:indexPath];
        cell.dataArr = @[];
        cell.delegate = self;
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 1 && indexPath.row <6) {
        NSLog(@"限时抢购------");
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return CGSizeMake(SceneWidth-20, row1Height);
    }else if (indexPath.row == 1){
        return CGSizeMake(SceneWidth-20,row2Height);
    }else if (indexPath.row > 1 && indexPath.row <6){
        return CGSizeMake(SceneWidth-20,row3Height);
    }else {
        return CGSizeMake(SceneWidth-20,  row4Height);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 10, 10, 10);
}

#pragma mark - 左边的按钮
-(void)btn_leftBtnClick:(UIButton *)button{
    button.selected = !button.selected;
    NSLog(@"naleft");
}

#pragma mark - 右边的按钮
-(void)btn_rightBtnClick:(UIButton *)button{
    button.selected = !button.selected;
    NSLog(@"naright");
    
    ReadQrMessageController *readVC = [[ReadQrMessageController alloc]init];
    readVC.readQRdelegate = self;
    [self.navigationController pushViewController:readVC animated:YES];
    
}

-(void)readQRMessage:(NSString *)messageString{

    NSLog(@"*******二维码读取字符串");
}

#pragma mark - MenuCollectionViewCellDelegate
- (void)selectMenuWithIndex:(NSInteger)index{
    CanteenViewController *vc = [CanteenViewController new];
    vc.selectIndex = index;
    vc.typeArr = typeArr;
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"饭堂菜品------%@",typeArr[index]);
  
}

#pragma mark - CouponCollectionViewCellDelegate
- (void)selectCouponWithIndex:(NSInteger)index{
    NSLog(@"优惠券------%ld",index);
    DiscountCouponAlterView *alterVc = [[DiscountCouponAlterView alloc] initWithTitle:@"太阳辣眼睛，优惠给你收" withContentText:@"  使用说明:\n   1、每天发放100张;\n   2、每人每天限用1张;\n   3、不能与其他优惠券相叠加" withCouponDic:nil];
    alterVc.delegate = self;
    [alterVc show];
}

#pragma mark - FlashSaleCellDelegate
- (void)clickMoreBtnWithRow:(NSInteger)row{
    NSLog(@"更多按钮被点击------%@",titleArr[row - 2]);
    OrderSelectViewController *vc = [OrderSelectViewController new];
    vc.mytitle = titleArr[row - 2];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickImageViewWithIndex:(NSInteger)index WithRow:(NSInteger)row{
    NSLog(@"点击了%@的第%ld张图片------",titleArr[row - 2],index);
    DishesViewController *vc= [DishesViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - EnjoyCollectionViewCellDelegate
- (void)enjoyCellDidSelectRow:(NSInteger)row{
    NSLog(@"猜你喜欢------%ld",row);
    DishesViewController *vc= [DishesViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - DiscountCouponAlterViewDelegate
- (void)discountCouponAlterViewCancel:(DiscountCouponAlterView *)alertView{

}

- (void)discountCouponAlterView:(DiscountCouponAlterView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
}

@end
