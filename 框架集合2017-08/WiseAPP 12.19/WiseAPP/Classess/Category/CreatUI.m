//
//  CreatUI.m
//  WiseAPP
//
//  Created by yst911521 on 2016/11/30.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "CreatUI.h"

@implementation CreatUI
+(UIView *)createViewFrame:(CGRect)frame backgroundColor:(UIColor *)color{
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}
+ (UILabel*)createLableFrame:(CGRect)frame  backgroundColor:(UIColor *)color  text:(NSString *)str  textColor:(UIColor *)textcolor font:(UIFont *)font  numberOfLines:(int)numberOfLines adjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth{
    
    UILabel*lable = [[UILabel alloc]initWithFrame:frame];
    
    lable.backgroundColor = color;
    lable.text = str;
    lable.textColor =textcolor;
    lable.font = font;
    lable.numberOfLines = numberOfLines;
    lable.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
    return lable;
}
+(UIImageView *)creatImageViewFrame:(CGRect)frame image:(UIImage *)image{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    [imageView setImage:image];
    return  imageView;
    
}
+(UIButton *)creatButtonFrame:(CGRect )frame   backgroundColor:(UIColor*)color setTitle:(NSString *)title  setTitleColor:(UIColor *)TitleColor   addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TitleColor forState:UIControlStateNormal];
    
    button.backgroundColor = color;
    
    [button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    
    return button;
}
+(UIButton *)creatButtonFrame:(CGRect )frame   backgroundColor:(UIColor*)color    addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
    
    [button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    
    return button;
}
+(UIButton *)creatButtonFrame:(CGRect )frame  setBackgroundImage:(UIImage *)image  setTitle:(NSString *)title setTitleColor:(UIColor *)TitleColor   addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TitleColor forState:UIControlStateNormal];
    [button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    
    return button;
    
}
+(UIImageView *)creatImageViewFrame:(CGRect)frame imageName:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    UIImage *image = [UIImage imageNamed:imageName];
    [imageView setImage:image];
    return imageView;
    
}
//创建textField,无图片，有密码。
+(UITextField *)createTextFieldFrame:(CGRect )frame backgroundColor:(UIColor*)color secureTextEntry:(BOOL)secureTextEntry    placeholder:(NSString *)str clearsOnBeginEditing:(BOOL)clearsOnBeginEditing {
    
    UITextField *textField = [[UITextField alloc]init];
    textField.frame = frame ;
    textField.backgroundColor = color;
    textField.secureTextEntry =secureTextEntry;
    //textField.borderStyle = UITextBorderStyleLine;
    textField.placeholder = str;
    textField.clearsOnBeginEditing =clearsOnBeginEditing;
    return textField;
    
}
//创建textField,无图片，无密码。
+(UITextField *)createTextFieldFrame:(CGRect )frame backgroundColor:(UIColor*)color   placeholder:(NSString *)str clearsOnBeginEditing:(BOOL)clearsOnBeginEditing  {
    
    UITextField *textField = [[UITextField alloc]init];
    textField.frame = frame ;
    textField.backgroundColor = color;
    //textField.borderStyle = UITextBorderStyleLine;
    textField.placeholder = str;
    textField.clearsOnBeginEditing =clearsOnBeginEditing;
    
    return textField;
}
//创建textField,有图片，无密码。
+(UITextField *)createTextFieldFrame:(CGRect )frame background:(UIImage *)image    placeholder:(NSString *)str clearsOnBeginEditing:(BOOL)clearsOnBeginEditing {
    
    UITextField *textField = [[UITextField alloc]init];
    textField.frame = frame ;
    textField.background = image ;
    //textField.borderStyle = UITextBorderStyleLine;
    textField.placeholder = str;
    textField.clearsOnBeginEditing =clearsOnBeginEditing;
    
    return textField;
}

//创建textField,有图片，有密码。
+(UITextField *)createTextFieldFrame:(CGRect )frame background:(UIImage *)image secureTextEntry:(BOOL)secureTextEntry   placeholder:(NSString *)str clearsOnBeginEditing:(BOOL)clearsOnBeginEditing  {
    UITextField *textField = [[UITextField alloc]init];
    textField.frame = frame ;
    textField.background = image ;
    textField.secureTextEntry =secureTextEntry;
    // textField.borderStyle = UITextBorderStyleLine;
    textField.placeholder = str;
    textField.clearsOnBeginEditing =clearsOnBeginEditing;
    return textField;
    
}
@end
