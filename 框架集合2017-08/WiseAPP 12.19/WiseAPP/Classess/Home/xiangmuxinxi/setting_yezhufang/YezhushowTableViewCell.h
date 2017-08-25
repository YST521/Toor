//
//  YezhushowTableViewCell.h
//  WiseAPP
//
//  Created by app on 16/11/21.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YezhuModel;
@interface YezhushowTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel* leftLa;
@property(nonatomic,strong)UILabel* rightLa;
//@property(nonatomic,strong)UIImageView* rightImage;
-(void)getValueModel:(YezhuModel*)model cellIndex:(NSIndexPath*)indexPath;
@end
