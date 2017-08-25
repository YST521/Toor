//
//  MiaddressCell.h
//  YouxiniFood
//
//  Created by youxin on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellDelegate <NSObject>
- (void)defaultButtonDidSelected:(UIButton *)button;

-(void)delectBtnAction:(UIButton*)sender;
-(void)editBtnAction:(UIButton*)sender;

@end

@interface MiaddressCell : UITableViewCell

@property(nonatomic,strong)UILabel  *nameLa;
@property(nonatomic,strong)UILabel  *phoneNumLa;
@property(nonatomic,strong)UILabel  *addressLa;
@property(nonatomic,strong)UIButton *defauitBtn;
@property(nonatomic,strong)UIButton *deleteBtn;
@property(nonatomic,strong)UIButton *changeBtn;
@property(nonatomic,strong)UIImageView  *changeImageV;

@property(nonatomic,weak) id<CellDelegate> myDizhidelegate;

@end
