//
//  FlashSaleCell.h
//  YouxiniFood
//
//  Created by 何青 on 2017/8/7.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlashSaleCellDelegate <NSObject>

- (void)clickImageViewWithIndex:(NSInteger)index WithRow:(NSInteger)row;
- (void)clickMoreBtnWithRow:(NSInteger)row;

@end

@interface FlashSaleCell : UICollectionViewCell
@property (nonatomic,strong)UILabel *titleLable;
//限时
@property (nonatomic,strong)UILabel *limitLable;
@property (nonatomic,strong)UILabel *hourLable;
@property (nonatomic,strong)UILabel *minLable;
@property (nonatomic,strong)UILabel *secLable;
@property (nonatomic,strong)UILabel *fuhao1;
@property (nonatomic,strong)UILabel *fuhao2;
//更多
@property (nonatomic,strong)UIButton  *moreBtn;
//图片
@property (nonatomic,strong)UIImageView  *foodImgView1;
@property (nonatomic,strong)UIImageView  *foodImgView2;
@property (nonatomic,strong)UIImageView  *foodImgView3;
//标题
@property (nonatomic,strong)UILabel  *titleLable1;
@property (nonatomic,strong)UILabel  *titleLable2;
@property (nonatomic,strong)UILabel  *titleLable3;
//价格
@property (nonatomic,strong)UILabel  *priceLable1;
@property (nonatomic,strong)UILabel  *priceLable2;
@property (nonatomic,strong)UILabel  *priceLable3;
//折扣
@property (nonatomic,strong)UILabel  *discountLable1;
@property (nonatomic,strong)UILabel  *discountLable2;
@property (nonatomic,strong)UILabel  *discountLable3;

@property (nonatomic,assign)id <FlashSaleCellDelegate>delegate;

- (void)refreshUIWithImgArr:(NSArray *)imgArr title:(NSString *)title withFoodNameArr:(NSArray *)nameArr withPrice:(NSArray*)priceArr withDiscount:(NSArray *)discountArr withRow:(NSInteger)row;
@end
