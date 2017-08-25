//
//  NFnetworkManger.h
//  WiseAPP
//
//  Created by app on 16/10/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NFnetworkManger : NSObject
//@property (nonatomic,assign)id<NetWorkingHelperDelegate>delegate ;
// 同步get
- (void)getAndSynchronousMethodWithURL : (NSString *)urlString ;
// 同步post
- (void)postAndSynchronousMethodWithURL : (NSString *)urlString parameterString : (NSString *)parameterString ;
// 异步get block实现
- (void)getAndAsynchronousMethodWithURL : (NSString *)urlString ;
// 异步post  block实现
- (void)postAndAsynchronousMethodWithURL :(NSString *)urlString parameterString : (NSString *)parameterString ;
@end
