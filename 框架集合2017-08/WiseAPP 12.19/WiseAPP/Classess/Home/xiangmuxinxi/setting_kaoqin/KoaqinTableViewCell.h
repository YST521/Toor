//
//  KoaqinTableViewCell.h
//  WiseAPP
//
//  Created by app on 16/12/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KaoqinModel;
@interface KoaqinTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel* leftLa;
@property(nonatomic,strong)UILabel* rightLa;
//@property(nonatomic,strong)UILabel* rightBgLa;
@property(nonatomic,strong)UIImageView* rightImage;
//-(void)getValueModel:(KaoqinModel *)model cellIndex:(NSIndexPath *)indexPath UPpage:(NSInteger)nextPageType dataArray:(NSMutableArray*)dataArray;
@end
