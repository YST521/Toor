//
//  LimitCell.h
//  YouxiniFood
//
//  Created by 何青 on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol LimitCollectionViewDelegate <NSObject>

- (void)clickImageViewWithIndex:(NSInteger)index WithRow:(NSInteger)row;
- (void)clickMoreBtnWithRow:(NSInteger)row;

@end

@interface LimitCell : UICollectionViewCell<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;//限时抢购
@property (weak, nonatomic) IBOutlet UILabel *limitTitle;//距离结束
@property (weak, nonatomic) IBOutlet UILabel *hourLable;//时
@property (weak, nonatomic) IBOutlet UILabel *minLable;//分
@property (weak, nonatomic) IBOutlet UILabel *secLable;//秒
@property (weak, nonatomic) IBOutlet UILabel *fuhaoLable1;//符号：
@property (weak, nonatomic) IBOutlet UILabel *fuhaoLable2;//符号：
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;//更多
- (IBAction)btnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *foodImgView1;//图片1
@property (weak, nonatomic) IBOutlet UIImageView *foodImgView2;//图片2
@property (weak, nonatomic) IBOutlet UIImageView *foodImgView3;//图片3
@property (weak, nonatomic) IBOutlet UILabel *contenLable1;//美食名字1
@property (weak, nonatomic) IBOutlet UILabel *contenLable2;//美食名字2
@property (weak, nonatomic) IBOutlet UILabel *contentLable3;//美食名字3
@property (weak, nonatomic) IBOutlet UILabel *priceLable1;//美食价格1
@property (weak, nonatomic) IBOutlet UILabel *priceLable2;//美食价格2
@property (weak, nonatomic) IBOutlet UILabel *priceLable3;//美食价格3
@property (weak, nonatomic) IBOutlet UILabel *discountLable1;//美食折扣1
@property (weak, nonatomic) IBOutlet UILabel *discountLable2;//美食折扣2
@property (weak, nonatomic) IBOutlet UILabel *discountLable3;//美食折扣3

@property (nonatomic,assign)NSInteger currentRow;
@property (nonatomic,assign)id <LimitCollectionViewDelegate>delegate;

- (void)refreshUI:(NSArray *)imgArr withContentArr:(NSArray *)contentArr withPriceArr:(NSArray *)priceArr withDiscount:(NSArray *)discountArr withTitle:(NSString *)title;

@end
