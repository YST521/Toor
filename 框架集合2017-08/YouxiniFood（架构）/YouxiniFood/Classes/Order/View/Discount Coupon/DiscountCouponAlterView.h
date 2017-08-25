//
//  DiscountCouponAlterView.h
//  YouxiniFood
//
//  Created by 何青 on 2017/8/4.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DiscountCouponAlterView;

@protocol DiscountCouponAlterViewDelegate <NSObject>

@optional
- (void)discountCouponAlterView:(DiscountCouponAlterView *_Nullable)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)discountCouponAlterViewCancel:(DiscountCouponAlterView *_Nullable)alertView;

@end

@interface DiscountCouponAlterView : UIView
@property(nonatomic, assign) id  <DiscountCouponAlterViewDelegate> delegate;

- (instancetype _Nullable )initWithTitle:(nullable NSString *)title withContentText:(NSString *)content withCouponDic:(NSDictionary *)couponDic;

- (void)show;

- (void)cancel;

@end
