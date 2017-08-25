//
//  CreateLable.m
//  DZPK_V
//
//  Created by mippo on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreateLable.h"


@implementation CreateLable

+ (UILabel*)defaultLable:(CGRect)rect 
			   textColor:(UIColor*)col 
				textSize:(int)size 
					text:(NSString*)text
				  isBold:(BOOL)isBold
		   testAlignment:(NSTextAlignment)alignment
{
	UILabel *lab = [[UILabel alloc] initWithFrame:rect];
	lab.backgroundColor = [UIColor clearColor];
	lab.text = text;
	lab.textColor = col;
	if(isBold)
		lab.font = [UIFont boldSystemFontOfSize:size];
	else 
		lab.font = [UIFont systemFontOfSize:size];

	[lab setTextAlignment:alignment];
	
	return lab;
}

@end
