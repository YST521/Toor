//
//  SearchHistoryController.m
//  LuoSiDing
//
//  Created by youxin on 2017/6/1.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import "SearchHistoryController.h"
#import "HistoryViewCell.h"
#import "SearchTool.h"


#define IMPUT_MAX    20
#define SHOW_MAX    20  //限制可以输入最多搜索字数

@interface SearchHistoryController ()
<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate, UITextFieldDelegate,UINavigationControllerDelegate>{
    UISearchBar *searchBarH;
    
    NSMutableArray *searchList;
    
    NSMutableDictionary *list;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIButton *delectbtn;

@property (nonatomic, strong) HistoryViewCell *cell;
@property (nonatomic, strong) NSMutableArray *data;
@property(nonatomic,strong)UIView  * headView;
@property(nonatomic,strong)UILabel *alertLabel;


@end

@implementation SearchHistoryController
-(NSMutableArray *)data{
    if (!_data) {
        _data =[NSMutableArray array];
    }
    return _data;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //隐藏导航栏
//    self.navigationController.navigationBarHidden = YES;
//      self.navigationController.toolbarHidden = YES;
    
    if(self.data.count ==0){
        self.data = nil;
        
        self.delectbtn.hidden =YES;
        self.titlelabel.text = @"暂无搜索历史";
        [self.collectionView reloadData];
    }else{
    self.titlelabel.text = @"搜索历史";
    self.titlelabel.textAlignment = NSTextAlignmentCenter;
    }
    

    self.delectbtn.imageEdgeInsets = UIEdgeInsetsMake(10, 8, 10, 8);
//     [self.delectbtn setTitle:@"清除" forState:(UIControlStateNormal)];
//    self.navigationController.navigationBar.translucent = NO;
    //从064开始布局
    self.edgesForExtendedLayout=UIRectEdgeBottom;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource =self;
    self.collectionView.delegate =self;
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"HistoryViewCell" bundle:nil] forCellWithReuseIdentifier:@"HistoryViewCell"];
    
    self.titlelabel.textAlignment = NSTextAlignmentCenter;

    
    [self getSearchHistory]; //得到历史搜索
    [self creatSearBar];    //创建 searchBar
    [self creatHeadView];   //创建头视图
    
//    info.plist文件 里修改Localization native development region,点击最右边,选择属性为china
    
//    if (searchBar.text) {
 
//       [searchBar setValue:@"取消" forKey:@"cancelButton"];
//    } else {
//          [searchBar setValue:@"搜索" forKey:@"cancelButton"];
//    }
//    [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].title = @"取消";
//   [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"];
    
//    UIButton *cancelBtn = [searchBar valueForKeyPath:@"cancelButton"];
//    cancelBtn.enabled = YES;
//    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [cancelBtn addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}
- (IBAction)delecactionclick:(id)sender {
    
    [SearchTool clearAllSearchHistoryNSUserDefaultsKey:self.PushClassNameIsHistoryKey];
    self.data = nil;

    self.delectbtn.hidden =YES;
    self.titlelabel.text = @"暂无搜索历史";
    self.titlelabel.font =[UIFont systemFontOfSize:15];

    [self.collectionView reloadData];
    
}
//-(void)cancelButtonClicked{
//  [_delegate searchViewController:self searchText:searchBar.text];
//   [self.navigationController popViewControllerAnimated:YES];
//
//    
//}
#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [searchBarH removeFromSuperview];

    
}

-(void)creatSearBar{
    

    //自定义头部视图
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0 , SceneWidth,64.0)];
    searchBarView.backgroundColor = GoldColor;
    [self.view addSubview:searchBarView];
    
    searchBarH = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 20, SceneWidth-10, 44)];
    searchBarH.placeholder = @"输入关键字";
    searchBarH.delegate = self;
    searchBarH.barTintColor = GoldColor;
    searchBarH.showsCancelButton = YES;
    searchBarH.tintColor=[UIColor blueColor];
    searchBarH.backgroundColor = GoldColor;
    [searchBarH setBackgroundImage:[[UIImage alloc] init]];
    [searchBarView addSubview: searchBarH];
    
//    [self.navigationController.navigationBar addSubview:searchBar];
//    [naView addSubview:searchBar];
//    self.navigationItem.titleView = naView;
    //    info.plist文件 里修改Localization native development region,点击最右边,选择属性为china
    
    UIButton* btnClear = [[UIButton alloc] initWithFrame:CGRectMake(SceneWidth-10, 0, 40, 40)];
    
    [btnClear addTarget:self action:@selector(clearTextAcion:) forControlEvents:UIControlEventTouchUpInside];
//    btnClear.backgroundColor=[UIColor redColor];
    [searchBarH addSubview:btnClear];
    [searchBarH becomeFirstResponder];
    

}
- (void)clearTextAcion:(UIButton*)btn
{
    if (searchBarH.text.length) {
        searchBarH.text = nil;
        
        
    }
}

-(void)getSearchHistory{
     NSMutableArray*getArray=[NSMutableArray array];
    if ([SearchTool getAllSearchHistoryNSUserDefaultsKey:self.PushClassNameIsHistoryKey].count !=0) {
        self.data =(NSMutableArray*)[SearchTool getAllSearchHistoryNSUserDefaultsKey:self.PushClassNameIsHistoryKey];
        
         //如果太长需要折叠
        NSString* getStr;
   
        
        for (NSString*STR in self.data) {
          
            //存储
            if(STR.length>SHOW_MAX){
                getStr = [STR substringToIndex:SHOW_MAX];
            
                      getStr =[NSString stringWithFormat:@"%@...", getStr];
                [getArray addObject:getStr];
            }else{
          [getArray addObject:STR];
            }
       
        }
     
    }
    self.data = getArray;
}

-(void)creatHeadView{


}
-(void)delectBtnAction:(UIButton*)sender{
    
    [SearchTool clearAllSearchHistoryNSUserDefaultsKey:self.PushClassNameIsHistoryKey];
    self.data = nil;
//    self.headView.hidden = YES;
    self.delectbtn.hidden =YES;
    self.titlelabel.text = @"暂无搜索历史";
    [self.collectionView reloadData];

}

#pragma mark - SearchViewControllerDelegate
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0); // called before text changes
{
    if (range.location > IMPUT_MAX)
        return NO;
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText   // called when text changes (including clear)
{
    if (searchBar.text.length > IMPUT_MAX) {
        searchBar.text = [searchBar.text substringToIndex:IMPUT_MAX];
        
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar00
{
    self.alertLabel.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
  
}

/**
 *  弹框提示
 */
- (void)showAlert{
    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"message:@"搜索关键字不能为空"delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//    
//    [alert show];
    
    self.alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(SceneWidth/4, SceneHeight*0.8, SceneWidth/2, 30)];
     self.alertLabel.backgroundColor = [UIColor blackColor];
     self.alertLabel.font = [UIFont systemFontOfSize:16];
     self.alertLabel.textAlignment = NSTextAlignmentCenter;
     self.alertLabel.textColor =[UIColor whiteColor];
     self.alertLabel.text = @"搜索字段不能为空";
     self.alertLabel.hidden = NO;
    self.alertLabel.layer.cornerRadius = 15.0;
    self.alertLabel.layer.masksToBounds = YES;

    [self.view addSubview: self.alertLabel];
    [self dimissAlert];
   
}

/**
 *  移除弹框
 */
- (void) dimissAlert {
    //设置动画
//    CATransition * transion = [CATransition animation];
//    transion.type = @"push";//设置动画方式
//    transion.subtype = @"fromRight";//设置动画从那个方向开始
//    [self.alertLabel.layer addAnimation:transion forKey:nil];//给Label.layer
    //设置延时效果
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
        self.alertLabel.hidden = YES;
        [self.alertLabel removeFromSuperview];
    });//这句话的意思是1.5秒后，把label移出视图

    
}

- (NSString*)deleteEmptyStringStr:(NSString*)str{

    NSString *string = str;
    
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    
    NSArray *parts = [string componentsSeparatedByCharactersInSet:whitespaces];//在空格处将字符串分割成一个 NSArray
    
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];//去除空串
    
    NSString *jointStr= @"" ;
    
    string = [filteredArray componentsJoinedByString:jointStr];
    
    return string;
   
}

// 取消按钮 点击事项
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar00
{
    //去除字符串中空格
    NSString*str = [self deleteEmptyStringStr:searchBar00.text];
    //存储 全部存储
    if( searchBar00.text.length > 0 && ![searchBar00.text isEqualToString:@" "]){
        
        if (str.length != 0) {
            [SearchTool addSearchRecord:str NSUserDefaultsKey:self.PushClassNameIsHistoryKey ];
            
        } else {
            
            //                    [self showAlert];
            
        }
        
        if ([_delegate respondsToSelector:@selector(searchViewController:searchText:)]) {
            [_delegate searchViewController:self searchText:str ];
        }
        
    }
    
    
    if (str.length != 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self showAlert];
    }
    
//    if ([searchBarH.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]) {
//        NSString* searchText = searchBarH.text;
//        if ([searchBarH.text hasSuffix:@"\n"]) {
//            searchText = [searchBarH.text substringToIndex:searchText.length - 1];
//                              }
//        if ([_delegate respondsToSelector:@selector(searchViewController:searchText:)]) {
//            NSString*str = [self deleteEmptyStringStr:searchBar00.text];
//            [_delegate searchViewController:self searchText:str];
//        }
        
//    }
    
//    [self searchBarCancelButtonClicked:searchBarH];

}




#pragma mark---------collectView---------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HistoryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HistoryViewCell" forIndexPath:indexPath];
    cell.keyword = _data[indexPath.row];
    return cell;
}




- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 10);
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_cell == nil) {
        _cell = [[NSBundle mainBundle]loadNibNamed:@"HistoryViewCell" owner:nil options:nil][0];
    }
    _cell.keyword = _data[indexPath.row];
    return [_cell sizeForCell];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取未折叠数据
    NSMutableArray*DataSouce = [NSMutableArray array];
    if ([SearchTool getAllSearchHistoryNSUserDefaultsKey:self.PushClassNameIsHistoryKey].count !=0) {
        DataSouce =(NSMutableArray*)[SearchTool getAllSearchHistoryNSUserDefaultsKey:self.PushClassNameIsHistoryKey];
    }
    searchBarH.text =DataSouce[indexPath.row];
     NSLog(@"SSSSSSSShhhhhhh_____%@",DataSouce[indexPath.row]);
    [_delegate searchViewController:self searchText:DataSouce[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -----------alert--------------

- (void)alertViewTitle:(NSString*)alertTitle alretContent:(NSString*)content{
    
    UIAlertController *alertVC =[UIAlertController alertControllerWithTitle:@"提示" message:alertTitle preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *al =[UIAlertAction actionWithTitle:content style:(UIAlertActionStyleDefault) handler:nil];
    [alertVC addAction:al];
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(void)dealloc{


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
