//
//  LoginAlterView.h
//  YouxiniFood
//
//  Created by 何青 on 2017/7/27.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginAlterView;

@protocol loginViewDelegate <NSObject>

- (void)loginAlterView:(LoginAlterView *)loginView didClickLoginButtonWithPhone:(NSString *)phone WithPassword:(NSString *)password;
- (void)loginAlterView:(LoginAlterView *)loginView didClickRegisteButtonWithPhone:(NSString *)phone WithPassword:(NSString *)password WithYzm:(NSString *)yzmStr WithDePassword:(NSString *)dePsw;
- (void)loginAlterView:(LoginAlterView *)loginView didClickForgetButtonWithPhone:(NSString *)phone;
- (void)loginAlterView:(LoginAlterView *)loginView didClickYzmButtonWithPhone:(NSString *)phone;
@end

@interface LoginAlterView : UIView
@property (nonatomic,strong)UIView  *contentView;
@property (nonatomic,assign)id <loginViewDelegate>delegate;
- (void)showInView:(UIView *)view;

@end
