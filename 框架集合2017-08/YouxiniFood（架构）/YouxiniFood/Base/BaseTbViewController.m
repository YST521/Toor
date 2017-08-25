//
//  BaseTbViewController.m
//  Hjxq
//
//  Created by 吴瑞洲 on 16/1/29.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "BaseTbViewController.h"

@interface BaseTbViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation BaseTbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = BgColor;
    _isMore = YES;
    _isLoading = NO;
    _pageIndex = 0;
    _dataSource = [NSMutableArray array];
    
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight)];
    _tb.delegate = self;
    _tb.dataSource = self;
    [self.view addSubview:_tb];
    
    
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton.backgroundColor = [UIColor whiteColor];
    _moreButton.frame = CGRectMake(0, 0, SceneWidth, 40);
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    [_moreButton setTitle:@"加载更多" forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor colorWithRed:200.f/255.f green:210.f/255.f blue:220.f/255.f alpha:1] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(loadMoreAction) forControlEvents:UIControlEventTouchUpInside];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.tag = 11;
    [_activityView stopAnimating];
    _activityView.frame = CGRectMake(95, 10, 20, 20);
    
    [_moreButton addSubview:_activityView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SceneWidth, 0.5)];
    line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_moreButton addSubview:line];
    
    _tb.tableFooterView = _moreButton;
    

}


#pragma mark - Actions

- (void)loadMoreAction
{
    [self _startLoadMore];
}

- (void)_startLoadMore
{
    [_moreButton setTitle:@"玩命加载中..." forState:UIControlStateNormal];
    _moreButton.enabled = NO;
    
    //    UIActivityIndicatorView *view = (UIActivityIndicatorView*)[_moreButton viewWithTag:11];
    //    [view startAnimating];
    [_activityView startAnimating];
}

- (void)endLoadMore
{
    _isLoading = NO;
    [self closeLoadView];
    [_moreButton setTitle:@"加载更多" forState:UIControlStateNormal];
    _moreButton.enabled = YES;
    [_activityView stopAnimating];
    
    if (!_isMore)
    {
//        [_moreButton setTitle:@"加载完成" forState:UIControlStateNormal];
        [_moreButton setTitle:@"" forState:UIControlStateNormal];
        _moreButton.enabled = NO;
        
        _tb.tableFooterView = [[UIView alloc] init];
    } else if (_tb.tableFooterView != _moreButton) {
        _tb.tableFooterView = _moreButton;
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float offset = scrollView.contentOffset.y;
    if (_isMore)
    {
        float contenHeight = scrollView.contentSize.height;
        
        float sub = contenHeight - offset;
        if (scrollView.height - sub > 20)
        {
            [self loadMoreAction];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
