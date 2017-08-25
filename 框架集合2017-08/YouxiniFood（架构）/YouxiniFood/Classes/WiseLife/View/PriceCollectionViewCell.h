//
//  PriceCollectionViewCell.h
//  YouxiniFood
//
//  Created by 何青 on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  PriceCollectionViewCellDelegate <NSObject>

- (void)didSelectPriceWithIndex:(NSInteger)index;

@end

@interface PriceCollectionViewCell : UICollectionViewCell<UITextFieldDelegate>
@property (nonatomic,copy)NSArray *titleArr;
@property (nonatomic,strong) UITextField *priceTf;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,assign) id <PriceCollectionViewCellDelegate> delegate;
@end
