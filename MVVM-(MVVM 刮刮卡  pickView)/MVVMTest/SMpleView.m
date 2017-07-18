//
//  SMpleView.m
//  MVVMTest
//
//  Created by youxin on 2017/7/18.
//  Copyright © 2017年 李泽鲁. All rights reserved.
//

#import "SMpleView.h"
#import "ViewModel.h"

@implementation SMpleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.label =[[UILabel alloc]init];
        self.label.frame = CGRectMake(100, 100, 414/2, 40);
        self.label.backgroundColor = [UIColor greenColor];
        [self addSubview:self.label];
        
        self.label2 =[[UILabel alloc]init];
        self.label2.frame = CGRectMake(100, 200, 414/2, 40);
        self.label2.backgroundColor = [UIColor greenColor];
        [self addSubview:self.label2];
 
        
    }
    return self;
}

-(void)passModel:(ViewModel *)model{

    self.label.text = model.hh;
    self.label2.text = model.gg;
    
}


@end
