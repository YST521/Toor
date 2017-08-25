//
//  XunjianQuanshuModel.h
//  WiseAPP
//
//  Created by app on 16/11/23.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XunjianQuanshuModel : NSObject
//{
//    id = 1;
//    info =         (
//                    {
//                        inspectionpoint = 1;
//                        inspectiontime = "16:14";
//                    },
//                    {
//                        inspectionpoint = 4;
//                        inspectiontime = "16:14";
//                    }
//                    );
//},
@property(nonatomic,assign)int xunjianquanshuID;
@property(nonatomic,strong)NSArray* info;
//@property(nonatomic,assign)int id;
//@property(nonatomic,strong)NSString* info;


@end
