//
//  KaoqinHomeController.m
//  WiseAPP
//
//  Created by yst911521 on 2016/11/29.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "KaoqinHomeController.h"
#import "KaoqinHomeCollectionViewCell.h"
#import "KaoqinDetaileView.h"
#import "KaoqinQiandaoController.h"//签到
#import "KaoqinQiantuiController.h"
#import "KaoqinBaogangController.h"
#import "KaoqinWaichuqiandaoController.h"
#import "KaoqinLinbaoController.h"
#import "KaoqinJiabanKaoqinController.h"
#import "KaoqintongjiController.h"

@interface KaoqinHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)UICollectionView*collectionView;
@property(nonatomic,strong)UILabel* peopoleNameLa;
@property(nonatomic,strong)UILabel* peopolePositionLa;
@property(nonatomic,strong)UILabel* weekDayLa;
@property(nonatomic,strong)UICollectionView* calerCollectView;
@property(nonatomic,strong)KaoqinDetaileView* detaileView;
@property(nonatomic,strong)NSMutableArray* iamgeArray;



@end
static NSString*cellID =@"homeKaoqincellID";
@implementation KaoqinHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addData];
    [self calenderView];
    [self creatCollectView];
}
-(void)addData{
    self.iamgeArray=[NSMutableArray array];
    self.dataArray=[NSMutableArray array];
    self.dataArray =(NSMutableArray*)@[@"签到",@"签退",@"报岗",@"加班考勤",@"临保",@"考勤统计"];
    self.iamgeArray=(NSMutableArray*)@[@"kaoqin_qiandao.png",@"kaoqin_qiantui.png",@"kapqin_baogang.png",@"kaoqin_jiabanKaoqin.png",@"kaoqin_linbao.png",@"kaoqin_tongji.png"];

}
-(void)calenderView{
    self.peopoleNameLa=[[UILabel alloc]init];
    self.peopoleNameLa.frame =CGRectMake(10, 10, PROPORTION_WIDTH(60), 20);
    self.peopoleNameLa.textColor= textCententColor;
    self.peopoleNameLa.textAlignment =NSTextAlignmentCenter;
    self.peopoleNameLa.adjustsFontSizeToFitWidth =YES;
    self.peopoleNameLa.font =[UIFont systemFontOfSize:14];
    [self.view addSubview:self.peopoleNameLa];
     self.peopoleNameLa.text = @"张三疯";
    UIView*view =[[UIView alloc]init];
    view.frame = CGRectMake(CGRectGetMaxX(self.peopoleNameLa.frame)+2, 10, 1, 20);
    [self.view addSubview:view];
    view.backgroundColor=[UIColor blueColor];

    self.peopolePositionLa=[[UILabel alloc]init];
    self.peopolePositionLa.frame =CGRectMake(CGRectGetMaxX(view.frame)+2, 10, PROPORTION_WIDTH(150), 20);
    self.peopolePositionLa.textAlignment =NSTextAlignmentLeft;
    self.peopolePositionLa.adjustsFontSizeToFitWidth =YES;
    self.peopolePositionLa.textColor = textCententColor;
    self.peopolePositionLa.font =[UIFont systemFontOfSize:14];
    [self.view addSubview:self.peopolePositionLa];
    self.peopolePositionLa.text = @"保安经理";
NSMutableArray*weekarry=(NSMutableArray*)@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];

    for (int i = 0 ; i < 7; i++) {
        self.weekDayLa=[[UILabel alloc]init];
        self.weekDayLa.frame =CGRectMake(i*SCREEN_WIDTH/7, CGRectGetMaxY(self.peopoleNameLa.frame)+2, SCREEN_WIDTH/7, PROPORTION_HIGHT(30));
        self.weekDayLa.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:self.weekDayLa];
        //self.weekDayLa.tag = 100+i;
        self.weekDayLa.textAlignment =NSTextAlignmentCenter;
        self.weekDayLa.text =weekarry[i];
    }
    //collect
    UICollectionViewFlowLayout*layout=[[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
  
    layout.itemSize = CGSizeMake((SCREEN_WIDTH)/7, PROPORTION_HIGHT(45));
    
    self.calerCollectView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.weekDayLa.frame), SCREEN_WIDTH, PROPORTION_HIGHT(45)) collectionViewLayout:layout];
    self.calerCollectView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:self.calerCollectView];
    self.calerCollectView.dataSource=self;
    self.calerCollectView.delegate =self;
    [self.calerCollectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cacell"];
    

}
#pragma mark ---- collectview-------
-(void)creatCollectView{
  
    
    //创建布局对象
    UICollectionViewFlowLayout*flowlayout=[[UICollectionViewFlowLayout alloc]init];
    
    
    //距离屏幕上下左右的间距
    flowlayout.sectionInset = UIEdgeInsetsMake(10, PROPORTION_WIDTH(38), 10, PROPORTION_WIDTH(38));
    //flowlayout.itemSize =CGSizeMake(SCREEN_WIDTH-50*SCREEN_WIDTH/375, 78*SCREEN_HEIGHT*667);
    flowlayout.itemSize =CGSizeMake(((SCREEN_WIDTH-PROPORTION_WIDTH(38*2+10)))/2,PROPORTION_HIGHT(80));
    
    //设置滑动方向
    //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

     CGRect frame =CGRectMake(0, CGRectGetMaxY(self.calerCollectView.frame)+30, SCREEN_WIDTH, SCREEN_HEIGHT-PROPORTION_HIGHT(100)) ;

    //初始化
    self.collectionView =[[UICollectionView alloc]initWithFrame: frame   collectionViewLayout:flowlayout];
 
    //背景色
    self.collectionView.backgroundColor=GlobBackGroundColor;
    
    self.collectionView.dataSource =self;
    
    self.collectionView.delegate =self;
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[KaoqinHomeCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
    
    
}
//方式item滚动
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.collectionView setContentSize:CGSizeMake(0, 0)];
}

#pragma mark ========datasourse方法==============
//设置分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 1;
    
}

//设置单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView==self.calerCollectView) {
        return 6;
    } else {
         return self.dataArray.count;
    }
   
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView ==self.calerCollectView) {
        
        UICollectionViewCell*cell=[self.calerCollectView dequeueReusableCellWithReuseIdentifier:@"cacell" forIndexPath:indexPath];
        cell.backgroundColor =[UIColor redColor];
        
        return cell;
    } else {
   
    KaoqinHomeCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier: cellID forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];

    cell.titleLabel.text=self.dataArray[indexPath.row];
        cell.iconImageView.image =[UIImage imageNamed:self.iamgeArray[indexPath.row]];
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
}


//点击跳转
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView ==self.calerCollectView){
        [self creatDetaileView];
       
    }else {
        [self turnNextPage:indexPath];
    
    }
    
    
}
//考勤详情页面
-(void)creatDetaileView{
   self.collectionView.frame =CGRectMake(0, CGRectGetMaxY(self.calerCollectView.frame)+PROPORTION_HIGHT(120), SCREEN_WIDTH, SCREEN_HEIGHT-PROPORTION_HIGHT(100)) ;
    self.detaileView=[[KaoqinDetaileView alloc]init];
    self.detaileView.frame = CGRectMake(0, CGRectGetMaxY(self.calerCollectView.frame)+5, SCREEN_WIDTH, PROPORTION_HIGHT(120));
    [self.view addSubview:self.detaileView];
    
    UITapGestureRecognizer*TAP=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.detaileView addGestureRecognizer:TAP];
    
}
-(void)tapAction:(UITapGestureRecognizer*)sender{

   self.detaileView.hidden =YES;
   self.collectionView.frame =CGRectMake(0, CGRectGetMaxY(self.calerCollectView.frame)+5, SCREEN_WIDTH, SCREEN_HEIGHT-PROPORTION_HIGHT(100)) ;
   
}

//页面跳转
-(void)turnNextPage:(NSIndexPath*)indexPath{
    if (indexPath.row ==0) {
        KaoqinQiandaoController*qiandaoVC=[[KaoqinQiandaoController alloc]init];
        qiandaoVC.navigationItem.title = @"签到";
        [self.navigationController pushViewController:qiandaoVC animated:YES];
    }else if (indexPath.row==1){
        KaoqinQiantuiController*qiantuiVC=[[KaoqinQiantuiController alloc]init];
        qiantuiVC.navigationItem.title = @"签退";
        [self.navigationController pushViewController:qiantuiVC animated:YES];
    }else if (indexPath.row ==2){
        KaoqinBaogangController*baogangVC=[[KaoqinBaogangController alloc]init];
        baogangVC.navigationItem.title=@"报岗";
        [self.navigationController pushViewController:baogangVC animated:YES];
    
    }else if (indexPath.row==3){
        KaoqinJiabanKaoqinController*jiabanVC=[[KaoqinJiabanKaoqinController alloc]init];
        jiabanVC.navigationItem.title =@"加班考勤";
        [self.navigationController pushViewController:jiabanVC animated:YES];
    }else if (indexPath.row ==4){
        KaoqinLinbaoController*linbaoVC=[[KaoqinLinbaoController alloc]init];
        linbaoVC.navigationItem.title = @"临保";
        [self.navigationController pushViewController:linbaoVC animated:YES];
    }else if (indexPath.row ==5){
       
        KaoqintongjiController*tongjiVC =[[KaoqintongjiController alloc]init];
        tongjiVC.navigationItem.title = @"考勤统计";
        [self.navigationController pushViewController:tongjiVC animated:YES];
    }
    //else if (indexPath.row==6){
//      
//        KaoqinWaichuqiandaoController*waichuqiandaoVC=[[KaoqinWaichuqiandaoController alloc]init];
//        waichuqiandaoVC.navigationItem.title = @"外出签到";
//        [self.navigationController pushViewController:waichuqiandaoVC animated:YES];
   // }
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
