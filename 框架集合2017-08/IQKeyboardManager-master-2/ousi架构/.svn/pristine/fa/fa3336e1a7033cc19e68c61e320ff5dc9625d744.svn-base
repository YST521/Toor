//
//  BaseApiResult.h
//  Hjxq
//
//  Created by 吴瑞洲 on 15/12/23.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "BaseModel.h"

#define RLT [result.result intValue]

@interface BaseApiResult : BaseModel

@property (nonatomic, strong) NSNumber *result;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) id data;
@property (nonatomic, retain) NSArray *rows;

@property (nonatomic, strong) NSError *error;

@property (nonatomic, strong) NSString *jsessionid;

@property (nonatomic, strong) NSNumber *servertime;
@property (nonatomic, strong) NSString *extraData;
@property (nonatomic, strong) NSString *reason;

- (int)rspResult;

@end
