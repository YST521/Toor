//
//  CommonLoadingView.m
//  ND591UP
//
//  Created by on 11-10-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CommonLoadingView.h"

#define LabInfoTag 800001

@implementation CommonLoadingView

-(void)initUI:(CGRect)frame
{
	self.backgroundColor = [UIColor clearColor];
	int w = frame.size.width;
	int h = frame.size.height;
	
	UIActivityIndicatorView* _activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	_activityView.frame = CGRectMake((w - 22) / 2, h / 2 - 28, 22, 22);
//	_activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	[_activityView startAnimating];
    
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(w/2-60, h/2-42, 120, 74)] autorelease];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    view.tag = 100;
    [self addSubview:view];
    
    
    [self addSubview:_activityView];
	
	UILabel* info = [[[UILabel alloc] init] autorelease];
	info.tag = LabInfoTag;
	info.backgroundColor = [UIColor clearColor];
	info.frame = CGRectMake(0, h / 2+4, w, 21);
	info.font = [UIFont systemFontOfSize:15.0f];
	info.text = @"载入数据中...";
    info.textColor = [UIColor whiteColor];
	info.textAlignment = NSTextAlignmentCenter;
    
    
    
	[self addSubview:info];
}

-(id)initWithInfo:(CGRect)frame info:(NSString*)info
{
	self = [super initWithFrame:frame];
	if(self != nil)
	{
		[self initUI:frame];
		UILabel* labinfo = (UILabel*)[self viewWithTag:LabInfoTag];
		labinfo.text = info;
        [labinfo sizeToFit];
        
        UIView *view = [self viewWithTag:100];
        view.width = labinfo.width + 30;
        view.left = self.width/2 - view.width/2;

        labinfo.width = self.width;
	}
	
	return self;
}

-(id)initwithColor:(UIColor *)color frame:(CGRect)frame info:(NSString *)info
{
    self = [super initWithFrame:frame];
	if(self != nil)
	{
        self.backgroundColor = [UIColor clearColor];
        int w = frame.size.width;
        int h = frame.size.height;
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(w/2-60, h/2-40, 120, 70)];
        view.backgroundColor = [UIColor colorWithWhite:0.36 alpha:0.5];
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
        [self addSubview:view];
        
        UIActivityIndicatorView* _activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
        _activityView.frame = CGRectMake((w - 22) / 2, h / 2 - 28, 22, 22);
//        _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [_activityView startAnimating];
        [self addSubview:_activityView];
        
        UILabel* info = [[[UILabel alloc] init] autorelease];
        info.tag = LabInfoTag;
        info.backgroundColor = [UIColor clearColor];
        info.frame = CGRectMake(0, h / 2 - 5, w, 21);
        info.font = [UIFont systemFontOfSize:15.0f];
        info.text = @"载入数据中...";
        info.textColor = [UIColor whiteColor];
        info.textAlignment = NSTextAlignmentCenter;
        [self addSubview:info];
	}
	
	return self;
}
@end
