//
//  AffMenger.h
//  WiseAPP
//
//  Created by app on 16/10/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AffMenger : NSObject
typedef void(^complete)(id json, NSError* error);

+(void)AFNetworkPOSTurl:(NSString *)urlString paraments:(NSDictionary *)dic complete:(complete)complete;
@end
