//
//  JiaobanKaoqinView.h
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface JiaobanKaoqinView : UIView
@property(nonatomic,strong)UIImageView* addressIcon;
@property(nonatomic,strong)UILabel* addressLa;
@property(nonatomic,strong)MKMapView*mapView;
@property(nonatomic,strong)UIImageView* timeImageview;
@property(nonatomic,strong)UILabel* cuttreTimeLa;
@property(nonatomic,strong)UILabel* cuttreLa;
@property(nonatomic,strong)UILabel* selectbanciLa;
@property(nonatomic,strong)UITextField* banciFi;
@property(nonatomic,strong)UIImageView*textfileBG;
@end
