//
//  YezhuaddCell.h
//  WiseAPP
//
//  Created by yst911521 on 2016/12/10.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YezhuModel;
@interface YezhuaddCell : UITableViewCell
@property(nonatomic,strong)UILabel* leftLa;
@property(nonatomic,strong)UILabel* rightLa;
@property(nonatomic,strong)UIButton* rightImage;
-(void)getValueModel:(YezhuModel *)model cellIndex:(NSIndexPath *)indexPath UPpage:(NSInteger)nextPageType dataArray:(NSMutableArray*)dataArray;
@end
