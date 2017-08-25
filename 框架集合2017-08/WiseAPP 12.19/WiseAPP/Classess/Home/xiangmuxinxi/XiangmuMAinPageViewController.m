//
//  XiangmuMAinPageViewController.m
//  WiseAPP
//
//  Created by app on 16/10/14.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XiangmuMAinPageViewController.h"
#import "SettingViewController.h"
#import "XiangmuMainCollectionViewCell.h"
#import "SectionModel.h"
#import "AFHTTPSessionManager.h"
#import "XiangmuMainModel.h"


NS_ENUM(NSInteger,CellState){
    
    //右上角编辑按钮的两种状态；
    //正常的状态，按钮显示“编辑”;
    NormalState,
    //正在删除时候的状态，按钮显示“完成”；
    DeleteState
    
};


@interface XiangmuMAinPageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
   
}
@property(nonatomic,assign)NSInteger requestType;
@property(nonatomic,strong)UICollectionView*collectView;
@property(nonatomic,strong)NSMutableArray*dataArray;
//@property(nullable,strong)XiangmuMainModel* xiangmumodel;
@end

static NSString*collectId= @"collectID";

@implementation XiangmuMAinPageViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return  _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.requestType =2;
    self.navigationItem.title =@"添加项目";
    
    UIImage*moreImage = [UIImage imageNamed:@"icon_home_sousou"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:moreImage style:(UIBarButtonItemStylePlain) target:self action:@selector(rightItemAction:)];
   // self.xiangmumodel=[[XiangmuMainModel alloc]init];
  
    [self addData];

   // [self getAdress];
    
}
-(void)addData{
     // self.dataArray =(NSMutableArray*)@[@"文化广场",@"国金中心",@"汇德丰"];
    
    NSString* tokenString=  [[LoginMessageManger loginMessageSingleManger].loginMangerDic objectForKey:@"loginToken"];
    NSLog(@"%@",tokenString);
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //账号密码
    [param setObject:tokenString forKey:@"token"];
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manger.requestSerializer setValue:tokenString forHTTPHeaderField:@"token"];
    
      NSString *url = @"http://118.178.88.132:8000/api/projectsList";
    NSLog(@"DDDDDD%@",param);
    
    [manger GET:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        
        //创建UI
        dispatch_async(dispatch_get_main_queue(), ^{
                [self creaTUI];
        });
        
        for (NSDictionary*ARR in responseObject[@"resultMessage"]) {
      
            
            XiangmuMainModel*model=[XiangmuMainModel new];
            [model setValuesForKeysWithDictionary:ARR];

              [self.dataArray addObject:model];

            
            }
        self.requestType =1;
        [self.collectView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    

  


}



-(void)rightItemAction:(UIBarButtonItem*)sender{
    
    self.collectView.backgroundColor=[UIColor yellowColor];
    
    
}


-(void)creaTUI{
    
    NSLog(@"ddddaaayy%lu--%@",(unsigned long)self.dataArray.count,self.dataArray);

    //创建布局对象
    UICollectionViewFlowLayout*flowlayout=[[UICollectionViewFlowLayout alloc]init];
    
    
    //上左下右的间距
    flowlayout.sectionInset = UIEdgeInsetsMake(PROPORTION_HIGHT(20),PROPORTION_WIDTH(37),PROPORTION_HIGHT(10),PROPORTION_WIDTH(37));

    flowlayout.itemSize =CGSizeMake((SCREEN_WIDTH-PROPORTION_WIDTH(37)*2), PROPORTION_HIGHT(78));
    
    //设置滑动方向
    //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    //初始化
    self.collectView =[[UICollectionView alloc]initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)   collectionViewLayout:flowlayout];
    
    //背景色
    self.collectView.backgroundColor=GlobBackGroundColor;
    
    self.collectView.dataSource =self;
    
    self.collectView.delegate =self;
    
    [self.view addSubview:self.collectView];
    
    [self.collectView registerClass:[XiangmuMainCollectionViewCell class] forCellWithReuseIdentifier:collectId];
}
#pragma mark ========datasourse方法==============
//设置分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 1;
    
}

//设置单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    //return self.collectDataArray.count;

    return self.dataArray.count ;
  
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   XiangmuMainCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier: collectId forIndexPath:indexPath];
    
    
    // cell点击变色
    
    UIImageView*imageV = [[UIImageView alloc]init];
    imageV.frame = cell.bounds;
    imageV.image = [UIImage imageNamed:@"Rectangle 2  8"];
    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBGView.backgroundColor = [UIColor grayColor];
    [selectedBGView addSubview:imageV];
    cell.selectedBackgroundView = selectedBGView;
   // cell.backgroundColor =[UIColor greenColor];
    
    XiangmuMainModel*model=self.dataArray[indexPath.item];
    
     cell.xiangmuTitle.text = model.projectname;
   
    
  
    
    return  cell;
}


//点击跳转
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.requestType ==1) {
        SettingViewController*settingVC = [[SettingViewController alloc]init];
        XiangmuMainModel*model = self.dataArray[indexPath.row];
        settingVC.model = model;
        NSString*strID=[NSString stringWithFormat:@"%d",model.xuangmuxinxiID];
        //保存项目ID
        [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic setObject:strID forKey:@"projectId"];
        
        [self.navigationController pushViewController:settingVC animated:YES];
    } else {
        [self AlerVCtitleString:@"提示" messageString:@"无法获取项目信息,请重新获取" doneString:@"确定"];
    }
    

}


//// cell点击变色
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
