//
//  EnjoyCollectionViewCell.m
//  YouxiniFood
//
//  Created by 何青 on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "EnjoyCollectionViewCell.h"
#import "LikeTableViewCell.h"

@implementation EnjoyCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = CardLayerCornerRadius;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.3;
        self.layer.masksToBounds = YES;
        
        UIView *titleView  = [[UIView alloc] initWithFrame:CGRectMake(15, 10, 18, 13)];
        titleView.backgroundColor = ColorFromRGB_255(141, 255, 14, 1);
        titleView.layer.cornerRadius = 3;
        titleView.clipsToBounds = YES;
        [self.contentView addSubview:titleView];
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(titleView.right + 5, 15, self.frame.size.width -titleView.width - 35, 25)];
        titleLable.text = @"猜你喜欢";
        titleLable.textColor = UIColorFromRGB(0x999999);
        if (IS_IPHONE5 || IS_IPHONE4S) {
            titleLable.font = [UIFont systemFontOfSize:14];
        }else if (IS_IPHONE6){
            titleLable.font = [UIFont systemFontOfSize:15];
        }else{
            titleLable.font = [UIFont systemFontOfSize:16];
        }
        [self.contentView addSubview:titleLable];
        titleView.centerY = titleLable.centerY;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleLable.bottom, self.frame.size.width, self.frame.size.height-40) style:UITableViewStylePlain];
        [self.tableView registerNib:[UINib nibWithNibName:@"LikeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableFooterView = [[UIView alloc] init];
        [self.contentView  addSubview:self.tableView];
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isTwo = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(enjoyCellDidSelectRow:)]) {
        [self.delegate enjoyCellDidSelectRow:indexPath.row];
    }
}



@end
