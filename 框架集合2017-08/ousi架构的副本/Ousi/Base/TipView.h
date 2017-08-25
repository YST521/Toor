//
//  TipView.h
//  ND591UP
//
//  Created by PETER on 11-11-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 提示界面，用于答题界面
 */
@interface TipView : UIView
{
@private
	UILabel* labTitle;
    UILabel* labBg;
}

//初始化提示界面
-(id)initWithTipInfo:(NSString*)tipInfo;

//显示提示界面
-(void)showTipInfo:(NSString*)tipInfo;

//关闭提示界面
-(void)doClose;

@end
