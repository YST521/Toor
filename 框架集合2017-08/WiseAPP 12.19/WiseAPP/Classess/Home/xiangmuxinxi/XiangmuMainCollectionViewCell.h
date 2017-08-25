//
//  XiangmuMainCollectionViewCell.h
//  WiseAPP
//
//  Created by app on 16/10/14.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiangmuMainCollectionViewCell : UICollectionViewCell
//cell中的图片；
@property(strong,nonatomic) UIImageView *imageView;
//cell中的描述文本；
//@property(strong,nonatomic) UILabel *descLabel;

@property(strong,nonatomic) UILabel*xiangmuTitle;
//cell右上角的删除按钮；
@property(nonatomic,strong)UIButton *deleteButton;
@end
