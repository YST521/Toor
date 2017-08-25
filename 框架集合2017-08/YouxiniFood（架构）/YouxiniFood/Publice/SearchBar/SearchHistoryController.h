//
//  SearchHistoryController.h
//  LuoSiDing
//
//  Created by youxin on 2017/6/1.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchHistoryController;

@protocol SearchViewControllerDelegate <NSObject>

- (void)searchViewController:(SearchHistoryController*)searchViewController searchText:(NSString*)searchText;


@end


@interface SearchHistoryController : UIViewController
@property (nonatomic, weak) id<SearchViewControllerDelegate> delegate;

@property (nonatomic, strong) NSString *PushClassNameIsHistoryKey;
@property (nonatomic, strong) NSString *searchName;
@property (nonatomic, strong) NSArray *arrData;

@property (nonatomic, strong) NSString *cellClassName;


@end
