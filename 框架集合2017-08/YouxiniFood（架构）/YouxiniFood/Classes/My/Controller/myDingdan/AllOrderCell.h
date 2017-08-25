//
//  AllOrderCell.h
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

@interface AllOrderCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView  *bgView;
@property(nonatomic ,assign) CGFloat cellHight;
@property(nonatomic ,assign) CGFloat foodTabviewH;

@property(nonatomic,strong)UIImageView  *addresssImageV;
@property(nonatomic ,strong)UIButton    *addressBtn;
@property(nonatomic,strong)UILabel      *orderStatusLa;
@property(nonatomic,strong)UILabel      *adressBtnLa;

@property(nonatomic,strong)UITableView  *foodTabview;
@property(nonatomic,strong)UIView       *squreView;
@property(nonatomic,strong)UILabel      *dateLa;

@property(nonatomic,strong)UILabel   *totalLa;

@property(nonatomic,weak) id<cellClickQrActionDelegate> OrcalCellQrDelegate;

@end
