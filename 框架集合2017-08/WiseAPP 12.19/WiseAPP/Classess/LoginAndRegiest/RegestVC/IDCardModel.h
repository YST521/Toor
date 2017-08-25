//
//  IDCardModel.h
//  WiseAPP
//
//  Created by app on 16/10/16.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDCardModel : NSObject
//address = "\U6cb3\U5357\U7701\U65b0\U53bf\U9661\U5c71\U6cb3\U8857\U9053";
//authority = "<null>";
//bday = 02;
//bmonth = 07;
//bottom = 358;
//byear = 1991;
//code = 0;
//croppedImage =
//gender = "\U7537";
//headImage =
//idnumber = 41152319910702381X;
//left = 417;
//name = "\U6613\U5584\U6d9b";
//people = "\U6c49";
//result = "0.0.0.0";
//right = 666;
//top = 55;
//validdate =

@property(nonatomic,copy)NSString* address;
@property(nonatomic,copy)NSString* gender;
@property(nonatomic,copy)NSString* croppedImage;
@property(nonatomic,copy)NSString* bday;
@property(nonatomic,copy)NSString* bmonth;
@property(nonatomic,copy)NSString* bottom;
@property(nonatomic,copy)NSString* byear;
@property(nonatomic,copy)NSString* code;
@property(nonatomic,copy)NSString* headImage;
@property(nonatomic,copy)NSString* idnumber;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* people;


@end
