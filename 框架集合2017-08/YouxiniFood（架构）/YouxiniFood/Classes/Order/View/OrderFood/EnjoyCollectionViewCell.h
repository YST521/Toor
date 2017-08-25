//
//  EnjoyCollectionViewCell.h
//  YouxiniFood
//
//  Created by 何青 on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EnjoyCollectionViewCellDelegate  <NSObject>

- (void)enjoyCellDidSelectRow:(NSInteger)row;

@end

@interface EnjoyCollectionViewCell : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *dataArr;
@property (nonatomic,assign)id <EnjoyCollectionViewCellDelegate>delegate;
@end
