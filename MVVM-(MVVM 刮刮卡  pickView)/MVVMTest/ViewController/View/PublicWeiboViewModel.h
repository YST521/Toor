//
//  PublicWeiboViewModel.h
//  MVVMTest
//
//  Created by 李泽鲁 on 15/1/8.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "PublicWeiboViewModel.h"
#import "PublicModel.h"



@interface PublicWeiboViewModel : NSObject

@property (strong, nonatomic) ReturnValueBlock returnBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;
@property (strong, nonatomic) FailureBlock failureBlock;

//获取网络的链接状态
- (void)netWorkStateWithNetConnectBlock:(NetWorkBlock) netConnectBlock
                             WithURlStr:(NSString *) strURl;

// 传入交互的Block块
- (void)setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock;

#pragma mark =======================================

/**
 获取围脖列表
 */
- (void)fetchPublicWeiBo;


/**
 跳转到微博详情页
 
 @param publicModel
 @param superController
 */
- (void) weiboDetailWithPublicModel:(PublicModel *) publicModel
                 WithViewController:(UIViewController *)superController;

@end
