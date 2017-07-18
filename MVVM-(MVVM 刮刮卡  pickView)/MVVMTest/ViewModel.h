//
//  ViewModel.h
//  MVVMTest
//
//  Created by youxin on 2017/7/18.
//  Copyright © 2017年 李泽鲁. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Animal;

@interface ViewModel : NSObject

- (void)animal:(Animal *)animal;

@property(nonatomic,strong)Animal *animal;
@property(nonatomic,strong)NSString *hh;
@property(nonatomic,strong)NSString*gg;

@end
