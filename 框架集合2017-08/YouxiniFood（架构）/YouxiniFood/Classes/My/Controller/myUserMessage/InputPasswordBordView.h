//
//  InputPasswordBordView.h
//  YouxiniFood
//
//  Created by youxin on 2017/8/3.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>


@class InputPasswordBordView;




@protocol  PassWordViewDelegate<NSObject>

@optional
/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(InputPasswordBordView *)passWord ;

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(InputPasswordBordView *)passWord inPutStr:(NSString*)intputSreing;

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(InputPasswordBordView *)passWord ;


@end

IB_DESIGNABLE

@interface InputPasswordBordView : UIView<UIKeyInput>
- (BOOL)canBecomeFirstResponder;
@property (assign, nonatomic) IBInspectable NSUInteger passWordNum;//密码的位数
@property (assign, nonatomic) IBInspectable CGFloat squareWidth;//正方形的大小
@property (assign, nonatomic) IBInspectable CGFloat pointRadius;//黑点的半径
@property (strong, nonatomic) IBInspectable UIColor *pointColor;//黑点的颜色
@property (strong, nonatomic) IBInspectable UIColor *rectColor;//边框的颜色
@property (weak, nonatomic) id<PassWordViewDelegate> delegate;

@property (strong, nonatomic) NSMutableString *textStore;//保存密码的字符串

@end
