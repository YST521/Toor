//
//  CouponCollectionViewCell.h
//  YouxiniFood
//
//  Created by 何青 on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CouponCollectionViewCellDelegate <NSObject>

- (void)selectCouponWithIndex:(NSInteger)index;

@end

@interface CouponCollectionViewCell : UICollectionViewCell
@property (nonatomic,assign)id <CouponCollectionViewCellDelegate>delegate;
- (void)refreshUI;
@end
