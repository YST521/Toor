//
//  MenuCollectionViewCell.h
//  YouxiniFood
//
//  Created by 何青 on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuCollectionViewCellDelegate <NSObject>

- (void)selectMenuWithIndex:(NSInteger)index;

@end

@interface MenuCollectionViewCell : UICollectionViewCell
@property (nonatomic,assign)id <MenuCollectionViewCellDelegate>delegate;
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,copy)NSArray *iconArr;
@property (nonatomic,copy)UIColor *titleViewColor;
@property (nonatomic,copy)NSArray *contentArr;
@property (nonatomic,copy)NSString *title;
@end
