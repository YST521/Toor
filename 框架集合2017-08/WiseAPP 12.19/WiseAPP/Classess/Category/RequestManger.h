//
//  RequestManger.h
//  WiseAPP
//
//  Created by yst911521 on 2016/11/22.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFNetworking;


@interface RequestManger : NSObject
@property(nonatomic,strong)NSString* netWorkType;
//block回调传值
/**
 *   请求成功回调json数据
 *
 *  @param json json串
 */
typedef void(^Success)(id json);
/**
 *  请求失败回调错误信息
 *
 *  @param error error错误信息
 */
typedef void(^Failure)(NSError *error);


+(RequestManger*)requstManger;
//post请求
+(void)PostRequestUrl:(NSString*)UrlString Token:(NSString*)TokenString parmpar:(NSDictionary*)param succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure;
//get请求
+(void)GetWithUrl:(NSString*)UrlString Token:(NSString*)TokenString parmpar:(NSDictionary*)param succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure;
//上传图片
+(void)UPLoadImageUrl:(NSString*)UrlString parmar:(NSDictionary*)parma token:(NSString*)tokenString imageData:(id)imagedata imageName:(id)imagename imageFileName:(id)imagefilename mimeType:(id)imagemineType succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure;

//监听网络
+ (void)startMonitoring;
/**
 *   取消所有正在执行的网络请求项
 */
+ (void)cancelAllNetItems;


@end
