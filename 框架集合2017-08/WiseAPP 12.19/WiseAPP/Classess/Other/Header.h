//
//  Header.h
//  WiseAPP
//
//  Created by app on 16/10/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import "UIView+YSTExtension.h"
#import "AFNetworking.h"
#import "LoginRegistUIButton.h"
#import "SDCycleScrollView.h"
#import "CustomButton+Extension.h"

#import "CustomButton.h"
#import "CustonTextfile.h"
#import "URL+Header.h"
#import "NetWorkRequestManager.h"
#import "UIimageScaleImage.h"
#import "UIImage+cutImage.h"
#import "NSDate+extend.h"
#import "LDCalendarView.h"//日历

#import "NSDateYMD.h"
#import "CreatUI.h"

//常用第三方
#import "MBProgressHUD+Add.h"

#import "imageWithBorder.h"
#import <JSONModel/JSONModel.h>
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

//公共view
#import "PublieTableViewCell.h" //去填写cell
#import "POPView.h"     // 弹框
#import "TimeDHViewController.h"
#import "TimeYYMMDDViewController.h"

#import "ChangeImageViewController.h" //图片编辑
#import "WSImagePickerView.h"


#import "LDCalendarView.h" //日历
#import "NSDate+extend.h"

//单例
#import "SingleXiangmuxnxi.h"
#import "UserIDmanger.h"
#import "LocationHander.h"
#import "LoginMessageManger.h"
#import "RequestManger.h"

//AFnetwork
#ifdef DEBUG
#   define DTLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#else
#   define DTLog(...)
#endif

//#ifdef DEBUG
//#   define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
//#else
//#   define NSLog(...)
//#endif
//#ifdef DEBUG
//#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
//#else
//#define NSLog(format, ...)
//#endif


//常用宏定义
//NSlog
#ifdef DEBUG
#define YSTLog(...)NSLog(__VA_ARGS__)

#else
#define YSTLog(...)

#endif

//方法打印
#define YSTLogFunc   YSTLog(@"%s",__func__);


//xcode8不打印方法
//#ifdef DEBUG
//#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
//#else
//#define NSLog(format, ...)
//#endif

//imagename
#define TextfileBgWihter @"home_text_bg.png" //白色背景长输入框




//alreat
#define SHOW_ALERT(_msg_)  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:_msg_ delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];\
 [alert show];


//常用颜色设置
#define YSTRGBColor(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1];

#define YSTGlobBg  YSTRGBColor(223,223,223)
#define textBlueColor  YSTRGBColor(23,134,255)
#define textNationFont [UIFont systemFontOfSize:20]
#define textPlaceFont [UIFont systemFontOfSize:14]
#define TextCententFont [UIFont systemFontOfSize:17]

//通知
#define NoteCenter [NSNotificationCenter defaultCenter]

// 常量定义
#define kScreenWidth        [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight       [[UIScreen mainScreen] bounds].size.height
//屏幕宽高
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
//常用宽高
#define  UIScreenBpunds [[UIScreen mainScreen] bounds]

#define  STANDARDWH(num)  CGRectMake(STANDARD_X,num, STANDARD_WIDTH, STANDARD_HEIGHT)

//宽高比例换算
#define PROPORTION_WIDTH(num) (SCREEN_WIDTH/375*num)
#define PROPORTION_HIGHT(num)  (SCREEN_HEIGHT/667*num)

//常用宽高
#define STANDARD_X       PROPORTION_WIDTH(38)
#define STANDARD_WIDTH   SCREEN_WIDTH- PROPORTION_WIDTH(38*2)
#define STANDARD_HEIGHT  PROPORTION_HIGHT(45)
#define STANDRD_H_20_y      PROPORTION_HIGHT((45-20)/2)

#define kContentViewW  self.contentView.frame.size.width 
#define kContentViewH  self.contentView.frame.size.height
#define kContentViewY   PROPORTION_HIGHT((45-20)/2) //12.5 45



//图片
#define UIimageDef(num)    [UIImage imageNamed:num]
#define KUIbutton(btn)      [btn setBackgroundImage: [UIImage imageNamed:@"loginbutton.png"] forState:(UIControlStateNormal)];
 #define KUIbuttonClick(btn)  [btn setBackgroundImage:UIimageDef(@"loginbuttonclick.png") forState:(UIControlStateHighlighted)]


//常用颜色
#define YSTRGBColor(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1];

#define GlobBackGroundColor  YSTRGBColor(241,241,241)
#define MainColor  YSTRGBColor(23,134,255)
#define  textColorPlace   YSTRGBColor(153,153,153)
#define  textCententColor   YSTRGBColor(102,102,102)
#define  textTitleColor   YSTRGBColor(51,51,51)

#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//统一的按钮颜色和提交按钮的颜色
#define ButtonRGB [UIColor colorWithRed:62/255.0f green:171/255.0f blue:223/255.0f alpha:1.0]
#define CommitRGB [UIColor colorWithRed:237/255.0f green:89/255.0f blue:46/255.0f alpha:1.0]
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8

//弹框背景色
#define  popBGColore [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];


 //NSString*str=[NSString stringWithFormat:@"%@%@",self.LoginView.phoneNum.text,self.LoginView.password.text];

//http://118.178.88.132:8000/api/fetch_sms_code/verification
//URL 区域
//正式URL
//#define BASEURL @"http://118.178.88.132:8000/api";
////拼接关键字后url
////      接口路径全拼
//#define PATH(path)            [NSString stringWithFormat:@"%@%@",BASEURL,patch];
////登陆
//#define  URL_login       PATH(@"%@/login")
//#define  URL_code       PATH(@"%@/fect_sms_code")

//http://118.178.88.132:8000/api/fect_sms_code
//#define URL_BASE  @"http://boys.test.companydomain.com/api/"
//#define  URL_login(url)  [NSString stringWithFormat:@"%@%@",URL_BASEL,url]

//#endif /* ZQAPI_h */
//baseUrl




//常用字体
#define     KFont(size)         [UIFont systemFontOfSize:size]
#define     KFontBold(size)     [UIFont boldSystemFontOfSize:size]

#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64

typedef long NSInteger;
typedef unsigned long NSUInteger;
#else
typedef int NSInteger;
typedef unsigned int NSUInteger;
#endif


#endif /* Header_h */
