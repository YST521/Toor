//
//  AnnotionModel.h
//  WiseAPP
//
//  Created by app on 16/11/3.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AnnotionModel : NSObject<MKAnnotation>
//经纬度
@property (nonatomic)CLLocationCoordinate2D coordinate;
//父标题
@property (nonatomic,copy)NSString *title;
//子标题
@property (nonatomic,copy)NSString *subtitle;
@end
