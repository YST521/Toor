//
//  MyLayout.m
//  SoHeroAttendanceAPP
//
//  Created by 冯佳玉 on 16/9/26.
//  Copyright © 2016年 冯佳玉. All rights reserved.
//

#import "MyLayout.h"



@implementation MyLayout
- (instancetype)init{
    if (self = [super init]) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.itemSize = CGSizeMake((width-6)/7, (width-6)/7);
        self.minimumLineSpacing = 1;
        self.minimumInteritemSpacing = 1;
    }
    return self;
}
@end
