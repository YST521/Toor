//
//  RequestManger.m
//  WiseAPP
//
//  Created by yst911521 on 2016/11/22.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "RequestManger.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"


static RequestManger*requestmanger =nil;
@implementation RequestManger
+(RequestManger*)requstManger{
    static dispatch_once_t onceToken;
    
 
    dispatch_once(&onceToken, ^{
        if (!requestmanger) {
        requestmanger =[[RequestManger alloc]init];
        }

    });
        return requestmanger;
}
+(void)PostRequestUrl:(NSString*)UrlString Token:(NSString*)TokenString parmpar:(NSDictionary*)param succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure{
    //打开指示器
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    //[manger.requestSerializer setValue:TokenString forHTTPHeaderField:@"token"];
    
    [manger.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manger.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    if (TokenString == nil) {
       
        
        //@"1",self.addView.banciName.text,self.addView.starTime.text,self.addView.endTime.text];
        //把拼接后的字符串转换为data，设置请求体
        // request.HTTPBody=[paramm dataUsingEncoding:NSUTF8StringEncoding];
        
        [manger POST:UrlString parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            succeed(responseObject);
            //隐藏指示器
              [MBProgressHUD hideHUDForView:nil animated:YES];
            for (NSArray*array in [responseObject allValues]) {
                
                NSLog(@"班次添加数据:%@",array);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //隐藏指示器
            [MBProgressHUD hideHUDForView:nil animated:YES];
            failure(error);  
        }];

    } else {
       
    
        [manger.requestSerializer setValue:TokenString forHTTPHeaderField:@"token"];

        //把拼接后的字符串转换为data，设置请求体
        // request.HTTPBody=[paramm dataUsingEncoding:NSUTF8StringEncoding];
        
        [manger POST:UrlString parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //隐藏指示器
            [MBProgressHUD hideHUDForView:nil animated:YES];
            succeed(responseObject);
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //隐藏指示器
            [MBProgressHUD hideHUDForView:nil animated:YES];
            failure(error);
        }];

    }
}

+(void)GetWithUrl:(NSString*)UrlString Token:(NSString*)TokenString parmpar:(NSDictionary*)param succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure{
    //打开指示器
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    //    //请求参数拼接
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    // [manger.requestSerializer setValue:self.tokenString forHTTPHeaderField:@"token"];
    //
    //[manger.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manger.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        if (TokenString ==nil) {
            
           
            //      manger.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//            NSMutableDictionary*param=[NSMutableDictionary dictionary];
//            //   // [param setObject:@(1) forKey:@"Id"];
//            [param setObject:@(banciId) forKey:@"id"];
//            NSLog(@"BBBB%d",banciId);
//            //
            [manger GET:UrlString parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  succeed(responseObject);
                //隐藏指示器
                [MBProgressHUD hideHUDForView:nil animated:YES];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //隐藏指示器
                [MBProgressHUD hideHUDForView:nil animated:YES];
                failure(error);
            }];

        } else {
                           
            
           
            [manger.requestSerializer setValue:TokenString forHTTPHeaderField:@"token"];
            //
            //[manger.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [manger.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            //      manger.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//            NSMutableDictionary*param=[NSMutableDictionary dictionary];
//            //   // [param setObject:@(1) forKey:@"Id"];
//            [param setObject:@(banciId) forKey:@"id"];
//            NSLog(@"BBBB%d",banciId);
            //
            [manger GET:UrlString parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //隐藏指示器
                [MBProgressHUD hideHUDForView:nil animated:YES];
                  succeed(responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //隐藏指示器
                [MBProgressHUD hideHUDForView:nil animated:YES];
                failure(error);
            }];
   
    

            
        }
    
        
    
    }

+(void)UPLoadImageUrl:(NSString*)UrlString parmar:(NSDictionary*)parma token:(NSString*)tokenString imageData:(id)imagedata imageName:(id)imagename imageFileName:(id)imagefilename mimeType:(id)imagemineType succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure{
    
    if (tokenString ==nil) {
        //打开指示器
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        
        manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        manger.requestSerializer = [AFHTTPRequestSerializer serializer];
        //    manger.responseSerializer = [AFJSONResponseSerializer serializer];
       // [manger.requestSerializer setValue: self.tokenString forHTTPHeaderField:@"token"];
        
        //[manger.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [manger.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        // [manger.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manger.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",
                                                           @"text/html",
                                                           @"image/jpeg",
                                                           @"image/png",
                                                           @"application/octet-stream",
                                                           @"text/json", nil];
        
        
        //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        [manger POST:UrlString parameters:parma constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            
//            UIImage*image=[UIImage imageNamed:@"my_image"];
//            UIImage *image1 =[UIimageScaleImage scaleImage:image toKb:180];
//            NSData*data1=UIImagePNGRepresentation(image1);
            
            [formData appendPartWithFileData:imagedata name:imagename fileName:imagefilename mimeType:imagemineType];
            ;
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //隐藏指示器
            [MBProgressHUD hideHUDForView:nil animated:YES];
            succeed(responseObject);

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //隐藏指示器
            [MBProgressHUD hideHUDForView:nil animated:YES];
            failure(error);

        }];
        

    } else {
        //打开指示器
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        
        manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        manger.requestSerializer = [AFHTTPRequestSerializer serializer];
        //    manger.responseSerializer = [AFJSONResponseSerializer serializer];
        [manger.requestSerializer setValue: tokenString forHTTPHeaderField:@"token"];
        
        //[manger.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [manger.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        // [manger.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manger.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",
                                                           @"text/html",
                                                           @"image/jpeg",
                                                           @"image/png",
                                                           @"application/octet-stream",
                                                           @"text/json", nil];
        
        [manger POST:UrlString parameters:parma constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            
            //            UIImage*image=[UIImage imageNamed:@"my_image"];
            //            UIImage *image1 =[UIimageScaleImage scaleImage:image toKb:180];
            //            NSData*data1=UIImagePNGRepresentation(image1);
            
            [formData appendPartWithFileData:imagedata name:imagename fileName:imagefilename mimeType:imagemineType];
            ;
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //隐藏指示器
            [MBProgressHUD hideHUDForView:nil animated:YES];
            succeed(responseObject);
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //隐藏指示器
            [MBProgressHUD hideHUDForView:nil animated:YES];
            failure(error);
            
        }];
        
        
 
    }

}
#pragma makr - 开始监听网络连接
//
//+ (void)startMonitoring
//{
//    [[NSURLCache sharedURLCache] setMemoryCapacity:5 * 1024 * 1024];
//    [[NSURLCache sharedURLCache] setDiskCapacity:50 * 1024 * 1024];
//    
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    
//    // 设置网络状态变化回调
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusNotReachable:
//                
//                // 设置网络请求的缓存政策
//                manager.requestSerializer.cachePolicy =  NSURLRequestReturnCacheDataDontLoad;
//                NSLog(@"断网状态");
//                //                [UIAlertView showConfigPrompt:NSLocalizedString(@"当前没有网络，请检查你的网络设置", nil)];
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                
//                // 设置网络请求的缓存政策
//                manager.requestSerializer.cachePolicy =  NSURLRequestReturnCacheDataElseLoad;
//                NSLog(@"4G状态");
//                
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                
//                // 设置网络请求的缓存政策
//                manager.requestSerializer.cachePolicy =  NSURLRequestReloadIgnoringLocalCacheData;
//                NSLog(@"WiFi状态");
//                break;
//                
//            default:
//                break;
//        }
//    }];
//    
//    // 启动网络状态监听
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    
//}


/**
 *   取消所有正在执行的网络请求项
 */
//+ (void)cancelAllNetItems
//{
//    MHAsiNetworkHandler *handler = [MHAsiNetworkHandler sharedInstance];
//    [handler.items removeAllObjects];
//    handler.netWorkItem = nil;
//}



@end
