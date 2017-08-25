//
//  WorkTypeMessageController.h
//  WiseAPP
//
//  Created by app on 16/10/17.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaseViewController.h"
#import "IdCartdBmodel.h"
#import "IDCardModel.h"

@interface WorkTypeMessageController : BaseViewController
//账号密码
@property(nonatomic,strong)NSString* workPhoneName;
@property(nonatomic,strong)NSString* workPassword;
//身份证信息 model
@property(nonatomic,strong)NSString*workName;
@property(nonatomic,strong)NSString*workGender;
@property(nonatomic,strong)NSString*workBirthday;//data
@property(nonatomic,strong)NSString* workAdress;
@property(nonatomic,strong)NSString* workNumber;
@property(nonatomic,strong)NSString* workpublisher;
@property(nonatomic,strong)NSString* workvalidate;


@property(nonatomic,strong)IDCardModel* modelA;
@property(nonatomic,strong)IdCartdBmodel* modelB;

@end
