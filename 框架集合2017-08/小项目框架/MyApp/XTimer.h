//
//  XTimer.h
//  XTimer
//
//  Created by xlx on 16/1/1.
//  Copyright © 2016年 xlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTimer : NSObject

@property  NSTimeInterval ti;
@property (nullable,weak) id atarget;
@property (nullable,nonatomic, assign) SEL aSelector;
@property (nullable, retain) id userInfo;


+ (nullable XTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(nullable id)aTarget selector:(nullable SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
//使用  XTimer *timer;
//http://blog.csdn.net/springjustin/article/details/50978671
//http://www.cocoachina.com/ios/20150519/11857.html
//  timer = [XTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(XTimerSelector:) userInfo:@{@"key":@"value"} repeats:true];


- (void)reStart;
- (void)stop;
- (void)invalidate;
@end
