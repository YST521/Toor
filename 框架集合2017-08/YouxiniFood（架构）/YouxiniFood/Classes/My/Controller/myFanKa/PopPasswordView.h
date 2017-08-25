//
//  PopPasswordView.h
//  YouxiniFood
//
//  Created by youxin on 2017/8/4.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputPasswordBordView.h"

@interface PopPasswordView : UIView<PassWordViewDelegate>
@property(nonatomic,strong)  InputPasswordBordView *wclV;
@property(nonatomic,strong) UILabel *alertLa ;
@property(nonatomic,strong) UIButton *pwcloseBtn;
@property(nonatomic,strong) UIButton *pwdoneBtn;
@property(nonatomic,strong) InputPasswordBordView *InpPw;
@end
