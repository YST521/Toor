//
//  CircleHeadView.m
//  CircleHeadViewDemo
//
//  Created by pigpigdaddy on 14-9-24.
//  Copyright (c) 2014年 pigpigdaddy. All rights reserved.
//

#import "CircleHeadView.h"

@implementation CircleHeadView


//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    CircleHeadView *view = [[CircleHeadView alloc] initWithFrame:CGRectMake(50, 50, 80, 80)];
//    view.needShadow = YES;
//    view.strokeWidth = 2.0;
//    view.strokeColor = [UIColor whiteColor];
//    view.contentType = CircleHeadViewContentResizeAspectFill;
//    [view setCircleImage:[UIImage imageNamed:@"photo.png"]];
//    [self.view addSubview:view];
//}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.needShadow = NO;
        self.strokeColor = [UIColor whiteColor];
        self.strokeWidth = 2.0;
        self.contentType = CircleHeadViewContentResize;
    }
    return self;
}

- (void)setCircleImage:(UIImage *)image
{
    self.originalImage = image;
    
    CGRect bounds=CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
    CGFloat cornerRadius=self.bounds.size.height/2;
    
    if (self.needShadow) {
        // 创建阴影层
        [self createShadowLayer:bounds cornerRadius:cornerRadius];
    }
    // 创建照片层
    [self createImageLayer:bounds cornerRadius:cornerRadius];
}

- (void)createShadowLayer:(CGRect)bounds cornerRadius:(CGFloat)cornerRadius
{
    CALayer *layerShadow=[[CALayer alloc]init];
    layerShadow.bounds=bounds;
    layerShadow.position=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    layerShadow.cornerRadius=cornerRadius;
    layerShadow.shadowColor=[UIColor grayColor].CGColor;
    layerShadow.shadowOffset=CGSizeMake(2, 2);
    layerShadow.shadowOpacity=1;
    layerShadow.borderColor=self.strokeColor.CGColor;
    layerShadow.borderWidth=self.strokeWidth;
    [self.layer addSublayer:layerShadow];
}

- (void)createImageLayer:(CGRect)bounds cornerRadius:(CGFloat)cornerRadius
{
    CALayer *layer=[[CALayer alloc]init];
    layer.bounds=bounds;
    layer.position=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    layer.backgroundColor=[UIColor blackColor].CGColor;
    layer.cornerRadius=cornerRadius;
    layer.masksToBounds=YES;
    layer.borderColor=self.strokeColor.CGColor;
    layer.borderWidth=self.strokeWidth;
    layer.contents=(id)self.originalImage.CGImage;
    [self.layer addSublayer:layer];
    switch (self.contentType) {
        case CircleHeadViewContentResize:
        {
            layer.contentsGravity = kCAGravityResize;
        }
            break;
        case CircleHeadViewContentResizeAspect:
        {
            layer.contentsGravity = kCAGravityResizeAspect;
        }
            break;
        case CircleHeadViewContentResizeAspectFill:
        {
            layer.contentsGravity = kCAGravityResizeAspectFill;
        }
            break;
            
        default:
            break;
    }
}

@end
