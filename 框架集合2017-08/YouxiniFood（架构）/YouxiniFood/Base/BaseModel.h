//
//  BaseModel.h
//  YouxiniFood
//
//  Created by youxin on 2017/7/27.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject <NSCoding>{
    
}

-(id)initWithDataDic:(NSDictionary*)data;
/**
 *  key : 类的属性名
 *  value : Json 的字段名
 */
- (NSDictionary*)attributeMapDictionary;
- (void)setAttr:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;


- (NSString *)cleanString:(NSString *)str;    //清除\n和\r的字符串

- (SEL)getSetterSelWithAttibuteName:(NSString*)attributeName;


@end
