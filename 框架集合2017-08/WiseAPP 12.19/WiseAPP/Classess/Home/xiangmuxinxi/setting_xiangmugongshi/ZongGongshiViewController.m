//
//  ZongGongshiViewController.m
//  WiseAPP
//
//  Created by app on 16/10/31.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "ZongGongshiViewController.h"
#import "ZonggongshiView.h"
#import "LDCalendarView.h" //日历
#import "NSDate+extend.h"
#import "ZonggongshiTableViewCell.h"
#import "BanciModel.h"

@interface ZongGongshiViewController ()<UITableViewDelegate,UITableViewDataSource>
//@property(nonatomic,strong)ZonggongshiView*zonggongshiView;
@property (nonatomic, strong)LDCalendarView    *calendarView;//日历控件
@property (nonatomic, strong)NSMutableArray *seletedDays;//选择的日期

@property(nonatomic,strong)UIScrollView* scroView;
@property(nonatomic,strong)UIView* bgView;

@property (nonatomic, copy)NSString *showStr;
@property(nonatomic,strong)UIView* upView;
@property(nonatomic,strong)UILabel* gongshiNumLa;
@property(nonatomic,strong)UILabel* showLa;
@property(nonatomic,strong)UITableView* zonggongshiTabview;
@property(nonatomic,strong)NSMutableArray* datadArray;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)NSMutableArray* montnDaayArray;

@end

@implementation ZongGongshiViewController
-(NSMutableArray *)datadArray{
    if (!_datadArray) {
        _datadArray=[NSMutableArray array];
    }
    return _datadArray;
}
//日历返回数据处理
- (NSString *)showStr {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"已选择日期:\r\n"];
    //从小到大排序
    [self.seletedDays sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [obj1 compare:obj2];
    }];
    for (NSNumber *interval in self.seletedDays) {
        NSString *partStr = [NSDate stringWithTimestamp:interval.doubleValue/1000.0 format:@"MM-dd"];
        [str appendFormat:@"%@ ",partStr];
    }
  
    return [str copy];
}

//-(void)loadView{
//    self.zonggongshiView=[[ZonggongshiView alloc]initWithFrame:UIScreenBpunds];
//    self.view = self.zonggongshiView;
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addView];
    [self addData];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];

}
-(void)saveAction:(UIButton*)sender{
    self.montnDaayArray=[NSMutableArray array];
    //LDCalendarView* caleView=[[LDCalendarView alloc]init];
    NSLog(@"%@KKKKKMMMM%@--%@",self.calendarView.titleLab.text,[self showStr],self.seletedDays);
    //1.截取字符串
    
    NSString *string =self.calendarView.titleLab.text;
    NSString *month = [string substringToIndex:2];//截取掉下标5之前的字符串

  //  NSString *str2 = [string substringFromIndex:3];//截取掉下标3之后的字符串
        NSString* year =[self mainString:string subStringFrom:@"," to:@"年"];
    //NSString* ym=[NSString stringWithFormat:@"%@-%@",year,month];
    
    //获取日期处理
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"已选择日期:\r\n"];
    //从小到大排序
    [self.seletedDays sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [obj1 compare:obj2];
    }];
    for (NSNumber *interval in self.seletedDays) {
        NSString *partStr = [NSDate stringWithTimestamp:interval.doubleValue/1000.0 format:@"MM-dd"];
        [str appendFormat:@"%@ ",partStr];
       // NSString*md=[self stringFromHexString:str];
       
    }
    NSString* ymd =[NSString stringWithFormat:@"%@-%@",year,str];
    [self.montnDaayArray addObject:ymd];
    NSLog(@"MMMMMM%@",self.montnDaayArray);
      NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
//    
    NSMutableArray*people=(NSMutableArray*)@[@"11",@"22"];
//    NSString*peopleStr=[self dictionaryOrArrrayToJSONData:people];
//
//  
    NSMutableDictionary*parm =[NSMutableDictionary dictionary];
//    NSString*DAY=[[NSString alloc]init];
//    for(int i =0;i<2;i++){
//        DAY=[NSString stringWithFormat:@"2017-12-2%d",i];
//         [parm setObject:DAY forKey:@"date"];
//    }
    [parm setObject:@"2017-01-01" forKey:@"date"];
    [parm setObject:ID forKey:@"projectid"];
//    [parm setObject:@(60) forKey:@"serviceid[]"];
//    [parm setObject:@(23) forKey:@"Servicepeople[]"];
//    NSInteger imgCount = 0;
//    if (people.count != 0) {
//        for (NSString* peopleN in people) {
//            
//    [parm setObject:@([peopleN intValue]) forKey:@"Servicepeople[]"];
//            
//         
//            imgCount++;
//            
//        }
//    }
//
  
     NSMutableString *ids = [NSMutableString stringWithString:@"["];
    for (NSString *consulDoctor in people ) {
        [ids appendFormat:@"'%@',",@([consulDoctor intValue])];
    }
    NSString *idStr = [NSString stringWithFormat:@"%@]",[ids substringWithRange:NSMakeRange(0, [ids length]-1)]];
//    "Servicepeople[]" = "['11','22']";
//    date = "2017-01-01";
//    projectid = 1;
//    "serviceid[]" = 63;

    [parm setObject:@"63" forKey:@"serviceid[]"];
    [parm setObject:@"32" forKey:@"Servicepeople"];
    NSLog(@"mmmmmmmmm%@",parm);
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"hoursAdd"] Token:self.tokenString parmpar:parm succeed:^(id data) {
        NSLog(@"总工时%@",data);
        
    } failure:^(NSError *error) {
        
    }];
//
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
  [manager.requestSerializer setValue:self.tokenString forHTTPHeaderField:@"token"];
    
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:[self urlRequestChildreurl:@"hoursAdd"] parameters:parm constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"工时添加 %@", responseObject);
        for (NSArray*array in [responseObject allValues]) {
            
            NSLog(@"图片上传 %@",array);
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
         
            
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"图片上传上传失败 %@", error);
    }];
    

    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)addData{
  

//获得班次
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //账号密码
    [param setObject:ID forKey:@"projectid"];
    
    
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"serviceList"] Token:self.tokenString parmpar:param succeed:^(id data) {
        for (NSDictionary*dic in data[@"resultMessage"]) {
            BanciModel*model=[BanciModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.datadArray addObject:model];
            [self.zonggongshiTabview reloadData];
         
            NSLog(@"DDDD%@",data);
        }
        
    } failure:^(NSError *error) {
        
    }];
    



}

-(void)addView{

//    self.headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PROPORTION_HIGHT(500))];
//    [self.view addSubview:self.headView];
    //self.headView.backgroundColor=[UIColor greenColor];
    self.scroView =[[UIScrollView alloc]init];
    self.scroView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.scroView];
    self.scroView.contentSize =CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+PROPORTION_HIGHT(100));
    self.scroView.backgroundColor=GlobBackGroundColor;
    self.bgView =[[UIView alloc]init];
    self.bgView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+PROPORTION_HIGHT(100));
    [self.scroView addSubview:self.bgView];

    self.upView=[[UIView alloc]init];
    self.upView.frame = CGRectMake(0, 0, PROPORTION_WIDTH(80), PROPORTION_HIGHT(80));
    self.upView.center = CGPointMake(SCREEN_WIDTH/2, PROPORTION_HIGHT(40)+10);
    [self.bgView addSubview:self.upView];
    self.upView.layer.cornerRadius = self.upView.width/2;
    self.upView.layer.borderWidth = 2;
    self.upView.layer.borderColor=[UIColor blueColor].CGColor;
    
    self.showLa=[[UILabel alloc]init];
    self.showLa.frame = CGRectMake(CGRectGetMaxX(self.upView.frame)+3, 0, 120, 120);
    [self.upView addSubview:self.showLa];
 
    
    
    UILabel*upLa=[[UILabel alloc]init];
    upLa.frame = CGRectMake(self.upView.width/6, self.upView.height/4, self.upView.width-(self.upView.width/6)*2, 20);
    upLa.text = @"总计工时";
    upLa.adjustsFontSizeToFitWidth=YES;
    upLa.font =[UIFont systemFontOfSize:12];
    upLa.textColor = textCententColor;
    upLa.textAlignment =NSTextAlignmentCenter;
    [self.upView addSubview:upLa];
    
    self.gongshiNumLa=[[UILabel alloc]init];
    self.gongshiNumLa.frame =CGRectMake(upLa.x, CGRectGetMaxY(upLa.frame), upLa.width, 30);
    self.gongshiNumLa.textColor =[UIColor redColor];
    self.gongshiNumLa.font =[UIFont systemFontOfSize:14];
    self.gongshiNumLa.text =@"0";
    self.gongshiNumLa.textAlignment =NSTextAlignmentCenter;
    [self.upView addSubview:self.gongshiNumLa];
    
    //日期选择 日历
   // if (!_calendarView) {
        _calendarView = [[LDCalendarView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, PROPORTION_HIGHT(330))];
        [self.bgView addSubview:_calendarView];
        
        __weak typeof(self) weakSelf = self;
        _calendarView.complete = ^(NSArray *result) {
            if (result) {
                weakSelf.seletedDays = [result mutableCopy];
             NSLog(@"kkkkdddday%@",_seletedDays);
            }
        };
   // }
    [self.calendarView show];
    self.calendarView.backgroundColor=[UIColor redColor];
    self.calendarView.defaultDates = _seletedDays;
    
    self.showLa.text =self.showStr;
    NSLog(@"dddday%@",self.seletedDays);
    //tabview
    self.zonggongshiTabview=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendarView.frame)+10, SCREEN_WIDTH, PROPORTION_HIGHT(45*3)+PROPORTION_HIGHT(30)) style:(UITableViewStylePlain)];
    [self.bgView addSubview:  self.zonggongshiTabview];
    self.zonggongshiTabview.tableHeaderView =_headView;
    
    self.zonggongshiTabview.dataSource =self;
    self.zonggongshiTabview.delegate =self;
    [self.zonggongshiTabview registerClass:[ZonggongshiTableViewCell class] forCellReuseIdentifier:@"cell"];
    

}

#pragma mark------tableviewdelegate-------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.datadArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

   ZonggongshiTableViewCell*cell=[self.zonggongshiTabview dequeueReusableCellWithIdentifier:@"cell"];
    BanciModel*model =self.datadArray[indexPath.row];
    cell.leftla.text = model.servicesname;
     [cell.leftselectbtn addTarget:self action:@selector(selectbtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.zonggongshiTabview.tableFooterView =[[UIView alloc]init];
    return cell;
}
-(void)selectbtn:(UIButton*)sender{

    sender.selected =!sender.selected;


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
