//
//  PaibanheadView.h
//  WiseAPP
//
//  Created by app on 16/12/14.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PaibanheadeModel;
typedef void(^HYBHeaderViewExpandCallback)(BOOL isExpanded);
@interface PaibanheadView : UITableViewHeaderFooterView
@property (nonatomic, strong) UIButton *arrowImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) PaibanheadeModel *model;
@property (nonatomic, copy) HYBHeaderViewExpandCallback expandCallback;
@property(nonatomic,strong)UIView* leftView;


@end
