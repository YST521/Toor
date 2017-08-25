//
//  PayOrderViewController.m
//  YouxiniFood
//
//  Created by 何青 on 2017/8/7.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "PayOrderViewController.h"
#import "PayLimitCell.h"
#import "ZFCollectionViewCell.h"

@interface PayOrderViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ZFCollectionViewCellDelegate>
{
    BOOL wechatSelect,alipaySelect;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation PayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付订单";
    [self createCollectionView];
}


- (void)createCollectionView{
    wechatSelect = YES;
    alipaySelect = NO;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = BgColor;
    [_collectionView setPrefetchingEnabled:NO];
    [_collectionView registerClass:[PayLimitCell class] forCellWithReuseIdentifier:@"payLimitCellId"];
    [_collectionView registerClass:[ZFCollectionViewCell class] forCellWithReuseIdentifier:@"ZFCollectionViewCellId"];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"payOrderCellId"];
    [self.view addSubview:_collectionView];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        PayLimitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"payLimitCellId" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 1){
        ZFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZFCollectionViewCellId" forIndexPath:indexPath];
        cell.wechatSelect  = wechatSelect;
        cell.alipaySelect = alipaySelect;
        cell.delegate = self;
        [cell refreshUI];
        return cell;
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"payOrderCellId" forIndexPath:indexPath];
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
        return  cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return CGSizeMake(SceneWidth- 20, 100);
    }else if (indexPath.row == 1){
        return CGSizeMake(SceneWidth-20, 135);
    }else{
        return CGSizeMake(SceneWidth-20, 44);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 10, 5, 10);
}

#pragma mark - ZFCollectionViewCellDelegate 
- (void)zfCellDidClickBtnWithIndex:(NSInteger)index{
    if (index == 0) {
        wechatSelect = YES;
        alipaySelect = NO;
    }else{
        wechatSelect = NO;
        alipaySelect = YES;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.collectionView  reloadItemsAtIndexPaths:@[indexPath]];
}


@end
