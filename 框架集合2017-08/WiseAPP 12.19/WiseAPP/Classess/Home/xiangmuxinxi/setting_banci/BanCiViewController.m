//
//  BanCiViewController.m
//  WiseAPP
//
//  Created by app on 16/10/12.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BanCiViewController.h"
#import "BanciAddViewController.h"
#import "BanciTableViewCell.h"
#import "BanciModel.h"


@interface BanCiViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong) NSMutableArray* passArray;
@property(nonatomic,strong)NSMutableDictionary* paddDic;
@property(nonatomic,strong)UILabel* superLabel;
@property(nonatomic,strong)NSMutableArray* dateArray;
@property(nonatomic,strong)UIView* footView;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)UIButton* addBtn;
@property(nonatomic,strong)UITableView* banciTableview;

//@property(nonatomic,assign)NSInteger getDataType;

@end

static NSString*banciCellID = @"banciMaincellID";
@implementation BanCiViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

-(void)viewWillAppear:(BOOL)animated{
     [self creatData];
    [self.banciTableview reloadData];
   
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"班次设置";
     //[self creatData];
     [self creatTableView];
}
//数据
-(void)creatData{
    self.dataArray =nil;

   NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];

    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //账号密码
    [param setObject:ID forKey:@"projectid"];
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"serviceList"] Token:self.tokenString parmpar:param succeed:^(id data) {
        for (NSDictionary*dic in data[@"resultMessage"]) {
                        BanciModel*model=[BanciModel new];
                        [model setValuesForKeysWithDictionary:dic];
                        [self.dataArray addObject:model];
            
            if (self.dataArray.count !=0) {
                self.banciTableview.tableHeaderView =[[UIView alloc]init];
            }
                        [self.banciTableview reloadData];
                    }
  
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)creatTableView{
    
    self.headView =[[UIView alloc]init];
    self.headView .frame = UIScreenBpunds;
    self.headView.backgroundColor= GlobBackGroundColor;
    self.headView.hidden = YES;
    //添加footview
    self.footView=[[UIView alloc]init];
    self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    self.footView.backgroundColor = GlobBackGroundColor;
    self.footView.hidden = NO;
    
    self.banciTableview.hidden = YES;
    self.view.backgroundColor= GlobBackGroundColor;
    self.banciTableview.backgroundColor = GlobBackGroundColor;
    self.banciTableview=[[UITableView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview: self.banciTableview];
   self.banciTableview.delegate = self;
   self.banciTableview.dataSource = self;
    [ self.banciTableview registerClass:[BanciTableViewCell class] forCellReuseIdentifier:banciCellID];
   self.banciTableview.tableFooterView = self.footView;
    self.banciTableview.tableHeaderView =self.headView;
    
    
    self.addBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.addBtn.frame = CGRectMake(0, 0, PROPORTION_WIDTH(60), PROPORTION_HIGHT(60));
    self.addBtn.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-100);
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"home_add.png"] forState:(UIControlStateNormal)];
    self.footView.hidden = YES;
    [self.view addSubview:self.addBtn];
    
    if (self.dataArray.count ==0) {
        self.view.backgroundColor= GlobBackGroundColor;
        //第一次为空 提示添加
        [self  noDataPageLabel];
        self.banciTableview.tableHeaderView =self.headView;
        self.headView.hidden = NO;
    }else{
        //self.tableview.tableHeaderView = [[UIView alloc]init];
        self.headView.hidden = YES;
    }
    
    [self.addBtn addTarget:self action:@selector(banciaddAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)noDataPageLabel{
    
    //超链接label
    //添加手势的方法
    self.superLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 40)];
    [self.headView addSubview:self.superLabel];
    self.superLabel.textAlignment = NSTextAlignmentCenter;
    //Using NSAttributed String
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"还没有任何信息,去添加信息!"];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 7)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(8,3)];
    
    self.superLabel.attributedText = str;
    UITapGestureRecognizer*tapRecognizer1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(banciSettingAction:)];
    //打开交互
    self.superLabel.userInteractionEnabled=YES;
    [ self.superLabel addGestureRecognizer:tapRecognizer1];
    self.superLabel.hidden = NO;
    
}
-(void)banciaddAction:(UIButton*)sender

{
    BanciAddViewController*addVC=[[BanciAddViewController alloc]init];
    addVC.navigationItem.title = @"班次设置";
    [self.navigationController pushViewController:addVC animated:YES];
    
}

-(void)banciSettingAction:(id)sender
{
  BanciAddViewController*addVC=[[BanciAddViewController alloc]init];
    addVC.navigationItem.title = @"班次设置";
    [self.navigationController pushViewController:addVC animated:YES];
    
}
#pragma mark ====== tableviewddelegate==========
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;

}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    //删除
    return UITableViewCellEditingStyleDelete;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    BanciModel*model =self.dataArray[indexPath.row];
    [self deleteBanciRequestBanCiId:model.banciID];
    //删除
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:indexPath.row];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return PROPORTION_HIGHT(45);
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

   BanciTableViewCell *cell  =[self.banciTableview dequeueReusableCellWithIdentifier:banciCellID];

    BanciModel*model=self.dataArray[indexPath.row];
    if (model.servicesname.length ==0) {
        NSLog(@"数据请求失败");
    }else{
    cell.titleLabel.text = model.servicesname;
    cell.starTime .text = model.starttime;
    cell.endTimeLabel.text = [NSString stringWithFormat:@"-   %@",model.endtime];
        cell.editorBtn.tag = 200+ indexPath.row;
  [cell.editorBtn addTarget:self action:@selector(editorBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }

    return  cell;
}
-(void)editorBtn:(UIButton*)sender{

    BanciModel*model=self.dataArray[sender.tag -200];
    BanciAddViewController*banciAddVC =[[BanciAddViewController alloc]init];
    banciAddVC.banciModel = model;
    banciAddVC.editorType = 1;
    [self.navigationController pushViewController:banciAddVC animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    BanciModel*model=self.dataArray[indexPath.row];
    BanciAddViewController*banciAddVC =[[BanciAddViewController alloc]init];
    banciAddVC.banciModel = model;
    banciAddVC.editorType = 1;
    [self.navigationController pushViewController:banciAddVC animated:YES];

 }
//删除班次
-(void)deleteBanciRequestBanCiId:(int)banciId{

    NSMutableDictionary*param=[NSMutableDictionary dictionary];
    //   // [param setObject:@(1) forKey:@"Id"];
    [param setObject:@(banciId) forKey:@"id"];

    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"serviceDelete"] Token:self.tokenString parmpar:param succeed:^(id data) {
        NSLog(@"删除班次---%@",data);
    } failure:^(NSError *error) {
        
    }];
 

}



//删除
//-(void)Deleterequest{
//  
//    NSString* tokenString=  [[LoginMessageManger loginMessageSingleManger].loginMangerDic objectForKey:@"loginToken"];
//    // 1.设置请求路径
//   // NSURL *URL=[NSURL URLWithString:[self urlRequestChildreurl:@"serviceDelete"]];//不需要传递参数
//    NSURL *URL=[NSURL URLWithString:@"http://118.178.88.132:8000/api/serviceDelete"];
//    //    2.创建请求对象
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
//    request.timeoutInterval=5.0;//设置请求超时为5秒
//    request.HTTPMethod=@"GET";//设置请求方法
//    [request addValue:tokenString forHTTPHeaderField:@"token"];
//    //账号密码
//    //设置请求体
//    NSString *param=[NSString stringWithFormat:@"Id=%@",@(1)];//
//    NSLog(@"----%@",param);
//    
//    //把拼接后的字符串转换为data，设置请求体
//    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSURLSession*session=[NSURLSession sharedSession];
//    NSURLSessionTask*task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//   
//        NSLog(@"88888888*****%@",data);
//        
//    } ];
//    
//    [task resume];
//    
//}





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
