//
//  JiaojiebanShowViewController.m
//  WiseAPP
//
//  Created by yst911521 on 2016/11/21.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "JiaojiebanShowViewController.h"
#import "JiaojiebanModel.h"
#import "UIImageView+WebCache.h"
#import "JiaojiebanAddViewController.h"
#import "JiaojiebanViewController.h"

@interface JiaojiebanShowViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UILabel* contentLa;
@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)UIButton* deleteBtn;
@property(nonatomic,strong)UIButton* editorBtn;
@property(nonatomic,strong)NSMutableArray* imageArray;
@end

@implementation JiaojiebanShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"交接班注意事项";
    [self addView];
    [self addData];
}
-(void)addData{
   self.imageArray=[NSMutableArray array];
    for (NSDictionary*dic in self.model.image) {
        [self.imageArray addObject: dic[@"image"]];
    }


}
-(void)addView{
    
    UIView*view=[[UIView alloc]init];
    view.backgroundColor=[UIColor whiteColor];
    view.frame = CGRectMake(0, 20, SCREEN_WIDTH, PROPORTION_HIGHT(350));
    [self.view addSubview:view];
    
    UILabel*la=[[UILabel alloc]init];
    la.frame =CGRectMake(10, 0, SCREEN_WIDTH-20, 20);
    la.text =@"交接班注意事项";
    [view addSubview:la];
    self.titleLabel =[[UILabel alloc]init];
    self.titleLabel.frame =CGRectMake(10, CGRectGetMaxY(la.frame)+10, SCREEN_WIDTH-20, 20);
    //self.titleLabel.text =@"交接班注意事项";
    self.titleLabel.backgroundColor=[UIColor whiteColor];
    [view addSubview:self.titleLabel];
    
    UILabel* conla=[[UILabel alloc]init];
    conla.frame =CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame)+10, SCREEN_WIDTH-20, 20);
    conla.text =@"交接班注意事项交接班注意事项";    [view addSubview:conla];
    
    self.contentLa =[[UILabel alloc]init];
      self.contentLa.backgroundColor=[UIColor whiteColor];
   self.contentLa.frame =CGRectMake(10, CGRectGetMaxY(conla.frame)+10, SCREEN_WIDTH-20, PROPORTION_HIGHT(150));
   //self.contentLa.text =@"交接班注意事项交接班注意事项";
    [view addSubview:self.contentLa];
    
    la.textColor=textCententColor;
    conla.textColor =textCententColor;
    la.font=[UIFont systemFontOfSize:16];
    conla.font=[UIFont systemFontOfSize:16];
    self.titleLabel.textColor=textColorPlace;
    self.contentLa.textColor=textColorPlace;
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    self.contentLa.font=[UIFont systemFontOfSize:16];

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
    
    [view addSubview:self.collectionView];
    
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

    //赋值
    self.titleLabel.text =self.model.mattername;
    self.contentLa.text =self.model.matter;
    [self.deleteBtn addTarget:self action:@selector(delegateAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.editorBtn addTarget:self action:@selector(updateAction:) forControlEvents:(UIControlEventTouchUpInside)];
 
}

-(void)delegateAction:(UIButton*)sender{

    [self delegateJiaojiebanNeedID:self.model.jiaojiebanID];

}
-(void)updateAction:(UIButton*)sender{
    JiaojiebanAddViewController* addVC=[[JiaojiebanAddViewController alloc]init];
    addVC.nextPageType = 1;
    addVC.model = self.model;
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
    
    
    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
    [dic setObject:@(jiaojiebanId) forKey:@"id"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"precautionDelete"] Token:self.tokenString parmpar:dic succeed:^(id data) {
        NSLog(@"aaaaaa%@",[data allValues]);
        [self turnPage];
    } failure:^(NSError *error) {
        
    }];
    
}

//跳转
-(void)turnPage{
    
    for (UIViewController* controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[JiaojiebanViewController class]]) {
            JiaojiebanViewController* yezhuShowVC =(JiaojiebanViewController*)controller;
            [self.navigationController popToViewController:yezhuShowVC animated:YES];
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
