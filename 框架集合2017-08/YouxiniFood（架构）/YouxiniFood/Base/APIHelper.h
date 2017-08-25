//
//  APIHelper.h
//  BsApi
//
//  Created by WuRuizhou on 14-12-29.
//  Copyright (c) 2014年 WuRuizhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseApiResult.h"
#import "XmlApiResult.h"


#define ZhengshiServiceUrl                  @""
#define DevelopmentServiceUrl               @""
#define TestServiceUrl                      @"http://120.236.71.202:8889"

#define ZhengshiImgServiceUrl               @""
#define DevelopmentImgServiceUrl            @""
#define TestImgServiceUrl                   @""

#define WebServiceUrl       [APIHelper getService]

typedef void (^ApiCompletionBlock)(BaseApiResult* result);
typedef void (^XmlApiCompletionBlock)(XmlApiResult* result);

typedef enum {
    GET,
    POST
} Youxin_Method;

typedef enum {
    NetWorkStatusRenzheng,
    NetWorkStatusError,
    NetWorkStatus399_901,
    NetWorkStatusLinkNoRenzheng,
    NetWorkStatus0Rsp,
} CheckNetworkStatus;

@class IpcInfo;
@interface CheckNetworkCell : NSObject

@property (nonatomic, assign) CheckNetworkStatus networkStatus;
@property (nonatomic, assign) int statusCode;
@property (nonatomic, assign) BOOL canLink;
@property (nonatomic, strong) NSString *statusMessage, *tipStr, *responseString;

@end

@interface APIHelper : NSObject

+ (void)setService:(NSString*)str;
+ (void)setImgService:(NSString*)str;
+ (NSString*)getService;
+ (NSString*)getImgService;

+ (NSString*)getSessionID;

+ (long long)getServiceTime;

+ (void)setSessionID:(NSString*)session;

+ (void)requestWithUrl:(NSString*)url
                pramas:(NSDictionary*)pramas
                method:(Youxin_Method)method
             className:(NSString*)clsName
       CompletionBlock:(ApiCompletionBlock)CompletionBlock;

+ (void)loginWithUsername:(NSString*)url
                 password:(NSString*)pwd
                   domain:(NSString*)domain
          CompletionBlock:(ApiCompletionBlock)CompletionBlock;

+ (void)requestWithUrl:(NSString*)url
                pramas:(NSDictionary*)pramas
                method:(Youxin_Method)method
       CompletionBlock:(ApiCompletionBlock)CompletionBlock;


+ (void)requestWithUrl:(NSString*)url
                pramas:(NSDictionary*)pramas
          arrImageData:(NSArray<NSData*>*)arrImageData
           arrFileName:(NSArray<NSString*>*)arrFileName
     afCompletionBlock:(ApiCompletionBlock)CompletionBlock;

+ (void)requestWithUrl:(NSString*)url
                pramas:(NSDictionary*)pramas
       CompletionBlock:(ApiCompletionBlock)CompletionBlock;


+ (void)requestWithUrl:(NSString*)url
                pramas:(NSDictionary*)pramas
             imageData:(NSData*)imageData
              fileName:(NSString*)fileName
     afCompletionBlock:(ApiCompletionBlock)CompletionBlock;

@end






