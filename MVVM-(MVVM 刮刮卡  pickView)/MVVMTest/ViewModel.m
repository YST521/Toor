//
//  ViewModel.m
//  MVVMTest
//
//  Created by youxin on 2017/7/18.
//  Copyright © 2017年 李泽鲁. All rights reserved.
//

#import "ViewModel.h"
#import "Animal.h"
#import "SMpleView.h"

@implementation ViewModel

- (void)animal:(Animal *)animal{

//    if (self =[super init]) {
        _animal = animal;
        _hh = self.animal.hibby;
        _gg = self.animal.gender;
    
    
        
}

        
//    }
//    
//    return  self;
//}

@end
