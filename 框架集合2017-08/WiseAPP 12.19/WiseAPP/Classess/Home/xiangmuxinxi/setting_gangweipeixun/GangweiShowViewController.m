//
//  GangweiShowViewController.m
//  WiseAPP
//
//  Created by app on 16/11/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "GangweiShowViewController.h"
#import "GangweiModel.h"
#import "GangweiAddViewController.h"


@interface GangweiShowViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray*collectDataArray;
@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)UIView* bgView;
@property(nonatomic,strong)UILabel* titleLa;
@property(nonatomic,strong)UILabel* contentLa;
@property(nonatomic,strong)UIButton* deleteBtn;
@property(nonatomic,strong)UIButton* editorBtn;
@property(nonatomic,strong)NSMutableArray*imageArray;

@end

@implementation GangweiShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self addData];
    [self addView];

}
-(void)addData{
    
    self.imageArray=[NSMutableArray array];
    for (NSDictionary*dic in self.model.image) {
        [self.imageArray addObject: dic[@"image"]];
    }
    
    
    
}

-(void)addView{
    self.bgView =[[UIView alloc]init];
    self.bgView.frame = CGRectMake(0, 20, SCREEN_WIDTH, PROPORTION_HIGHT(SCREEN_HEIGHT-200));
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.bgView];
    self.titleLa=[[UILabel alloc]init];
    self.titleLa.frame =CGRectMake(10, 0, SCREEN_WIDTH-20, 30);
    //self.titleLa.backgroundColor=[UIColor redColor];
    [self.bgView addSubview:self.titleLa];
    
    self.contentLa=[[UILabel alloc]init];
    self.contentLa.frame =CGRectMake(10, CGRectGetMaxY(self.titleLa.frame), SCREEN_WIDTH-20, PROPORTION_HIGHT(200));
   // self.contentLa.backgroundColor=[UIColor greenColor];
    [self.bgView addSubview:self.contentLa];
    self.contentLa.numberOfLines =0;
 
    //创建布局对象
    UICollectionViewFlowLayout*flowlayout=[[UICollectionViewFlowLayout alloc]init];
    
    //距离屏幕上下左右的间距
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //flowlayout.itemSize =CGSizeMake(SCREEN_WIDTH-50*SCREEN_WIDTH/375, 78*SCREEN_HEIGHT*667);
    flowlayout.itemSize =CGSizeMake((SCREEN_WIDTH-50)/4,(SCREEN_WIDTH-50)/4);
    
    //初始化
    self.collectionView =[[UICollectionView alloc]initWithFrame: CGRectMake(0, CGRectGetMaxY(self.contentLa.frame)+10, SCREEN_WIDTH, 250)   collectionViewLayout:flowlayout];
    //背景色
    //self.collectionView.backgroundColor=GlobBackGroundColor;
    self.collectionView.backgroundColor= [UIColor whiteColor];
    self.collectionView.dataSource =self;
    
    self.collectionView.delegate =self;
    
    [self.bgView addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.deleteBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.deleteBtn.frame =CGRectMake(10, SCREEN_HEIGHT-PROPORTION_HIGHT(120),SCREEN_WIDTH/2-PROPORTION_WIDTH(10), PROPORTION_HIGHT(45));
    [self.view addSubview:self.deleteBtn];
    KUIbutton(self.deleteBtn);
    KUIbuttonClick(self.deleteBtn);
    [self.deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    
    
    self.editorBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.editorBtn.frame =CGRectMake(CGRectGetMaxX(self.deleteBtn.frame)+10, SCREEN_HEIGHT-PROPORTION_HIGHT(120), SCREEN_WIDTH/2-PROPORTION_WIDTH(15), PROPORTION_HIGHT(45));
    self.editorBtn.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:self.editorBtn];
    KUIbutton(self.editorBtn);
    KUIbuttonClick(self.editorBtn);
    [self.editorBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
    
 
    [self.deleteBtn addTarget:self action:@selector(delegateAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.editorBtn addTarget:self action:@selector(updateAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //赋值
    self.titleLa.text =self.model.trainingname;
    self.contentLa.text =self.model.trainingcontent;
 
}

-(void)delegateAction:(UIButton*)sender{
    
    [self delegateJiaojiebanNeedID:self.model.gangweipeixunID];
    
}
-(void)updateAction:(UIButton*)sender{
    GangweiAddViewController*addVC=[[GangweiAddViewController alloc]init];
    addVC.model =self.model;
    addVC.gangweiUppgType =1;
    [self.navigationController pushViewController:addVC animated:YES];
}



#pragma mark - 代理方法 -
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
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


//删除后台数据
-(void)delegateJiaojiebanNeedID:(int)jiaojiebanId{

//    NSString*strid=[NSString stringWithFormat:@"%d",gangweiid];
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    [dic setObject:@(jiaojiebanId) forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"jobtrainingDelete"] Token:self.tokenString parmpar:dic succeed:^(id data) {
        
        for (NSArray*arrray in [data allValues]) {
            NSLog(@"hhh%@",arrray);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
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
