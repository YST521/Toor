//
//  YezhuModel.h
//  WiseAPP
//
//  Created by app on 16/11/23.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YezhuModel : NSObject
//{
//    id = 17;
//    images = "/usr/local/EC/youchi/images/project/20161116/20161116141058YC645211839.jpg";
//    info =             {
//        age = 17;
//        height = 170;
//        job = Android;
//        numberplates = 000000;
//        remarks = "\U65e0";
//        sex = "\U7537";
//        workinghours = 00000;
//    };
//    name = "\U8eba\U7740\U5462";
//}
@property(nonatomic,assign)int yezhuID;
@property(nonatomic,copy)NSString* images;
@property(nonatomic,copy)NSDictionary* info;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString*phone;

@end
