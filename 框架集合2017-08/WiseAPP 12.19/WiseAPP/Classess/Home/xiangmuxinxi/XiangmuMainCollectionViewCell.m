//
//  XiangmuMainCollectionViewCell.m
//  WiseAPP
//
//  Created by app on 16/10/14.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XiangmuMainCollectionViewCell.h"


#define UISCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define CELL_WIDTH (([[UIScreen mainScreen] bounds].size.width - 40) / 3)
@implementation XiangmuMainCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        [self addView];
    }
    return self;

}

-(void)addView{
self.imageView = [[UIImageView alloc] init];
    self.imageView.frame =self.contentView.bounds;
    self.imageView.image=[UIImage imageNamed:@"home_xiangmuBg.png"];
    [self.contentView addSubview:self.imageView];
    
    self.xiangmuTitle=[[UILabel alloc]init];
    self.xiangmuTitle.frame = CGRectMake(0, 20, self.contentView.width, 30);
   // self.xiangmuTitle.backgroundColor=[UIColor greenColor];
    self.xiangmuTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.xiangmuTitle];
    
//    self.backgroundColor =[UIColor greenColor];
//    //这里需要初始化ImageView；
//    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - (UISCREEN_WIDTH - 40) / 6 - 20, self.frame.size.width-(UISCREEN_WIDTH - 40) / 6 - 20, 40, 40)];
//    [self.imageView setUserInteractionEnabled:true];
//    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.width - (UISCREEN_WIDTH - 40) / 6 + 20, (UISCREEN_WIDTH - 40) / 3, 20)];
//    self.descLabel.textAlignment = NSTextAlignmentCenter;
//    self.descLabel.text = @"111";
//    self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(CELL_WIDTH - 35, 5, 30, 30)];
//    [self.deleteButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
//    //先设置不可见；
//    [self.deleteButton setHidden:true];
//    
//    self.layer.borderWidth = 0.5;
//    
//    [self addSubview:self.imageView];
//    [self addSubview:self.descLabel];
//    [self addSubview:self.deleteButton];

}
@end
