//
//  CustonTextfile.m
//  WiseAPP
//
//  Created by app on 16/10/12.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "CustonTextfile.h"

@implementation CustonTextfile
-(instancetype)initWithFrame:(CGRect)frame{


    if (self =[super initWithFrame:frame]) {
      
        [self addView];
    }
    return  self;
}
-(void)addView{
    UIImageView*imagBg=[[UIImageView alloc]init];
    imagBg.frame =self.bounds;
    //textfilebackgroundimage.png // textfile
    imagBg.image =[UIImage imageNamed:@"textfilebackgroundimage.png"];
  
    [self addSubview:imagBg];
    imagBg.userInteractionEnabled = YES;
    
    self.customTextfile=[[UITextField alloc]init];
//    self.customTextfile.backgroundColor=[UIColor redColor];
    self.customTextfile.frame = self.bounds;
    self.customTextfile.textColor= textColorPlace;

    [self addSubview:self.customTextfile];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
