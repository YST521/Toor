//
//  FoodFootView.h
//  YouxiniFood
//
//  Created by youxin on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRbuttonOrderlPage.h"


@interface FoodFootView : UIView

@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,strong)UILabel *qucanMaLa;
@property(nonatomic,strong)UILabel *efficientLa;
@property(nonatomic,strong)UIButton *qrStatusBtn;

 @property(nonatomic,strong) QRbuttonOrderlPage *qrBtn2;
 @property(nonatomic,strong) QRbuttonOrderlPage *qrBtn;
@end
