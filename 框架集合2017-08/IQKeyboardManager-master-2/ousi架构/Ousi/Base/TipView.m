//
//  TipView.m
//  ND591UP
//
//  Created by PETER on 11-11-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TipView.h"
#import "CreateLable.h"
#import <QuartzCore/QuartzCore.h>

@implementation TipView

//-(void)genFrame:(NSString*)tipInfo
//{
//	UIFont* font = [UIFont systemFontOfSize:14.0f];
//	CGSize size = [tipInfo sizeWithFont:font];
//	int w = size.width + 16;
//	int h = size.height + 12;
//	CGRect viewFrame = CGRectMake((ScreenWidth - w) / 2, 410 - h - 10, w, h);
//	self.frame = viewFrame;
//	CGRect conFrame = CGRectMake(0, 0, w, h);
//	labBg.frame = conFrame;
//	labTitle.frame = CGRectMake(0, 0, w, h);
//}

-(id)initWithTipInfo:(NSString*)tipInfo
{
	self = [super init];
	if(self != nil)
	{
		
		CGRect conFrame = CGRectMake(0, 0, 300, 10);
        labBg = [[UILabel alloc] init];
        labBg.backgroundColor = [UIColor blackColor];
        labBg.alpha = 0.7f;
        
        labBg.layer.masksToBounds = YES;
		labBg.layer.cornerRadius = 6; 
		labBg.layer.borderWidth = 2.0f;
		labBg.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:labBg];
		
		labTitle = [CreateLable defaultLable:conFrame
											textColor:[UIColor whiteColor]
											 textSize:14.0f
												 text:tipInfo
											   isBold:NO
										testAlignment:NSTextAlignmentCenter];
        labTitle.numberOfLines = 0;
        
        
        [labTitle sizeToFit];
        
        CGSize size = labTitle.size;
        int w = size.width + 16;
        int h = size.height + 12;
        CGRect viewFrame = CGRectMake((SceneWidth - w) / 2, 410 - h - 10, w, h);
        self.frame = viewFrame;
        CGRect conFrame2 = CGRectMake(0, 0, w, h);
        labBg.frame = conFrame2;
        labTitle.frame = CGRectMake(0, 0, w, h);
		
		[self addSubview:labTitle];
		
//		[self genFrame:tipInfo];
	}
	
	[self performSelector:@selector(doClose) withObject:nil afterDelay:2.0f];
	return self;
}

-(void)showTipInfo:(NSString*)tipInfo
{
	[NSRunLoop cancelPreviousPerformRequestsWithTarget:self selector:@selector(doClose) object:nil];
//	[self genFrame:tipInfo];
	labTitle.text = tipInfo;
    
    [labTitle sizeToFit];
    
    CGSize size = labTitle.size;
    int w = size.width + 16;
    int h = size.height + 12;
    CGRect viewFrame = CGRectMake((SceneWidth - w) / 2, 410 - h - 10, w, h);
    self.frame = viewFrame;
    CGRect conFrame = CGRectMake(0, 0, w, h);
    labBg.frame = conFrame;
    labTitle.frame = CGRectMake(0, 0, w, h);
    
	[self performSelector:@selector(doClose) withObject:nil afterDelay:2.5f];
}

-(void)doClose
{
	[self removeFromSuperview];
}

-(void)dealloc
{
	[NSRunLoop cancelPreviousPerformRequestsWithTarget:self selector:@selector(doClose) object:nil];
}

@end
