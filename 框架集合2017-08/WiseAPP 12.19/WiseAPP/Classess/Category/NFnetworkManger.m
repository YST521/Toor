//
//  NFnetworkManger.m
//  WiseAPP
//
//  Created by app on 16/10/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "NFnetworkManger.h"

@implementation NFnetworkManger
// 解析
- (void)jsonParserWithData :(NSData *)data
{
    id receiveResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] ;
    // 通过代理将解析好的数据传递出去
    //[self.delegate passValueWithData:receiveResult] ;
}

// 同步连接的get请求
- (void)getAndSynchronousMethodWithURL : (NSString *)urlString
{
    // 定义一个URL网址
    NSURL *url = [NSURL URLWithString:urlString] ;
    // 初始化请求方式,默认为get方式
    NSURLRequest *request = [NSURLRequest requestWithURL:url] ;
    // 创建同步链接
    // request : 请求对象,里边承载着我们的请求信息,有网址,请求头等信息
    // response : 请求的返回(响应),里面包含了响应头的一些信息,如果需要用到响应头,需要传递此参数,一般不需要.
    // error:请求出错的时候,会有错误信息保存在该参数中,一般置为nil就可以,咱们可以根据返回数据来判断是否请求有问题.
    NSError *error ;
    NSData *receiveData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error] ;
    [self jsonParserWithData:receiveData] ;
}

// 同步连接的post请求
- (void)postAndSynchronousMethodWithURL : (NSString *)urlString parameterString : (NSString *)parameterString
{
    //date=20151031&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213
    NSURL *url = [NSURL URLWithString:urlString] ;
    // 将string类型转换为NSDate类型.
    NSData *postParameter = [parameterString dataUsingEncoding:NSUTF8StringEncoding] ;
    // 创建请求,因为NSURLRequest类型不能设置请求方式,所以如果是post请求,就得使用它的子类NSMutableURLRequest
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url] ;
    // 设置请求方式
    mutableRequest.HTTPMethod = @"POST" ;
    // 设置请求参数
    mutableRequest.HTTPBody = postParameter ;
    // 创建同步连接
    NSError *error ;
    NSData *receiveData = [NSURLConnection sendSynchronousRequest:mutableRequest returningResponse:nil error:&error] ;
    [self jsonParserWithData:receiveData] ;
}

// 异步连接的get请求 block实现
- (void)getAndAsynchronousMethodWithURL : (NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString] ;
    NSURLRequest *request = [NSURLRequest requestWithURL:url] ;
    // 异步连接 block实现
    // queue :需要将请求连接放到一个队列中,目前我们是将该请求放到主队列中,在主队列中,操作所占有资源的优先等级更高,说白了就是请求会更快.
    // handle : 请求有返回结果的时候,会执行该block回调.
    /*
     block中参数解释:
     NSURLResponse _Nullable response:请求返回的响应,内部包含响应头
     NSData * _Nullable data : 使我们所需要的实际数据,也就是我们所需要的解析数据
     NSError * _Nullable connectionError : 请求出错的时候返回的错误信息.
     */
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError)
     {
         [self jsonParserWithData:data] ;
     }];
}

// 异步连接的post请求 block实现
- (void)postAndAsynchronousMethodWithURL :(NSString *)urlString parameterString : (NSString *)parameterString
{
    
    NSURL *url = [NSURL URLWithString:urlString] ;
    NSData *postParameter = [parameterString dataUsingEncoding:NSUTF8StringEncoding] ;
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url] ;
    mutableRequest.HTTPBody = postParameter ;
    mutableRequest.HTTPMethod = @"POST" ;
    [NSURLConnection sendAsynchronousRequest:mutableRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError)
     {
         [self jsonParserWithData:data] ;
     }] ;
}
@end
