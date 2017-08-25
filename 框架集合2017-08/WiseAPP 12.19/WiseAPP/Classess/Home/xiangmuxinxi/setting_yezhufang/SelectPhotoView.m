//
//  SelectPhotoView.m
//  WiseAPP
//
//  Created by app on 16/10/27.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "SelectPhotoView.h"

@implementation SelectPhotoView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self =[super initWithFrame:frame]){
        
        [self addView];
    }
    
    return  self;
}

-(void)addView{
     self.backgroundColor=popBGColore;
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(45*3));
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    bgView.userInteractionEnabled = YES;
    
    UIImageView*titleBg=[[UIImageView alloc]init];
    titleBg.frame = CGRectMake(0, 0, bgView.width,  STANDARD_HEIGHT);
    titleBg.image =[UIImage imageNamed:@"nabackgroundImage.png"];
    [bgView addSubview:titleBg];
    self.selectTitle=[[UILabel alloc]init];
    self.selectTitle.frame = titleBg.bounds;
    self.selectTitle.text = @"设置头像";
    self.selectTitle.textColor =[UIColor whiteColor];
    self.selectTitle.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:self.selectTitle];
    
    self.photoview=[[UIView alloc]init];
   self.photoview.frame = CGRectMake(titleBg.x, CGRectGetMaxY(titleBg.frame), titleBg.width, titleBg.height);
    self.photoview.backgroundColor=[UIColor whiteColor];
    [bgView addSubview:self.photoview];
    self.photoview.userInteractionEnabled = YES;
    
    self.photoImage=[[UIImageView alloc]init];
    self.photoImage.frame = CGRectMake(10, 10, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    //self.photoImage.backgroundColor=[UIColor redColor];
    [self.photoview addSubview:self.photoImage];
    self.photoImage.image =[UIImage imageNamed:@"home_photo.png"];
    
    self.photoLabel=[[UILabel alloc]init];
    self.photoLabel.frame = CGRectMake(CGRectGetMaxY(self.photoImage.frame)+10, self.photoImage.y, 40, 20);
    self.photoLabel.text = @"相册";
    [self.photoview addSubview:self.photoLabel];
    
    self.cameraView=[[UIView alloc]init];
    self.cameraView.frame = CGRectMake(titleBg.x, CGRectGetMaxY(self.photoview.frame), titleBg.width, titleBg.height);
    //self.cameraView.backgroundColor=[UIColor blueColor];
    [bgView addSubview:self.cameraView];
    
    self.cameraImage=[[UIImageView alloc]init];
    self.cameraImage.frame = CGRectMake(10, 10, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
   //self.cameraImage.backgroundColor=[UIColor redColor];
    [self.cameraView addSubview:self.cameraImage];
    self.cameraImage.image =[UIImage imageNamed:@"home_camer.png"];
    
    self.cameraLab=[[UILabel alloc]init];
    self.cameraLab.frame = CGRectMake(CGRectGetMaxY(self.cameraImage.frame)+10, self.cameraImage.y, 40, 20);
     self.cameraLab.text = @"拍照";
    [self.cameraView addSubview: self.cameraLab];
    
    
    self.hidden = NO;
}
@end
