//
//  PayCollectionViewCell.h
//  YouxiniFood
//
//  Created by 何青 on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  PayCollectionViewCellDelegate <NSObject>

- (void)paycellDidClickBtnWithIndex:(NSInteger)index;

@end

@interface PayCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIButton *bzBtn;//企业补助
@property (nonatomic,strong)UIButton *yueBtn;//余额支付
@property (nonatomic,strong)UIButton *wechatBtn;//微信支付
@property (nonatomic,strong)UIButton *alipayBtn;//支付宝支付
@property (nonatomic,assign) BOOL bzSelect;
@property (nonatomic,assign) BOOL yueSelect;
@property (nonatomic,assign) BOOL wechatSelect;
@property (nonatomic,assign) BOOL alipaySelect;
@property (nonatomic,assign) id <PayCollectionViewCellDelegate> delegate;

- (void)refreshUI;
@end
