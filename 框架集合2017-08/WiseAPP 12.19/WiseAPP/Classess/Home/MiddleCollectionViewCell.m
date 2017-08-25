//
//  MiddleCollectionViewCell.m
//  WiseAPP
//
//  Created by app on 16/10/10.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "MiddleCollectionViewCell.h"

@interface MiddleCollectionViewCell()


@end

@implementation MiddleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
      
        [self creadView];
        
    }
  return self;
}

-(void)creadView{
 
    [self.contentView addSubview:self.bgimageView];
    self.bgimageView.userInteractionEnabled = YES;
    self.iconImageView = [[UIImageView alloc]init];
    //self.iconImageView.frame= self.contentView.bounds;
    self.iconImageView.frame = CGRectMake((self.bgimageView.width-32)/2, 13*SCREEN_WIDTH/375, 32*SCREEN_WIDTH/375,  32*SCREEN_WIDTH/375);
    //self.iconImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.iconImageView];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bgimageView.height-(13+20)*SCREEN_WIDTH/375, self.bgimageView.width, 20)];
   // self.titleLabel.text = @"collect";
    self.titleLabel.textColor = textColorPlace;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.bgimageView addSubview:self.titleLabel];
    
    self.upView = [[UIView alloc]init];
    self.upView.frame = self.contentView.bounds;
    [self.contentView addSubview:self.upView];
    
    
}
//懒加载 本质是重写get方法 一般用self调用的售后开辟空间，能够在一定程度降低内存消耗

-(UIImageView*)bgimageView{
    
    if(!_bgimageView){
        _bgimageView=[[UIImageView alloc]initWithFrame:self.contentView.bounds];
       // self.bgimageView.frame = self.contentView.bounds;
        //self.contentView.backgroundColor = [UIColor redColor];
    }
    
    return  _bgimageView;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.bgimageView.frame = self.contentView.bounds;
    //self.bgimageView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
    

    
    
    
    
}


@end
