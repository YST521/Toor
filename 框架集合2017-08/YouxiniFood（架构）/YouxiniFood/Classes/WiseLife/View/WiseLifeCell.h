//
//  WiseLifeCell.h
//  YouxiniFood
//
//  Created by 何青 on 2017/7/27.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  WiseLifeDelegate <NSObject>

- (void)wiseLifeDidSelectRow:(NSInteger)row andSection:(NSInteger)section;

@end

@interface WiseLifeCell : UICollectionViewCell<CAAnimationDelegate>

@property (nonatomic,strong)UIView *titleView;
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,copy)NSArray *iconArr;
@property (nonatomic,copy)UIColor *titleViewColor;
@property (nonatomic,copy)NSArray *contentArr;
@property (nonatomic,assign)NSInteger  section;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,assign) id <WiseLifeDelegate>delegate;
@end
