//
//  WiseLifeViewController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/26.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "WiseLifeViewController.h"
#import "WiseLifeCell.h"
#import "PayCardViewController.h"
#import "WiseDetailViewController.h"

#define Color1 UIColorFromRGB(0x00dafa)
#define Color2 UIColorFromRGB(0xfec106)
#define Color3 UIColorFromRGB(0xd4ec40)

@interface WiseLifeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WiseLifeDelegate>
{
    NSArray *_titleArr;
    NSArray *_iconArr;
    NSArray *_contentArr;
     NSArray *_colorArr;
}
@property (nonatomic,strong)UICollectionView *collectionView;


@end

@implementation WiseLifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"智慧生活";
    [self createCollectionView];
    _titleArr = @[@"企业服务-这里能使你的生活变得更方便",@"投资理财-一个帮你赚钱的地方",@"第三方服务-休闲娱乐的地方"];
    _contentArr = @[@[@"饭卡充值",@"企业WiFi",@"自助洗衣",@"净化水",@"话费充值",@"流量充值"],@[@"智能餐厅",@"企业WiFi",@"贷款",@"理财宝"],@[@"电影票",@"火车票",@"酒店",@"滴滴",@"物流",@"信用卡还款"]];
    _iconArr = @[@[@"icon_fankachongzhi",@"icon_qiyewifi",@"icon_zizhuxiyiji",@"icon_jinhuashui",@"icon_huofeichongzhi",@"icon_liuliangchongzhi"],@[@"icon_zhihuicanting",@"icon_qiyewifi",@"icon_daikuang",@"icon_licaibao"],@[@"icon_dingyingpiao",@"icon_huochepiao",@"icon_jiudian",@"icon_didi",@"icon_wuliu",@"icon_xinyongkahuankuang"]];
    _colorArr = @[Color1,Color2,Color3];
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = BgColor;
    [_collectionView registerClass:[WiseLifeCell class] forCellWithReuseIdentifier:@"wisecell"];
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _contentArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WiseLifeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wisecell" forIndexPath:indexPath];
    cell.section = indexPath.row;
    cell.titleViewColor = _colorArr[indexPath.row];
    cell.iconArr = _iconArr[indexPath.row];
    cell.title = _titleArr[indexPath.row];
    cell.contentArr = _contentArr[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (SceneWidth -40)/4*0.8;
    if ([_contentArr[indexPath.row] count]%4) {
        NSInteger row = [_contentArr[indexPath.row] count]/4 +1;
        return CGSizeMake(SceneWidth-20, width*row+65);
    }else{
        NSInteger row = [_contentArr[indexPath.row] count]/4 ;
        return CGSizeMake(SceneWidth-20, width*row+65);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 10, 10, 10);
}

- (void)wiseLifeDidSelectRow:(NSInteger)row andSection:(NSInteger)section{
    if (section == 0 && row == 0) {
        PayCardViewController *vc = [PayCardViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        WiseDetailViewController *vc = [WiseDetailViewController new];
        vc.title =_contentArr[section][row];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
