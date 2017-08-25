//
//  AddAddressController.h
//  YouxiniFood
//
//  Created by youxin on 2017/8/7.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "HYBaseViewController.h"

//@interface AddAddressController : HYBaseViewController
//
//@end




#define Notification_SelectDiqu @"keyNotification_SelectDiqu"

@class ReceiveAddress;
@protocol EditShouHuoViewControllerDelegate <NSObject>

- (void)editShouHuoViewControllerSaveAddress:(ReceiveAddress*)address;



@end

@interface AddAddressController : HYBaseViewController

@property (nonatomic, assign) BOOL isNewAdd;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, assign) id<EditShouHuoViewControllerDelegate> delegate;
@property (nonatomic, strong) ReceiveAddress *address;

@property(nonatomic,strong)NSArray *adressArray;

@end
