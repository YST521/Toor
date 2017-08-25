//
//  WaitPayCell.h
//  YouxiniFood
//
//  Created by youxin on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol cellClickQrActionDelegate <NSObject>

- (void)qrBtnClickAction:(id)sel;

- (void)allAddressClickAction:(id)sel;

@end

@interface WaitPayCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView  *bgView;
@property(nonatomic ,assign) CGFloat cellHight;
@property(nonatomic,strong)UIImageView *foodImageV;
@property(nonatomic,strong)UILabel     *foodNameLa;
@property(nonatomic,strong)UILabel     *foodNumLa;
@property(nonatomic,strong)UILabel     *foodPriceLa;

@property(nonatomic,weak) id<cellClickQrActionDelegate> OrcalCellQrDelegate;
@end
