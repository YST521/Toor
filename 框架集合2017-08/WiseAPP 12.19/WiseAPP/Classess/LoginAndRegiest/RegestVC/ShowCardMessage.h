//
//  ShowCardMessage.h
//  WiseAPP
//
//  Created by app on 16/10/17.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDCardModel.h"

@interface ShowCardMessage : UIView
@property(nonatomic,strong)UIImageView* userImage;
@property(nonatomic,strong)UILabel* userName;
@property(nonatomic,strong)UILabel* userGender;
@property(nonatomic,strong)UILabel* userNation;
@property(nonatomic,strong)UILabel* userDate;
@property(nonatomic,strong)UILabel* userAdress;
@property(nonatomic,strong)UILabel*  userIDnum;
@property(nonatomic,strong)UILabel* userVisa;
@property(nonatomic,strong)UILabel* userVisaDate;

@property(nonatomic,strong)UIButton*backBtn;
@property(nonatomic,strong)UIButton*doneBtn;

@property(nonatomic,strong)IDCardModel*showModel;


@end
