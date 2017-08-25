//
//  APIHelper.m
//  BsApi
//
//  Created by WuRuizhou on 14-12-29.
//  Copyright (c) 2014年 WuRuizhou. All rights reserved.
//

#import "APIHelper.h"
#import "BaseApiResult.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"

#import <SystemConfiguration/CaptiveNetwork.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <net/if.h>
#import <ifaddrs.h>
#import <dlfcn.h>


#import "XmlApiResult.h"
//#import "AFXMLRequestSerializer.h"


#define Notification_LoginSuccess   @"_login_get_session_success"
#define Notification_LoginFail      @"_login_get_session_fail"

#define RereqUrl                    @"keyreqsd"
#define RereqParams                 @"keyreqdsaf"
#define RereqCom                    @"dsajflka"
#define RereqCls                    @"sd fsa"

NSMutableDictionary *waitToReqs;

@implementation CheckNetworkCell

@end

@implementation APIHelper

static NSString *serviceStr, *imgServiceStr;

static NSString *sessionID;
static long long resetSessionTime;

static int failCount;

static long long serviceTime;

#define Test
//#define neibu

+ (void)setService:(NSString*)str
{
    serviceStr = str;
    
    if (! serviceStr) {
#ifdef Test
        serviceStr = TestServiceUrl;
#elif defined   neibu
        serviceStr = @"http://192.191.1.5:8889";
#else
        serviceStr = ZhengshiServiceUrl;
#endif
    }
}

+ (NSString*)getService
{
    return serviceStr;
}

+ (void)setImgService:(NSString*)str
{
    imgServiceStr = str;
    
    if (! imgServiceStr) {
#ifdef Test
        imgServiceStr = @"";
#elif defined   neibu
        imgServiceStr = @"";
#else
        imgServiceStr = @"";
#endif
    }
}

+ (NSString*)getImgService
{
    return imgServiceStr;
}

+ (NSString*)getSessionID
{
    return sessionID;
}

+ (long long)getServiceTime
{
    if (serviceTime < 1000*1000) {
        return [NSDate date].timeIntervalSince1970;
    }
    return serviceTime;
}

+ (void)setSessionID:(NSString*)session
{
    if (! session) {
        sessionID = nil;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:CacheSessionID];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else if (! [sessionID isEqualToString:session]) {
        sessionID = session;
        
        [[NSUserDefaults standardUserDefaults] setObject:sessionID forKey:CacheSessionID];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSDictionary *properties =  [NSDictionary dictionaryWithObjectsAndKeys:sessionID, NSHTTPCookieValue, @"JSESSIONID", NSHTTPCookieName, @"/", NSHTTPCookiePath, @"120.76.209.20", NSHTTPCookieDomain, nil];
        if ([[APIHelper getService] isEqualToString:TestServiceUrl] ||[[APIHelper getService] isEqualToString:DevelopmentServiceUrl] || [[APIHelper getService] isEqualToString:ZhengshiServiceUrl]) {
            properties =  [NSDictionary dictionaryWithObjectsAndKeys:sessionID, NSHTTPCookieValue, @"JSESSIONID", NSHTTPCookieName, @"/", NSHTTPCookiePath, @"120.236.71.202", NSHTTPCookieDomain, nil];
            if ([[APIHelper getService] isEqualToString:ZhengshiServiceUrl]) {
                properties =  [NSDictionary dictionaryWithObjectsAndKeys:sessionID, NSHTTPCookieValue, @"JSESSIONID", NSHTTPCookieName, @"/", NSHTTPCookiePath, @"ousi.iyouxin.com", NSHTTPCookieDomain, nil];
            }
        }
        NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:properties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
        NSLog(@"设置COOKIE ， %@", cookieuser);
    }
    
    NSLog(@"set session = %@", session);
    
    
}

+ (void)requestWithUrl:(NSString*)url
                pramas:(NSDictionary*)pramas
                method:(Youxin_Method)method
       CompletionBlock:(ApiCompletionBlock)CompletionBlock
{
    [APIHelper requestWithUrl:url pramas:pramas method:method className:nil CompletionBlock:CompletionBlock];
}


+ (void)requestWithUrl:(NSString*)url
                pramas:(NSDictionary*)pramas
       CompletionBlock:(ApiCompletionBlock)CompletionBlock
{
    [APIHelper requestWithUrl:url pramas:pramas method:POST className:nil CompletionBlock:CompletionBlock];
}

+ (void)requestWithUrl:(NSString*)url
                pramas:(NSDictionary*)pramas
                method:(Youxin_Method)method
             className:(NSString*)clsName
       CompletionBlock:(ApiCompletionBlock)CompletionBlock
{
    NSString *reqStr = [NSString stringWithFormat:@"%@%@", ServiceUrl, url];
    
    NSMutableDictionary *dicTemp = [NSMutableDictionary dictionary];
    if (pramas) {
        dicTemp = [NSMutableDictionary dictionaryWithDictionary:pramas];
    }
    
    [dicTemp setObject:@"ios" forKey:@"devicetype"];

    NetworkStatus netStatus = ((AppDelegate*)[UIApplication sharedApplication].delegate).netStatus;
    if (netStatus == NotReachable) {
        
    } else if (netStatus == ReachableViaWiFi) {
        [dicTemp setObject:@"wifi" forKey:@"nettype"];
        NSString *ssid = [APIHelper getWifiName];
        if (ssid) {
            [dicTemp setObject:ssid forKey:@"ssid"];
        }
        NSString *apmac = [APIHelper getWifiMac];
        if (apmac) {
            [dicTemp setObject:apmac forKey:@"apdevicemac"];
        }
    } else if (netStatus == ReachableViaWWAN) {
        [dicTemp setObject:@"3g" forKey:@"nettype"];
    }
    
    NSString *userip = [APIHelper localWiFiIPAddress];
    if (userip) {
        [dicTemp setObject:userip forKey:@"userip"];
    }
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (app_Version.length) {
        [dicTemp setObject:app_Version forKey:@"versionname"];
    }
    
    pramas = dicTemp;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *rs = [AFHTTPRequestSerializer serializer];
    
    if (! sessionID) {
        NSString* sessionIDttt = [[NSUserDefaults standardUserDefaults] objectForKey:CacheSessionID];
        [APIHelper setSessionID:sessionIDttt];
    }
    
    
    if (sessionID && ![url isEqualToString:@"/rest/signin"]) {
        NSString *sid = [NSString stringWithFormat:@"JSESSIONID=%@", sessionID];
        [rs setValue:sid forHTTPHeaderField:@"Cookie"];
    }
    
    manager.requestSerializer = rs;

    [manager POST:reqStr parameters:pramas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
        NSHTTPURLResponse *urlRsp = task.response;
        
        NSString* temp = urlRsp.allHeaderFields[@"Set-Cookie"];
        
        if ([temp isKindOfClass:[NSString class]]) {
            NSArray *arr = [temp componentsSeparatedByString:@"; "];
            if (arr.count) {
                for (NSString *str in arr) {
                    NSArray *kv = [str componentsSeparatedByString:@"="];
                    if (kv.count == 2 && [kv[0] isEqualToString:@"JSESSIONID"]) {
                        [APIHelper setSessionID:kv[1]];
                        break;
                    }
                }
            }
        }
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSInteger responseStatusCode = urlRsp.statusCode;
            
            Class cls = NSClassFromString(@"BaseApiResult");
            if (clsName) {
                cls = NSClassFromString(clsName);
            }
            BaseApiResult *rlt = [[cls alloc] init];
            [rlt setAttr:responseObject];
            if (rlt.servertime && ![rlt.servertime isKindOfClass:[NSNull class]]) {
                serviceTime = [rlt.servertime longLongValue]/1000;
            }
            if (rlt.jsessionid.length) {
                [APIHelper setSessionID:rlt.jsessionid];
            }
            CompletionBlock(rlt);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSHTTPURLResponse *urlRsp = task.response;
        
        NSLog(@"%s   %@\n\n", __func__, error);
        
        NSInteger responseStatusCode = urlRsp.statusCode;
        
        if (responseStatusCode == 901) {
            static bool isLoginLoding = NO;
            static NSMutableArray   *waitLoginCpts;
            static NSTimeInterval   requestTime = 0;
            
            
            if (isLoginLoding && [NSDate date].timeIntervalSince1970 - requestTime > 20) {
                NSLog(@"isLoginLoding = YES 且超时，清理数据");
                
                isLoginLoding = NO;
                
                BaseApiResult *rlt = [[BaseApiResult alloc] init];
                rlt.result = @(901);
                rlt.message = @"";
                
                for (NSDictionary *dic in waitLoginCpts) {
                    ApiCompletionBlock block = dic[RereqCom];
                    if (block) {
                        block(rlt);
                    }
                }
                
                [waitLoginCpts removeAllObjects];
            }
            
            if ( ! waitLoginCpts) {
                waitLoginCpts = [NSMutableArray array];
            }
            double tempTime = [NSDate date].timeIntervalSince1970;
            if (tempTime - resetSessionTime < 20) {
                [APIHelper requestWithUrl:url pramas:pramas method:POST className:clsName CompletionBlock:CompletionBlock];
                NSLog(@"*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=\n 刚刚登录过，直接重新请求 \n*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=");
                return ;
            }
            [waitLoginCpts addObject:@{RereqUrl:url, RereqParams:pramas?pramas:@{}, RereqCom:CompletionBlock, RereqCls:(clsName?clsName:@"")}];
            NSLog(@"\n=======================\n出现901   %@", [waitLoginCpts lastObject]);
            
            if (isLoginLoding) {
                return;
            }
            NSLog(@"901前往请求  %@\n=======================", [waitLoginCpts lastObject]);
            
            isLoginLoding = YES;
            
            if (failCount>0) {
                failCount = 0;
                
                BaseApiResult *rlt = [[BaseApiResult alloc] init];
                rlt.result = @(-1);
                rlt.message = @"";
                
                CompletionBlock(rlt);
                return ;
            }
            failCount ++;
            
            /*
            [APIHelper loginWithUsername:[OusiUserInfo instance].bus_manageuser_username
                                password:[OusiUserInfo instance].pwd
                                  domain:[OusiUserInfo instance].bus_manageuser_domain
                         CompletionBlock:^(BaseApiResult *result) {
                             if (result.rspResult == 1) {
//                                 [[NSNotificationCenter defaultCenter] postNotificationName:Notification_LoginSuccess object:nil];
                                 if ([result.data isKindOfClass:[NSString class]] && ((NSString*)result.data).length > 0) {
                                     NSLog(@"登录成功，设置会话");
                                     [APIHelper setSessionID:result.data];
                                     resetSessionTime = [NSDate date].timeIntervalSince1970;
                                 }
                                 
//                                 if ([result.data isKindOfClass:[NSDictionary class]]) {
//                                     [[OusiUserInfo instance] setAttr:result.data];
//                                 }
                                 if (waitLoginCpts) {
                                     failCount = 0;
                                     isLoginLoding = NO;
                                     
                                     for (NSDictionary *dic in waitLoginCpts) {
                                         [APIHelper requestWithUrl:dic[RereqUrl] pramas:dic[RereqParams] method:POST className:((NSString*)dic[RereqCls]).length ? dic[RereqCls] : nil CompletionBlock:dic[RereqCom]];
                                     }
                                 }
//                                 [APIHelper requestWithUrl:url pramas:pramas method:method className:clsName CompletionBlock:CompletionBlock];
                             } else {
                                 [[NSNotificationCenter defaultCenter] postNotificationName:Notification_LoginFail object:nil];
                                 CompletionBlock(result);
                             }
                             
                             failCount = 0;
                             isLoginLoding = NO;
                         }];
            return ;*/
        } else {
            BaseApiResult *rlt = [[BaseApiResult alloc] init];
            rlt.result = @(-1);
            rlt.message = responseStatusCode == 404 ? @"404错误" : [NSString stringWithFormat:@"网络请求失败, responseStatusCode : %ld, errorCode : %ld", (long)responseStatusCode, (long)error.code];
            if (responseStatusCode > 499 || responseStatusCode < 600) {
                rlt.message = [NSString stringWithFormat:@"服务器异常, responseStatusCode : %ld, errorCode : %ld", (long)responseStatusCode, (long)error.code];
            }
            CompletionBlock(rlt);
        }
    }];
}


+ (void)requestWithUrl:(NSString*)url
                pramas:(NSDictionary*)pramas
             imageData:(NSData*)imageData
              fileName:(NSString*)fileName
     afCompletionBlock:(ApiCompletionBlock)CompletionBlock
{
    NSString *reqStr = [NSString stringWithFormat:@"%@%@",ServiceUrl, url];
    
    NSMutableDictionary *dicTemp = [NSMutableDictionary dictionary];
    if (pramas) {
        dicTemp = [NSMutableDictionary dictionaryWithDictionary:pramas];
    }
    
    [dicTemp setObject:@"ios" forKey:@"devicetype"];
    
    NetworkStatus netStatus = ((AppDelegate*)[UIApplication sharedApplication].delegate).netStatus;
    if (netStatus == NotReachable) {
        
    } else if (netStatus == ReachableViaWiFi) {
        [dicTemp setObject:@"wifi" forKey:@"nettype"];
        NSString *ssid = [APIHelper getWifiName];
        if (ssid) {
            [dicTemp setObject:ssid forKey:@"ssid"];
        }
        NSString *apmac = [APIHelper getWifiMac];
        if (apmac) {
            [dicTemp setObject:apmac forKey:@"apdevicemac"];
        }
    } else if (netStatus == ReachableViaWWAN) {
        [dicTemp setObject:@"3g" forKey:@"nettype"];
    }
    
    NSString *userip = [APIHelper localWiFiIPAddress];
    if (userip) {
        [dicTemp setObject:userip forKey:@"userip"];
    }
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (app_Version.length) {
        [dicTemp setObject:app_Version forKey:@"versionname"];
    }
    
    pramas = dicTemp;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *rs = [AFHTTPRequestSerializer serializer];
    
    if (! sessionID) {
        NSString* sessionIDttt = [[NSUserDefaults standardUserDefaults] objectForKey:CacheSessionID];
        [APIHelper setSessionID:sessionIDttt];
    }
    
    if (sessionID && ![url isEqualToString:@"/rest/signin"]) {
        NSString *sid = [NSString stringWithFormat:@"JSESSIONID=%@", sessionID];
        [rs setValue:sid forHTTPHeaderField:@"Cookie"];
    }
    
    manager.requestSerializer = rs;
    
    if (imageData && imageData.length) {
        [manager POST:reqStr parameters:pramas
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    if (imageData && imageData.length) {
        [formData appendPartWithFileData:imageData name:fileName.length ? fileName :@"onebigimage" fileName:fileName.length ? fileName : @"onebigimage" mimeType:@"image/jpeg"];
    }
}
             progress:^(NSProgress * _Nonnull uploadProgress) {
                 
             } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSHTTPURLResponse *urlRsp = (NSHTTPURLResponse*)task.response;
                 
                 NSString* temp = urlRsp.allHeaderFields[@"Set-Cookie"];
                 
                 if ([temp isKindOfClass:[NSString class]]) {
                     NSArray *arr = [temp componentsSeparatedByString:@"; "];
                     if (arr.count) {
                         for (NSString *str in arr) {
                             NSArray *kv = [str componentsSeparatedByString:@"="];
                             if (kv.count == 2 && [kv[0] isEqualToString:@"JSESSIONID"]) {
                                 [APIHelper setSessionID:kv[1]];
                                 break;
                             }
                         }
                     }
                 }
                 
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     NSInteger responseStatusCode = urlRsp.statusCode;
                     
                     Class cls = NSClassFromString(@"BaseApiResult");
                     BaseApiResult *rlt = [[cls alloc] init];
                     [rlt setAttr:responseObject];
                     
                     if (rlt.jsessionid.length) {
                         [APIHelper setSessionID:rlt.jsessionid];
                     }
                     CompletionBlock(rlt);
                 }
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"%s   %@\n\n", __func__, error);
                 
                 NSHTTPURLResponse *urlRsp = (NSHTTPURLResponse*)task.response;
                 
                 NSInteger responseStatusCode = urlRsp.statusCode;
                 BaseApiResult *rlt = [[BaseApiResult alloc] init];
                 rlt.result = @(-1);
                 rlt.message = responseStatusCode == 404 ? @"404错误" : [NSString stringWithFormat:@"网络请求失败, responseStatusCode : %ld, errorCode : %ld", (long)responseStatusCode, (long)error.code];
                 if (responseStatusCode > 499 || responseStatusCode < 600) {
                     rlt.message = [NSString stringWithFormat:@"服务器异常, responseStatusCode : %ld, errorCode : %ld", (long)responseStatusCode, (long)error.code];
                 }
                 CompletionBlock(rlt);
                 
             }];
    }
}


+ (void)requestWithUrl:(NSString*)url
                pramas:(NSDictionary*)pramas
          arrImageData:(NSArray<NSData*>*)arrImageData
           arrFileName:(NSArray<NSString*>*)arrFileName
     afCompletionBlock:(ApiCompletionBlock)CompletionBlock
{
    NSString *reqStr = [NSString stringWithFormat:@"%@%@",ServiceUrl, url];
    
    NSMutableDictionary *dicTemp = [NSMutableDictionary dictionary];
    if (pramas) {
        dicTemp = [NSMutableDictionary dictionaryWithDictionary:pramas];
    }
    
    [dicTemp setObject:@"ios" forKey:@"devicetype"];
    
    NetworkStatus netStatus = ((AppDelegate*)[UIApplication sharedApplication].delegate).netStatus;
    if (netStatus == NotReachable) {
        
    } else if (netStatus == ReachableViaWiFi) {
        [dicTemp setObject:@"wifi" forKey:@"nettype"];
        NSString *ssid = [APIHelper getWifiName];
        if (ssid) {
            [dicTemp setObject:ssid forKey:@"ssid"];
        }
        NSString *apmac = [APIHelper getWifiMac];
        if (apmac) {
            [dicTemp setObject:apmac forKey:@"apdevicemac"];
        }
    } else if (netStatus == ReachableViaWWAN) {
        [dicTemp setObject:@"3g" forKey:@"nettype"];
    }
    
    NSString *userip = [APIHelper localWiFiIPAddress];
    if (userip) {
        [dicTemp setObject:userip forKey:@"userip"];
    }
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (app_Version.length) {
        [dicTemp setObject:app_Version forKey:@"versionname"];
    }
    
    pramas = dicTemp;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *rs = [AFHTTPRequestSerializer serializer];
    
    
    if (! sessionID) {
        NSString* sessionIDttt = [[NSUserDefaults standardUserDefaults] objectForKey:CacheSessionID];
        [APIHelper setSessionID:sessionIDttt];
    }
    
    if (sessionID && ![url isEqualToString:@"/rest/signin"]) {
        NSString *sid = [NSString stringWithFormat:@"JSESSIONID=%@", sessionID];
        [rs setValue:sid forHTTPHeaderField:@"Cookie"];
    }
    
    manager.requestSerializer = rs;
    
//    if (arrImageData && arrImageData.count) {
        [manager POST:reqStr parameters:pramas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (int i = 0; i < arrImageData.count; i++) {
                [formData appendPartWithFileData:arrImageData[i] name:arrFileName[i] fileName:arrFileName[i] mimeType:@"image/jpeg"];
            }
        }
             progress:^(NSProgress * _Nonnull uploadProgress) {
                 NSLog(@"xxxxx%@",uploadProgress);
                 
             } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSHTTPURLResponse *urlRsp = (NSHTTPURLResponse*)task.response;
                 
                 NSString* temp = urlRsp.allHeaderFields[@"Set-Cookie"];
                 
                 if ([temp isKindOfClass:[NSString class]]) {
                     NSArray *arr = [temp componentsSeparatedByString:@"; "];
                     if (arr.count) {
                         for (NSString *str in arr) {
                             NSArray *kv = [str componentsSeparatedByString:@"="];
                             if (kv.count == 2 && [kv[0] isEqualToString:@"JSESSIONID"]) {
                                 [APIHelper setSessionID:kv[1]];
                                 break;
                             }
                         }
                     }
                 }
                 
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     NSInteger responseStatusCode = urlRsp.statusCode;
                     
                     Class cls = NSClassFromString(@"BaseApiResult");
                     BaseApiResult *rlt = [[cls alloc] init];
                     [rlt setAttr:responseObject];
                     
                     if (rlt.jsessionid.length) {
                         [APIHelper setSessionID:rlt.jsessionid];
                     }
                     CompletionBlock(rlt);
                 }
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"%s   %@\n\n", __func__, error);
                 NSHTTPURLResponse *urlRsp = (NSHTTPURLResponse*)task.response;
                 
                 NSInteger responseStatusCode = urlRsp.statusCode;
                 BaseApiResult *rlt = [[BaseApiResult alloc] init];
                 rlt.result = @(-1);
                 rlt.message = responseStatusCode == 404 ? @"404错误" : [NSString stringWithFormat:@"网络请求失败, responseStatusCode : %ld, errorCode : %ld", (long)responseStatusCode, (long)error.code];
                 if (responseStatusCode > 499 || responseStatusCode < 600) {
                     rlt.message = [NSString stringWithFormat:@"服务器异常, responseStatusCode : %ld, errorCode : %ld", (long)responseStatusCode, (long)error.code];
                 }
                 CompletionBlock(rlt);
                 
             }];
//    }
}


+ (void)loginWithUsername:(NSString*)username
                 password:(NSString*)pwd
                   domain:(NSString*)domain
          CompletionBlock:(ApiCompletionBlock)CompletionBlock
{
    /*
    if (username && pwd && domain) {
        [APIHelper requestWithUrl:@"/rest/signin" pramas:@{@"username":username, @"password":pwd, @"domain": domain} method:GET className:nil CompletionBlock:^(BaseApiResult *result) {
            if (result.rspResult > 1 && result.rspResult < 100) {
                //
                [[OusiUserInfo instance] logout];
                
                LoginViewController *vc = [[LoginViewController alloc] init];
                HYBaseNavigationController *nav = [[HYBaseNavigationController alloc] initWithRootViewController:vc];
                [((AppDelegate*)[UIApplication sharedApplication].delegate).mainVC presentViewController:nav animated:YES completion:nil];
            } else {
                CompletionBlock(result);
            }
        }];
    } else {
        
        [[OusiUserInfo instance] logout];
        
        LoginViewController *vc = [[LoginViewController alloc] init];
        HYBaseNavigationController *nav = [[HYBaseNavigationController alloc] initWithRootViewController:vc];
        [((AppDelegate*)[UIApplication sharedApplication].delegate).mainVC presentViewController:nav animated:YES completion:nil];
    }*/
}

+ (NSString *) localWiFiIPAddress
{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            // the second test keeps from picking up the loopback address
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"])  // Wi-Fi adapter
                    return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return nil;
}


/**
 *  获取 wifi 的 MAC
 */
+ (NSString*)getWifiMac
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs)
    {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count])
        {
            break;
        }
    }
    NSString *strWifiName = [info objectForKey:@"BSSID"];
    NSArray *temp = [strWifiName componentsSeparatedByString:@":"];
    NSMutableString *mac = [[NSMutableString alloc] init];
    for (int i = 0; i < temp.count; i++) {
        NSString *str = temp[i];
        if (str.length == 1) {
            str = [NSString stringWithFormat:@"0%@", str];
        }
        
        if (i != temp.count - 1) {
            [mac appendFormat:@"%@:", str];
        } else {
            [mac appendString:str];
        }
    }
    return mac;
}

/**
 *  获取 wifi 名
 */
+ (NSString*)getWifiName
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs)
    {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count])
        {
            break;
        }
    }
    NSString *strWifiName = [info objectForKey:@"SSID"];
    return strWifiName;
}

@end













