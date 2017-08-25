//
//  PayCardViewController.m
//  YouxiniFood
//
//  Created by 何青 on 2017/7/27.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "PayCardViewController.h"
#import "WiseDetailViewController.h"
#import "PriceCollectionViewCell.h"
#import "PayCollectionViewCell.h"
#import "cardMessageCell.h"
@interface PayCardViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PayCollectionViewCellDelegate,PriceCollectionViewCellDelegate,cardMessageCellDeleagte>
{
    BOOL bzSelect,yueSelect,wexinSelect,alipaySelect;
    BOOL isSelectOther;
    NSInteger selectIndex;
    BOOL selectType;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation PayCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"饭卡充值";
    bzSelect = yueSelect = alipaySelect = selectType= NO;
    wexinSelect = YES;
    selectIndex = 1;
    [self createCollectionView];
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = BgColor;
    [_collectionView registerClass:[cardMessageCell class] forCellWithReuseIdentifier:@"payCardcell"];
    [_collectionView registerClass:[PriceCollectionViewCell class] forCellWithReuseIdentifier:@"payCardcell1"];
    [_collectionView registerClass:[PayCollectionViewCell class] forCellWithReuseIdentifier:@"payCardcell2"];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"payCardcell3"];
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        cardMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"payCardcell" forIndexPath:indexPath];
        cell.delegate = self;
        if (selectType) {
            [cell refreshUIWithArr:@[@"",@"",@""] withMessageArr:@[@"充值工号:",@"姓   名:",@"工厂信息:"] withTSArr:@[@"请输入工号",@"请输入姓名",@"请输入工厂信息"] btnSelect:selectType];
        }else{
            [cell refreshUIWithArr:@[@"18173719361",@"888888",@"广东优信无限南城厂区"] withMessageArr:@[@"充值账号:",@"充值工号:",@"工厂信息:"] withTSArr:@[@"请输入账号",@"请输入工号",@"请输入工厂信息"] btnSelect:selectType];
        }
        return cell;
    }else if (indexPath.row == 1){
        PriceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"payCardcell1" forIndexPath:indexPath];
        cell.selectIndex = selectIndex;
        cell.titleArr = @[@"20元",@"50元",@"100元",@"150元",@"200元",@"    其他\n输入金额"];
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 2){
        PayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"payCardcell2" forIndexPath:indexPath];
        cell.delegate = self;
        cell.bzSelect = bzSelect;
        cell.yueSelect = yueSelect;
        cell.wechatSelect = wexinSelect;
        cell.alipaySelect = alipaySelect;
        [cell refreshUI];
        return cell;
    }else if(indexPath.row == 3){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"payCardcell3" forIndexPath:indexPath];
        for (UIView *v in cell.contentView.subviews) {
            [v removeFromSuperview];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.layer.cornerRadius = CardLayerCornerRadius;
        cell.layer.borderColor  = [UIColor lightGrayColor].CGColor;
        cell.layer.borderWidth = 0.3;
        UILabel *payLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.width, cell.height)];
        payLable.text = @"立即支付";
        payLable.textColor = [UIColor darkGrayColor];
        payLable.textAlignment = NSTextAlignmentCenter;
        payLable.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:payLable];
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        WiseDetailViewController    *vc = [WiseDetailViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return CGSizeMake(SceneWidth-20, 134);
    }else if(indexPath.row == 1){
        CGFloat w = (SceneWidth - 80)/3;
        CGFloat h = w*0.9;
        if (isSelectOther) {
            return CGSizeMake(SceneWidth-20, h*2+70+50);
        }else{
            return CGSizeMake(SceneWidth-20, h*2+70);
        }
    }else if (indexPath.row == 2){
        return CGSizeMake(SceneWidth-20, 200);
    }else{
        return CGSizeMake(SceneWidth-20, 50);
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 10, 15, 10);
}

#pragma mark - PayCollectionViewCellDelegate
- (void)paycellDidClickBtnWithIndex:(NSInteger)index{
    switch (index) {
        case 100:
            wexinSelect = yueSelect = alipaySelect = NO;
            bzSelect = YES;
            break;
        case 101:
            bzSelect = wexinSelect = alipaySelect = NO;
            yueSelect = YES;
            break;
        case 102:
            bzSelect = yueSelect = alipaySelect = NO;
            wexinSelect = YES;
            break;
        case 103:
            bzSelect = yueSelect = wexinSelect = NO;
            alipaySelect = YES;
            break;
        default:
            break;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.collectionView  reloadItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - PriceCollectionViewCellDelegate
- (void)didSelectPriceWithIndex:(NSInteger)index{
    if (index == 5) {
        isSelectOther = YES;
    }else{
        isSelectOther = NO;
    }
    selectIndex = index;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.collectionView  reloadItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - cardMessageCellDeleagte 
- (void)typeBtnDidSelectWithtype:(BOOL)type{
    selectType = type;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectionView  reloadItemsAtIndexPaths:@[indexPath]];
}

@end
