//
//  MyControllerheadView.h
//  YouxiniFood
//
//  Created by youxin on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBtn.h"

@interface MyControllerheadView : UIView
@property(nonatomic,strong)UIView * userAdminView;
@property(nonatomic,strong)UIView * yueEFukuanView;

@property(nonatomic,strong)UIButton     *adminBtn;
@property(nonatomic,strong)UIImageView  *userIamgeView;
@property(nonatomic,strong)UILabel     *userNameLa;
@property(nonatomic,strong)UILabel     *userCompanyLa;
@property(nonatomic,strong)UIButton   *shouFunBtn;
@property(nonatomic,strong)UIButton    *fankaBtn;
@property(nonatomic,strong)UIButton    *qianbaoBtn;

@property(nonatomic,strong)UILabel *fankaLa;
@property(nonatomic,strong)UILabel *qianbaoLa;

@end
