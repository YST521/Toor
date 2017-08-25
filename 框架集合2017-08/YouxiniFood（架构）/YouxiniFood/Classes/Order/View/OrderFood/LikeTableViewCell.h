//
//  LikeTableViewCell.h
//  YouxiniFood
//
//  Created by 何青 on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  LikeTableViewCellDelegate <NSObject>

- (void)LikeTableViewCelldidSelectClickBuyBtn:(NSInteger)index;

@end

@interface LikeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *discountLable;
@property (weak, nonatomic) IBOutlet UILabel *surplusLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (nonatomic,assign) BOOL isTwo;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (nonatomic,assign) id <LikeTableViewCellDelegate> delegate;
- (IBAction)buyAction:(UIButton *)sender;
@property (nonatomic,assign)NSInteger index;
@end
