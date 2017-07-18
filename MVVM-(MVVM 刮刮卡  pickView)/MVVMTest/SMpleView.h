//
//  SMpleView.h
//  MVVMTest
//
//  Created by youxin on 2017/7/18.
//  Copyright © 2017年 李泽鲁. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewModel;

@interface SMpleView : UIView

@property(nonatomic,strong)UILabel*label;
@property(nonatomic,strong)UILabel*label2;

-(void)passModel:(ViewModel*)model;

@end
