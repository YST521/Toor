//
//  XmlApiResult.h
//  Ousi
//
//  Created by WuRuizhou on 2017/5/15.
//  Copyright © 2017年 WuRuizhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XmlApiResult : NSObject

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSXMLParser *xmlParse;

@end
