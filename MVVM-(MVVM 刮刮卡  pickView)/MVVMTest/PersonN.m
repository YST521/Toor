    //
    //  PersonN.m
    //  MVVMTest
    //
    //  Created by youxin on 2017/7/17.
    //  Copyright © 2017年 李泽鲁. All rights reserved.
    //

    #import "PersonN.h"

    @implementation PersonN

    -(instancetype)initWithSalutationfirstName:(NSString *)firstName Age:(NSString *)age{
        if ((self = [super init])) {
          self.name = @"666";
          self.age = @"18";
        
        firstName= self.name;
        age = self.age;
        }
        return self;
    }

    -(NSString*)name{
    return @"666";
    }

    -(NSString *)age{
    return @"18";
    }


    @end
