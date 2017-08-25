//
//  BaogangTableViewCell.h
//  WiseAPP
//
//  Created by app on 16/12/6.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaogangTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView* leftBg;
@property(nonatomic,strong)UIView* rightBg;

@property(nonatomic,strong)UILabel* leftGangweiLa;
@property(nonatomic,strong)UILabel* leftTimeLa;
@property(nonatomic,strong)UIButton* lefDetailBtn;

@property(nonatomic,strong)UILabel* middleNumLa;


@property(nonatomic,strong)UILabel* rightTimeLa;
@property(nonatomic,strong)UIButton* rightCamareBtn;

@end
