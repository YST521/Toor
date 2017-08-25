//
//  BanciTableViewCell.h
//  WiseAPP
//
//  Created by app on 16/10/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BanciTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel*titleLabel;
@property(nonatomic,strong)UILabel*starTime;
@property(nonatomic,strong)UILabel*endTimeLabel;
@property(nonatomic,strong)UIButton* editorBtn;
@property(nonatomic,strong)UIImage* editorImage;

@end
