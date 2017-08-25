//
//  LinbaoShowTableViewCell.h
//  WiseAPP
//
//  Created by app on 16/11/21.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LinbaoModel;

@interface LinbaoShowTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel* leftLa;
@property(nonatomic,strong)UILabel* rightLa;
-(void)setDataWithModel:(LinbaoModel*)model;
@end
