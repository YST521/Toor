//
//  YezhuEditorViewController.h
//  WiseAPP
//
//  Created by app on 16/12/12.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaseViewController.h"
@class YezhuModel;
@interface YezhuEditorViewController : BaseViewController

@property(nonatomic,strong)YezhuModel*model;
@property(nonatomic,assign)NSInteger nextPageType ;
@end
