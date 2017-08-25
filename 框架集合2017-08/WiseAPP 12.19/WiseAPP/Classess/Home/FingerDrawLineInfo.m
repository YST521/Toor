//
//  FingerDrawLineInfo.m
//  jiantou
//
//  Created by app on 16/11/8.
//  Copyright © 2016年 i. All rights reserved.
#import "FingerDrawLineInfo.h"

@implementation FingerDrawLineInfo

- (instancetype)init {
    if (self=[super init]) {
        self.linePoints = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
    return self;
}

@end
