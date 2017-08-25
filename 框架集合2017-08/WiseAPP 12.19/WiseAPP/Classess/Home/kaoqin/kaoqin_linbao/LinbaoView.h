//
//  LinbaoView.h
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LinbaoView : UIView
@property(nonatomic,strong)UIImageView* addressIcon;
@property(nonatomic,strong)UILabel* addressLa;
@property(nonatomic,strong)MKMapView*mapView;
@property(nonatomic,strong)UIImageView* timeImageview;
@property(nonatomic,strong)UILabel* cuttreTimeLa;
@property(nonatomic,strong)UILabel* cuttreLa;
@property(nonatomic,strong)UILabel* selectbanciLa;
@property(nonatomic,strong)UITextField* banciFi;
@property(nonatomic,strong)UIImageView*textfileBG;
//@property(nonatomic,strong)UIButton* qiandaoBtn;
//@property(nonatomic,strong)UIButton* qiantuiBtn;
@property(nonatomic,strong)UIView*hadongView;//地图左上角滑动view
@property(nonatomic,strong)UILabel* workTimeLa;
@property(nonatomic,strong)UILabel* workNameLa;
@property(nonatomic,strong)UILabel* workLongtimeLa;
@property(nonatomic,strong)UIImageView* peopleImage;
@property(nonatomic,strong)UIImageView* rightImage;

@property(nonatomic,strong)UIView* contentView;//滑动view上内容


@end
