//
//  XunjianquanshuAddViewController.m
//  WiseAPP
//
//  Created by app on 16/11/4.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XunjianquanshuAddViewController.h"
#import "XunjianquanshuTableViewCell.h"
#import "XunjiandanModel.h"
#import "XunjianquanshuViewController.h"
#import "XunjianQuanshuModel.h"

@interface XunjianquanshuAddViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,passTimHMvalue>
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)UITableView* xunjianquanshuTabView;
@property(nonatomic,strong)NSMutableArray* selectArray;
@property(nonatomic,strong)NSMutableArray* timeArray;
@property(nonatomic,strong)XunjiandanModel*dianweimodel;
@property(nonatomic,assign)int  pointID;
@property(nonatomic,strong)NSString*  pointTime;
@property(nonatomic,strong)NSString* pointName;
@property(nonatomic,strong)NSString* pointStrTime;
@property(nonatomic,strong)NSString* popTime;


@end
static NSString* xunjianquanshucellID=@"xunjianquanshucellID";
@implementation XunjianquanshuAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectArray=[NSMutableArray array];
    self.timeArray=[NSMutableArray array];
    self.navigationItem.title =@"选择巡检圈数设置";
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    [self addData];
    [self addView];
    
}
-(void)saveAction:(UIButton*)sender{
    
       NSLog(@"PPPMMMMM%@------%@", self.selectArray,self.timeArray);//巡检点位 和时间数组
    
//    if (self.uppageType==1) {
//        
//    } else {
       [self addxunjianquasnhuAdd];
//    }

    
}
-(void)addxunjianquasnhuAdd{

    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:@([ID intValue]) forKey:@"projectid"];
//    [param setObject:@(self.pointID) forKey:@"Inspectionpoint[]"];
//    [param setObject:@(29) forKey:@"Inspectionpoint[]"];
//
//    [param setObject:@"12:00" forKey:@"Inspectiontime[]"];
 
//    
//    NSMutableString *ids = [NSMutableString stringWithString:@"["];
//    for (ConsultationAppointmentDoctorDto *consulDoctorin self.consulAppointDto.doctors) {
//        [idsappendFormat:@"'%@',",consulDoctor.doctor.id_a];
//    }
//    
//    NSString *idStr = [NSStringstringWithFormat:@"%@]",[idssubstringWithRange:NSMakeRange(0, [idslength]-1)]]
    
    
    NSMutableArray* test=[NSMutableArray array];
     test=(NSMutableArray*)@[@41,@42,@44];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity: test.count];
    //第一种情况
    for (NSString *model in  test) {
        [array addObject:model];
    }
    NSLog(@"AAAAAAAAA%@",array);
    NSMutableArray* testtime=[NSMutableArray array];
   testtime=(NSMutableArray*)@[@41,@42];
    NSMutableArray *timearray = [NSMutableArray arrayWithCapacity: testtime.count];
    //第一种情况
    for (NSString *model in  testtime) {
        [timearray addObject:model];
    }
    NSLog(@"BBBBBBBB%@",timearray);
    
    //json
    NSMutableArray* POINT=[NSMutableArray array];
    POINT=(NSMutableArray*)@[@40];
     NSData*dataJS=[self toJSONData:POINT];
    NSString *jsonStringgg = [[NSString alloc] initWithData:dataJS
                                                   encoding:NSUTF8StringEncoding];
    NSMutableArray* pointTime=[NSMutableArray array];
    pointTime=(NSMutableArray*)@[@40];
    NSData*dataJSs=[self toJSONData:POINT];
    NSString *jsonString = [[NSString alloc] initWithData:dataJSs
                                                   encoding:NSUTF8StringEncoding];

    //[param setObject:@"40" forKey:@"Inspectionpoint[]"];
     // [param setObject:array forKey:@"Inspectionpoint[]"];
     [param setObject:@(40) forKey:@"Inspectionpoint[]"];
        [param setObject:@(41) forKey:@"Inspectionpoint[]"];
    [param setObject:timearray forKey:@"Inspectiontime[]"];
    NSLog(@"PPPPPP%@",param);
    
    //AFN3.0+基于封住HTPPSession的句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //[mutableRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];

    
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:[self urlRequestChildreurl:@"inspectiondayAdd"] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"图片上传上传成功 %@", responseObject);
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"图片上传上传失败 %@", error);
    }];
    

    
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"inspectiondayAdd"] Token:self.tokenString parmpar:param succeed:^(id data) {
        for (NSArray*array in [data allValues]) {
            
            NSLog(@"班次添加数据:%@",array);
        }
        NSLog(@"kkkkkk%@",data);
        if (data[@"resultCode"] ==0) {
            [self turnpage];
        }
        
    } failure:^(NSError *error) {
        
    }];

    

}
// 将字典或者数组转化为JSON串
- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
    
    
}
-(void)updateDate{

    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    //上传参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:@([ID intValue]) forKey:@"projectid"];
    //self.pointID
    [param setObject:@(40) forKey:@"Inspectionpoint[]"];
    
    [param setObject:@(2300) forKey:@"Inspectiontime[]"];
    NSLog(@"PPPPPP%@",param);
    
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"inspectiondayUpdate"] Token:self.tokenString parmpar:param succeed:^(id data) {
        for (NSArray*array in [data allValues]) {
            
            NSLog(@"班次添加数据:%@",array);
        }
        NSLog(@"kkkkkk%@",data);
        if (data[@"resultCode"] ==0) {
            [self turnpage];
        }
        
    } failure:^(NSError *error) {
        
    }];

}
//编辑完成跳转到首页
-(void)turnpage{
    
    for (UIViewController*controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[XunjianquanshuViewController class]]) {
            XunjianquanshuViewController*bancVC=(XunjianquanshuViewController*)controller;
            [self.navigationController popToViewController:bancVC animated:YES];
        }
    }
    
}

-(void)addData{
    self.dataArray=[NSMutableArray array];
    NSDictionary*parm = @{@"projectid":@"1"};
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"inspectionpointsList"] Token:self.tokenString parmpar:parm succeed:^(id data) {
    
        for (NSDictionary*dic in data[@"resultMessage"]) {
            XunjiandanModel*model=[XunjiandanModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            self.dianweimodel =model;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.dataArray.count==0) {
                    [self AlerVCtitleString:@"提示" messageString:@"暂无巡检点位，返回添加巡检点位" doneString:@"确定"];
                }
            });
            
            
            [self.xunjianquanshuTabView reloadData];
 
        }
        
        
    } failure:^(NSError *error) {
        
    }];


}
-(void) addView{

    self.xunjianquanshuTabView=[[UITableView alloc]initWithFrame:UIScreenBpunds style:(UITableViewStylePlain)];
    [self.view addSubview:self.xunjianquanshuTabView];
    self.xunjianquanshuTabView.dataSource =self;
    self.xunjianquanshuTabView.delegate = self;
    self.xunjianquanshuTabView.backgroundColor=GlobBackGroundColor;
  //  [self.xunjianquanshuTabView registerClass:[XunjianquanshuTableViewCell class] forCellReuseIdentifier:xunjianquanshucellID];

}

#pragma mark ---------tableviewDelegate--------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PROPORTION_HIGHT(45);
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XunjianquanshuTableViewCell*cell=[self.xunjianquanshuTabView dequeueReusableCellWithIdentifier:xunjianquanshucellID];
    if (!cell) {
        cell=[[XunjianquanshuTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:xunjianquanshucellID];
    }
   
    cell.leftBtn.tag = 1300+indexPath.row;
    cell.rightLa.tag = 1400+indexPath.row;
   cell.rightLa.delegate=self;
    [cell.leftBtn addTarget:self action:@selector(leftSelectBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
      cell.leftNumLa.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    //testData
    cell.rightLa.text =[NSString stringWithFormat:@"%ld",indexPath.row+1];
   
    XunjiandanModel*model=self.dataArray[indexPath.row];
       cell.leftAdressLa.text = model.inspectionname;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.xunjianquanshuTabView.tableFooterView=[[UIView alloc]init];
    return  cell;
}
-(void)leftSelectBtnAction:(UIButton*)sender{
    sender.selected = !sender.selected;
//    NSIndexPath* index=[self.xunjianquanshuTabView indexPathForSelectedRow];
//    XunjianquanshuTableViewCell*cell=[self.xunjianquanshuTabView cellForRowAtIndexPath:index];
    //获取cell下标
    UIView *superView = sender.superview;
    
    UITableViewCell *foundSuperView = nil;
    
    while (nil != superView && nil == foundSuperView) {
        
        if ([superView isKindOfClass:[UITableViewCell class]]) {
            
            foundSuperView = (UITableViewCell *)superView;
            
        } else {
            
            superView = superView.superview;
            
        }
        
    }

    //select button yes
    if (sender.selected == YES) {
        XunjiandanModel*model =self.dataArray [sender.tag -1300];
        self.pointID = model.xunjiandianID;

        self.pointName= model.inspectionname;
        
        
        NSInteger rightFi =1400+ [self.xunjianquanshuTabView indexPathForCell:foundSuperView].row;
        UITextField*file=(UITextField*)[self.view viewWithTag:rightFi];
        self.pointStrTime =file.text;
        [self.selectArray addObject:self.pointName];
        [self.timeArray addObject:self.pointStrTime];
        
    }else{
        NSLog(@"未选中");
        XunjiandanModel*model =self.dataArray [sender.tag -1300];
        self.pointID = model.xunjiandianID;
        self.pointName= model.inspectionname;
        NSInteger rightFi =1400+ [self.xunjianquanshuTabView indexPathForCell:foundSuperView].row;
        UITextField*file=(UITextField*)[self.view viewWithTag:rightFi];
        self.pointStrTime =file.text;
        
        [self.selectArray removeObject:  self.pointName];
        [self.timeArray  removeObject: self.pointStrTime];
    }

    [self.xunjianquanshuTabView reloadData];

   
}
#pragma mark -----textdelegate-------
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //turn page
    
    TimeDHViewController*daVC=[[TimeDHViewController alloc]init];
    daVC.modalTransitionStyle= UIModalPresentationNone;
    daVC.delegate =self;
    daVC.title = @"开始时间";
    daVC.uppagetype=@"开始时间";
    [self presentViewController:daVC animated:YES completion:nil];
    [self.xunjianquanshuTabView reloadData];
    
}
-(void)passTime:(NSString *)timeString type:(NSString *)typeString{
  
    NSIndexPath*index=[self.xunjianquanshuTabView indexPathForSelectedRow];
    XunjianquanshuTableViewCell*cell=[self.xunjianquanshuTabView cellForRowAtIndexPath:index];
    cell.rightLa.text =typeString;
    self.popTime=typeString;
    
    [self.xunjianquanshuTabView reloadData];
    
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    XunjiandanModel*model=self.dataArray[indexPath.row];
//    [self.selectArray addObject:model];
//    self.pointID =model.id;
//    NSLog(@"MMM%@",self.selectArray);
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
