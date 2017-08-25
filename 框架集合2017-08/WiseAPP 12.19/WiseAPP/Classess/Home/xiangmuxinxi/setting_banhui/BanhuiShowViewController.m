//
//  BanhuiShowViewController.m
//  WiseAPP
//
//  Created by app on 16/11/23.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BanhuiShowViewController.h"
#import "BanhuiModel.h"
#import "UibanhuiShowTableViewCell.h"
#import "BanhuiAddViewController.h"

@interface BanhuiShowViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)UITableView* banhuiShowTabView;
@property(nonatomic,strong)UIView* footView;
@property(nonatomic,strong)UIButton*banhuiDeleBtn;
@property(nonatomic,strong)UIButton*edtorBtn;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray* imageArray;

@end
static NSString* banhuiShowCellID=@"banhuiShowCellID";
@implementation BanhuiShowViewController
-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray=[NSMutableArray array];
    }
    return _imageArray;
}

//-(NSMutableArray *)dataArray{
//    if (!_dataArray) {
//        _dataArray=[NSMutableArray array];
//    }
//    return _dataArray;
//}
//-(UITableView *)banhuiShowTabView{
//    if (!_banhuiShowTabView) {
//        _banhuiShowTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:(UITableViewStylePlain)];
//        
//    }
//    
//    return _banhuiShowTabView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=GlobBackGroundColor;
    [self addData];
    [self addView];
    
}
-(void)addData{
    
    for (NSDictionary*dic in self.model.image) {
        [self.imageArray addObject: dic[@"image"]];
    }

}
-(void)addView{
//    
    self.footView =[[UIView alloc]init];
    self.footView.frame =CGRectMake(0, 0, SCREEN_WIDTH, 250);
    //self.footView.backgroundColor =[UIColor greenColor];
    self.footView.backgroundColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    self.banhuiDeleBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.banhuiDeleBtn.frame =CGRectMake(10, self.footView.height-PROPORTION_HIGHT(65),SCREEN_WIDTH/2-PROPORTION_WIDTH(10), STANDARD_HEIGHT);
    self.banhuiDeleBtn.backgroundColor=[UIColor blueColor];
    [self.footView addSubview:self.banhuiDeleBtn];
    KUIbutton(self.banhuiDeleBtn);
    KUIbuttonClick(self.banhuiDeleBtn);
    [self.banhuiDeleBtn setTitle:@"删除" forState:(UIControlStateNormal)];
  
    self.edtorBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.edtorBtn.frame =CGRectMake(CGRectGetMaxX(self.banhuiDeleBtn .frame)+10, self.footView.height-PROPORTION_HIGHT(65), SCREEN_WIDTH/2-PROPORTION_WIDTH(15), STANDARD_HEIGHT);
    self.edtorBtn.backgroundColor=[UIColor cyanColor];
    [self.footView addSubview:self.edtorBtn];
    KUIbutton(self.edtorBtn);
    KUIbuttonClick(self.edtorBtn);
    [self.edtorBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
    self.banhuiShowTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:(UITableViewStylePlain)];
    [self.view addSubview:self.banhuiShowTabView];
    self.banhuiShowTabView.dataSource =self;
    self.banhuiShowTabView.delegate =self;
   self.banhuiShowTabView.tableFooterView =self.footView;
    [self.banhuiShowTabView registerClass:[UibanhuiShowTableViewCell class] forCellReuseIdentifier:banhuiShowCellID];
    //collectView
   [self creatCollectView];
    [self.banhuiDeleBtn addTarget:self action:@selector(deleteAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.edtorBtn addTarget:self action:@selector(editorAction:) forControlEvents:(UIControlEventTouchUpInside)];

    
}
//删除
-(void)deleteAction:(UIButton*)sender{
    NSLog(@"删除");
   NSMutableDictionary*dic=[NSMutableDictionary dictionary];

    [dic setObject:@(self.model.banhuiID)  forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"classmeetingDelete"] Token:self.tokenString parmpar:dic succeed:^(id data) {
        //for (NSArray*ARRAY in data[@"resultMessage"]) {
            NSLog(@"班会%@",data);
       // }
        
    } failure:^(NSError *error) {
       
    }];
    
     [self.navigationController popViewControllerAnimated:YES];
}
//编辑
-(void)editorAction:(UIButton*)sender{
    BanhuiAddViewController*addVC=[[BanhuiAddViewController alloc]init];
    addVC.model =self.model;
    addVC.upPageType =1;
    
    [self.navigationController pushViewController:addVC animated:YES];

    
}

-(void)creatCollectView{
    
    //创建布局对象
    UICollectionViewFlowLayout*flowlayout=[[UICollectionViewFlowLayout alloc]init];
    
    //距离屏幕上下左右的间距
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //flowlayout.itemSize =CGSizeMake(SCREEN_WIDTH-50*SCREEN_WIDTH/375, 78*SCREEN_HEIGHT*667);
    flowlayout.itemSize =CGSizeMake((SCREEN_WIDTH-50)/4,(SCREEN_WIDTH-50)/4);
    
    //初始化
    self.collectionView =[[UICollectionView alloc]initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 150)  collectionViewLayout:flowlayout];
    
    //背景色
    self.collectionView.backgroundColor=GlobBackGroundColor;
   // self.collectionView.backgroundColor= [UIColor redColor];
    self.collectionView.dataSource =self;
    
    self.collectionView.delegate =self;
    
    [self.footView addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
 
}

#pragma mark - 代理方法 -
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.imageArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor cyanColor];
    UIImageView*cellimage = [[UIImageView alloc]init];
    cellimage.frame = cell.bounds;
    
    [cellimage sd_setImageWithURL:[NSURL URLWithString: [self urlStringWithImageUrl:self.imageArray[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"home_head_image"]];
    
    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
    [selectedBGView addSubview:cellimage];
    cell.backgroundView = cellimage;

  
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark ---tabviewdelegate-------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        
        
        return PROPORTION_HIGHT(150);
        
    }
    
    return PROPORTION_HIGHT(45);
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   UibanhuiShowTableViewCell*cell=[self.banhuiShowTabView dequeueReusableCellWithIdentifier:banhuiShowCellID];
    if (indexPath.row ==0) {
        cell.leftLa.text = @"活动名称";
        cell.rightLa.text = self.model.meetingplace;
    }else if (indexPath.row ==1){
        cell.leftLa.text = @"活动负责人";
        cell.rightLa.text = self.model.meetingplace;
        
    }else if (indexPath.row==2){
        cell.rightLa.text = [NSString stringWithFormat:@"%@",self.model.meetingtime];
        cell.leftLa.text = @"活动时间";
        
    }else{
        cell.rightLa.height = PROPORTION_HIGHT(150);
        cell.leftLa.text = @"培训内容";
        cell.rightLa.text = self.model.meetingcontent;
        cell.rightLa.textAlignment = NSTextAlignmentCenter;
    }
    
    
    return cell;
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
