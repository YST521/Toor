//
//  ZFCollectionViewCell.h
//  YouxiniFood
//
//  Created by 何青 on 2017/8/7.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ZFCollectionViewCellDelegate <NSObject>

- (void)zfCellDidClickBtnWithIndex:(NSInteger)index;

@end

@interface ZFCollectionViewCell : UICollectionViewCell
@property (nonatomic,assign) BOOL wechatSelect;
@property (nonatomic,assign) BOOL alipaySelect;
@property (nonatomic,assign) id <ZFCollectionViewCellDelegate> delegate;

- (void )refreshUI;

@end
