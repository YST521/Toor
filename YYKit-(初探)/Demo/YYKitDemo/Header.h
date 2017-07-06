//
//  Header.h
//  YYKitDemo
//
//  Created by youxin on 2017/6/29.
//  Copyright © 2017年 ibireme. All rights reserved.
//

#ifndef Header_h
#define Header_h


//YYKit使用    http://www.jianshu.com/p/6e25812af18e
//YYKit使用    http://www.jianshu.com/p/514ffb83868d
//常用宏定义  http://www.jianshu.com/p/18da3942b811?nomobile=yes
// 获取物理屏幕的宽度
#define SceneWidth (([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height) ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height)
// 获取物理屏幕的高度
#define SceneHeight (([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)
//判断字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//判断字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//判断是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
//获取屏幕宽度与高度
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
//一些缩写
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//手机型号
#define iPhone4S ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5S ([UIScreen mainScreen].bounds.size.height == 568)
#define iPhone6S ([UIScreen mainScreen].bounds.size.height == 667)
#define iPhone6pS ([UIScreen mainScreen].bounds.size.height == 736)
//开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif


#define SavePath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"/user.txt"])


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ScaleNumberWidth kScreenWidth/320
#define ScaleNumberHeight kScreenHeight/568
#define CarveHeight 1

#endif /* Header_h */
