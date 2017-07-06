//
//  RootViewController.m
//  DKNightVerision
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import "RootViewController.h"
#import "SuccViewController.h"
#import "PresentingViewController.h"
#import "DKNightVersion.h"
#import "TableViewCell.h"
#import "UITableViewCell+Night.h"
#import "CoverViewController.h"


//@pickerify(TableViewCell, cellTintColor)

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NORMAL   NIGHT
//#ffffff  #343434  BG
//#aaaaaa  #313131  SEP
//#0000ff  #ffffff  TINT
//#000000  #ffffff  TEXT
//#ffffff  #444444  BAR
//#f0f0f0  #222222  HIGHLIGHTED

    
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    navigationLabel.text = @"皮肤切换";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
//    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
       navigationLabel.dk_textColorPicker = DKColorPickerWithKey(AA);
    self.navigationItem.titleView = navigationLabel;
    
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
    self.navigationItem.leftBarButtonItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Present" style:UIBarButtonItemStylePlain target:self action:@selector(present)];
    self.navigationItem.leftBarButtonItem = item;
    
    UIBarButtonItem *normalItem = [[UIBarButtonItem alloc] initWithTitle:@"白天" style:UIBarButtonItemStylePlain target:self action:@selector(normal)];
    normalItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
  
    UIBarButtonItem *nightItem = [[UIBarButtonItem alloc] initWithTitle:@"夜间" style:UIBarButtonItemStylePlain target:self action:@selector(night)];
    nightItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    self.navigationItem.rightBarButtonItems = @[normalItem, nightItem];
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    NORMAL   NIGHT
//    *      #ffffff  #343434 BG
//    *      #aaaaaa  #313131 SEP
//    self.tableView.dk_backgroundColorPicker =  DKColorPickerWithKey(0);
//    self.tableView.dk_backgroundColorPicker = DKColorPickerWithRGB(255, 0, 0);
//    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
    
}

#pragma mark -
- (void)night {
    
    self.dk_manager.themeVersion = DKThemeVersionNight;
    
}

- (void)normal {
    
    self.dk_manager.themeVersion = DKThemeVersionNormal;
}

- (void)change {
    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        [self.dk_manager dawnComing];
    } else {
        [self.dk_manager nightFalling];
    }
}

#pragma mark -
- (void)push {
    [self.navigationController pushViewController:[[SuccViewController alloc] init] animated:YES];
}

- (void)present {
    [self presentViewController:[[PresentingViewController alloc] init] animated:YES completion:nil];
}

#pragma mark - UITableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //cell.dk_cellTintColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434);
    //cell.dk_cellTintColorPicker = DKColorPickerWithKey(BG);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:[[SuccViewController alloc] init] animated:YES];
    if (indexPath.row%2 != 0) {
         [self.navigationController pushViewController:[[CoverViewController alloc] init] animated:YES];
    }
}

@end
