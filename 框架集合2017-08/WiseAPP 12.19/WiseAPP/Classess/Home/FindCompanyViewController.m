//
//  FindCompanyViewController.m
//  WiseAPP
//
//  Created by app on 16/10/11.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "FindCompanyViewController.h"
#import "FindCompanyCell.h"

@interface FindCompanyViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic) BOOL isSearch;//判断是否在搜索

@property(nonatomic,strong)UICollectionView*collectionView;
@property(nonatomic,strong)NSMutableArray*dataArray;

@end

static NSString*cellID =@"findID";
@implementation FindCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"公司查找";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self addView];
}
-(void)addView{

    _searchBar = [[MiSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40) placeholder:@"搜索"];
    _searchBar.delegate = self;
    _searchBar.barTintColor = [UIColor redColor];
    [self.view addSubview:_searchBar];
    
    _searchText = @"";
   
    [self collectView];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame)+10, self.view.bounds.size.width, self.view.bounds.size.height-PROPORTION_HIGHT(100)) style:UITableViewStylePlain];
    _tableView.delegate  =self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    _arr = [[NSMutableArray alloc] initWithObjects:@"1",@"12",@"1233",@"21",@"31",@"41",@"55",@"67",@"90",@"1211111",@"900000",@"10", nil];
    _resultArr = [[NSMutableArray alloc]init];
    


}
-(void)collectView{


    self.dataArray = [NSMutableArray array];
    
    //创建布局对象
    UICollectionViewFlowLayout*flowlayout=[[UICollectionViewFlowLayout alloc]init];
    
    
    //距离屏幕上下左右的间距
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //flowlayout.itemSize =CGSizeMake(SCREEN_WIDTH-50*SCREEN_WIDTH/375, 78*SCREEN_HEIGHT*667);
    flowlayout.itemSize =CGSizeMake((SCREEN_WIDTH-50)/4,(SCREEN_WIDTH-50)/4);
    
    //设置滑动方向
    //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    
//    if(SCREEN_WIDTH>374){
//        self.frame =CGRectMake(0, CGRectGetMaxY(PROPORTION_HIGHT(20), SCREEN_WIDTH, PROPORTION_HIGHT((SCREEN_WIDTH-50)/2)+30) ;
//        
//    }else{
//        self. frame =CGRectMake(0, CGRectGetMaxY(self.upCycleImage.frame), SCREEN_WIDTH, PROPORTION_HIGHT((SCREEN_WIDTH-50)/2)+50) ;
//    }
    
    //初始化
    self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(PROPORTION_WIDTH(30), CGRectGetMaxY(self.searchBar.frame)+10,SCREEN_WIDTH- PROPORTION_WIDTH(60),PROPORTION_WIDTH(100) )  collectionViewLayout:flowlayout];
    
    
    
      //self.collectionView.backgroundColor=[UIColor blueColor];
    
    //背景色
   // self.collectionView.backgroundColor=GlobBackGroundColor;
    self.collectionView.backgroundColor = popBGColore;
    self.collectionView.dataSource =self;
    
    self.collectionView.delegate =self;
    self.collectionView.alwaysBounceVertical = NO;
       self.collectionView.alwaysBounceHorizontal = NO;
    
    [self.view addSubview:self.collectionView];
    self.collectionView.contentSize = CGSizeMake(0,0);
    
    [self.collectionView registerClass:[FindCompanyCell class]   forCellWithReuseIdentifier:cellID];
    

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.collectionView setContentSize:CGSizeMake(0, 0)];
}
#pragma mark ---- collectDelegate-------
//设置分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 1;
    
}

//设置单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    //return self.collectDataArray.count;
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FindCompanyCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier: cellID forIndexPath:indexPath];
    
//    cell.iconImageView .image = [UIImage imageNamed:self.collectIconArray[indexPath.row]];
//    cell.bgimageView.image = [UIImage imageNamed:@"home_collectbg"];
//    cell.titleLabel.text = self.collectTitleArray[indexPath.row];
    //cell.backgroundColor=[UIColor redColor];
    if (indexPath.item==0) {
        cell.titleLabel.text = @"保安公司";
        cell.titleLabel.font = textPlaceFont;
        cell.titleLabel.textColor = textCententColor;
         cell.iconImageView .image = [UIImage imageNamed:@"iconfont-anquan"];
        
    }else if (indexPath.item ==1){
        cell.titleLabel.text = @"保洁公司";
        cell.titleLabel.font = textPlaceFont;
        cell.titleLabel.textColor = textCententColor;
         cell.iconImageView .image = [UIImage imageNamed:@"iconfont-baoji"];
    
    }else{
        cell.titleLabel.text = @"物业公司";
        cell.titleLabel.font = textPlaceFont;
        cell.titleLabel.textColor = textCententColor;
         cell.iconImageView .image = [UIImage imageNamed:@"iconfont-wuye"];
    
    }
    
    // cell点击变色
    
    UIImageView*imageV = [[UIImageView alloc]init];
    imageV.frame = cell.bounds;
    imageV.image = [UIImage imageNamed:@"Rectangle 2  8"];
    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
    
    [selectedBGView addSubview:imageV];
    
    //[cell.contentView addSubview:imageV];
    cell.selectedBackgroundView = selectedBGView;
    return  cell;
}


//点击跳转
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
 
    
}

//// cell点击变色
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}





#pragma mark ---delegate------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearch) {
        return _resultArr.count ;
    }else{
        return _arr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (self.isSearch) {
        cell.textLabel.text = _resultArr[indexPath.row];
    }else{
        cell.textLabel.text = _arr[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        _searchText = @"";
        self.isSearch = NO;
        [self.tableView reloadData];
    }
    NSLog(@" --- %@",searchText);
    [_resultArr removeAllObjects];
    
    for (NSString *searchStr in _arr) {
        if ([searchStr rangeOfString:searchText].location != NSNotFound) {
            [_resultArr addObject:searchStr];
        }
    }
    if (_resultArr.count) {
        self.isSearch = YES;
        [self.tableView reloadData];
    }
}


-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.isSearch = NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    self.isSearch = NO;
    [self.tableView reloadData];
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
