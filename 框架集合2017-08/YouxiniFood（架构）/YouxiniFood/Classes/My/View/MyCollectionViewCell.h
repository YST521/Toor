//
//  MyCollectionViewCell.h
//  YouxiniFood
//
//  Created by youxin on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  myCellDelegate <NSObject>

- (void)wiseLifeDidSelectRow:(NSInteger)row andSection:(NSInteger)section;

@end

@interface MyCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIView *titleView;
@property (nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIColor *squareColor;
@property (nonatomic,copy)NSArray *iconArr;
@property (nonatomic,copy)NSArray *contentArr;
@property (nonatomic,assign)NSInteger  section;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,assign) id <myCellDelegate>delegate;

@end
