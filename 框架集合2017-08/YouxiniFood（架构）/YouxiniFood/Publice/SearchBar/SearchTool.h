//
//  SearchTool.h
//  yunwoke
//
//  Created by 史金亮 on 15/11/4.
//  Copyright © 2015年 Michael Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchTool : NSObject
@property (nonatomic, strong) NSMutableArray *SearchDataArray;

@property(nonatomic,strong)NSString *NSUserDefaultsKeyS;

/**
 *    添加搜索历史
 *    @param searchStr 新加的输入条目
 */
+ (void)addSearchRecord:(NSString *)searchStr NSUserDefaultsKey:(NSString*)keys ;

/**
 *    获取所有的搜索历史
 *    @return 搜索历史 字符数组
 */
+ (NSArray *)getAllSearchHistoryNSUserDefaultsKey:(NSString*)keys;

/**
 *    清空搜索历史
 */
+ (void)clearAllSearchHistoryNSUserDefaultsKey:(NSString*)keys;
@end
