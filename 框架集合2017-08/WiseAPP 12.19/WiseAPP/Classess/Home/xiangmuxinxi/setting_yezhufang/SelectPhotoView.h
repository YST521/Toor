//
//  SelectPhotoView.h
//  WiseAPP
//
//  Created by app on 16/10/27.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPhotoView : UIView
@property(nonatomic,strong)UILabel* selectTitle;
@property(nonatomic,strong)UIView* photoview;
@property(nonatomic,strong)UIImageView* photoImage;
@property(nonatomic,strong)UILabel* photoLabel;

@property(nonatomic,strong)UIView* cameraView;
@property(nonatomic,strong)UIImageView* cameraImage;
@property(nonatomic,strong)UILabel* cameraLab;

@end
