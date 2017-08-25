//
//  FindCompanyViewController.h
//  WiseAPP
//
//  Created by app on 16/10/11.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaseViewController.h"
#import "MiSearchBar.h"

@interface FindCompanyViewController : BaseViewController
@property (nonatomic,strong) MiSearchBar *searchBar;
@property (nonatomic,strong) NSString *searchText;

@property (nonatomic,retain) UITableView *tableView;

@property (nonatomic,retain) NSMutableArray *arr;
@property (nonatomic,retain) NSMutableArray *resultArr;
@end
