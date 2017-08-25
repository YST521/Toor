//
//  KaoqinViewController.m
//  WiseAPP
//
//  Created by app on 16/10/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "KaoqinViewController.h"
#import "LocationHander.h"
#import "AnnotionModel.h"
#import<CoreLocation/CoreLocation.h>//定位
#import <MapKit/MapKit.h> //地图
#import "KaoqinModel.h"
#import "KoaqinTableViewCell.h"
#import "CityViewController.h"

@interface KaoqinViewController ()<CLLocationManagerDelegate,MKMapViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MKMapView* mapView;
//创建管理者
@property(nonatomic,strong)UITableView* kaoqinTableView;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)NSMutableArray* requestDataArray;

@property(nonatomic,strong)UILabel* longitude;
@property(nonatomic,strong)UILabel* latitude;
@property(nonatomic,strong)UILabel* location;
@property(nonatomic,strong)UILabel* cityLable;
@property(nonatomic,strong)UILabel* addressLa;
@property(nonatomic,strong)UIButton* deleteBtn;
@property(nonatomic,strong)UIButton* editorBtn;
//弹框
@property(nonatomic,strong)POPView* diZhiView;
@property(nonatomic,strong)POPView* fanWeiView;
@property(nonatomic,strong)POPView* yueTianshuView;
@property(nonatomic,strong)POPView* LuRuView;
@property(nonatomic,strong)POPView* tiShiView;
@property(nonatomic,strong)UIView* headView;
@property(nonatomic,strong)MKCircle * circle;

@property(nonatomic,assign)NSInteger fanweiNum;//范围
@property(nonatomic,strong)CLGeocoder* geocoder;

@property(nonatomic,assign)double mapviewLa;
@property(nonatomic,assign)double mapViewLon;
@property(nonatomic,assign)double addressLat;
@property(nonatomic,assign)double addressLon;
@property(nonatomic,assign)CLLocationCoordinate2D coo2d;

@property(nonatomic,strong)NSString* cityName;
@property(nonatomic,strong)NSString* adressName;
@property(nonatomic,assign)NSInteger loadDataType;

@property(nonatomic,assign)NSInteger getData;

@property(nonatomic,strong)KaoqinModel* model;
@property(nonatomic,assign)NSInteger addtype;
@property(nonatomic,assign)NSInteger addOrLoadType;
@end

@implementation KaoqinViewController

-(CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder =[[CLGeocoder alloc]init];
    }
    return _geocoder;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
     [self addData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"考勤设置";
    self.loadDataType=2;
    self.addOrLoadType=3;
   
    [self addView];
 
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
}

//保存
-(void)saveAction:(UIButton*)sender{
    if (self.loadDataType==1) {
        [self updatedate];
    } else {
        [self addKaoqinData];
    }
}

-(void)addKaoqinData{
    
    
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    NSMutableDictionary*parm =[NSMutableDictionary dictionary];
    [parm setObject:ID forKey:@"projectid"];
    [parm setObject:self.cityName forKey:@"area"];
    [parm setObject:self.diZhiView.popTextFile.text forKey:@"address"];
    [parm setObject:@([self.yueTianshuView.popTextFile.text intValue])forKey:@"attendance"];
    [parm setObject:@([self.fanWeiView.popTextFile.text intValue])forKey:@"attendancescope"];
    [parm setObject:@([self.LuRuView.popTextFile.text intValue]) forKey:@"fingerprinttime"];
    [parm setObject:@([self.tiShiView.popTextFile.text intValue]) forKey:@"contracttime"];
   
    
    //经纬度
    NSString*la=[NSString stringWithFormat:@"%f",self.addressLat];
    NSString*lon =[NSString stringWithFormat:@"%f",self.addressLon];
    [parm setObject:la forKey:@"latitude"];
    [parm setObject:lon forKey:@"longitude"];
    
    
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"attendanceAdd"] Token:self.tokenString parmpar:parm succeed:^(id data) {
        
        NSLog(@"add---%@",data);
        
    } failure:^(NSError *error) {
        
    }];
    
    
}


//编辑
-(void)updatedate{
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    NSMutableDictionary*parm =[NSMutableDictionary dictionary];
    [parm setObject:ID forKey:@"projectid"];
    
    if (self.cityName.length==0) {
         [parm setObject:self.model.area forKey:@"area"];
    } else {
        //!!!
        [parm setObject:self.cityName forKey:@"area"];
    }
    
    if ([self.diZhiView.popTextFile.text isEqualToString:@""]||self.diZhiView.popTextFile.text==0) {
           [parm setObject:self.model.address forKey:@"address"];
    } else {
         [parm setObject:[NSString stringWithFormat:@"%@",self.diZhiView.popTextFile.text] forKey:@"address"];
    }
    if ([self.yueTianshuView.popTextFile.text  isEqualToString:@" "]||self.yueTianshuView.popTextFile.text.length==0) {
            [parm setObject:@(self.model.attendance)forKey:@"attendance"];
    } else {
            [parm setObject:@([self.yueTianshuView.popTextFile.text intValue])forKey:@"attendance"];
    }
    if ([self.fanWeiView.popTextFile.text isEqualToString:@" "]||self.fanWeiView.popTextFile.text.length==0) {
         [parm setObject:@(self.model.attendancescope)forKey:@"attendancescope"];
    } else {
         [parm setObject:@([self.fanWeiView.popTextFile.text intValue])forKey:@"attendancescope"];
    }
    if ([self.LuRuView.popTextFile.text isEqualToString:@""]||self.LuRuView.popTextFile.text.length==0) {
            [parm setObject:@(self.model.fingerprinttime) forKey:@"fingerprinttime"];
    } else {
            [parm setObject:@([self.LuRuView.popTextFile.text intValue]) forKey:@"fingerprinttime"];
    }
    if ([self.tiShiView.popTextFile.text isEqualToString:@""]||self.tiShiView.popTextFile.text.length==0) {
        [parm setObject:@(self.model.contracttime) forKey:@"contracttime"];
    } else {
        [parm setObject:@([self.tiShiView.popTextFile.text intValue]) forKey:@"contracttime"];
    }
    //经纬度
    NSString*la=[NSString stringWithFormat:@"%f",self.addressLat];
    NSString*lon =[NSString stringWithFormat:@"%f",self.addressLon];
    [parm setObject:la forKey:@"latitude"];
    [parm setObject:lon forKey:@"longitude"];
    
    NSLog(@"%@",parm);
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"attendanceUpdate"] Token:self.tokenString parmpar:parm succeed:^(id data) {
        
        NSLog(@"updateKKKKKK---%@",data);
        
    } failure:^(NSError *error) {
        
    }];
    
    
}


-(void)addData{
    self.model =[KaoqinModel new];
    self.requestDataArray=[NSMutableArray array];
    //红色覆盖物范围 默认m
    self.fanweiNum= 200;
    
    self.dataArray =(NSMutableArray*) @[@"签到城市",@"签到地址",@"考勤范围",@"月可出勤天数",@"提示录入指纹时间",@"提示签合同时间"];
    //项目ID
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    NSDictionary*parm =@{@"projectid":ID};
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"attendanceList"] Token:self.tokenString parmpar:parm succeed:^(id data) {
        
        [self.model setValuesForKeysWithDictionary:data[@"resultMessage"]];
        [self.requestDataArray addObject:self.model];
        NSLog(@"**********%@kAQIN%@--%@--",data,self.model,self.requestDataArray);
        
        if (self.requestDataArray.count !=0) {
            NSString*address=[NSString stringWithFormat:@"%@%@",self.model.area,self.model.address];
            self.loadDataType=1;
            dispatch_async(dispatch_get_main_queue(), ^{
                
//                [self getCoordinateByAddress:self.model.address withType:@"展示已有数据" withscope:[NSString stringWithFormat:@"%d",self.model.attendance]];
                //[self getCoordinateByAddress:address withType:@"展示已有数据" withscope:[NSString stringWithFormat:@"%d",self.model.attendance]];
                CLLocationCoordinate2D coo2d =CLLocationCoordinate2DMake([self.model.latitude floatValue], [self.model.longitude floatValue]);
                if (self.addOrLoadType !=1) {
                    [self addDataMapView:coo2d addressName:address distance:[NSString stringWithFormat:@"%d",self.model. attendancescope]];
                }
                NSLog(@"yyyyyyyyyyyyyyyymmmm%@",address);
            });
           
            
            
            
        }

        [self.kaoqinTableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];

    
}
-(void)addDataMapView:(CLLocationCoordinate2D)cood2d addressName:(NSString*)address distance:(NSString*)distance{
    //地图显示位置
    [self.mapView setRegion:MKCoordinateRegionMake(cood2d, MKCoordinateSpanMake(0.0002, 0.0002))];
    
    //大头针
    MKPointAnnotation *annotation0 = [[MKPointAnnotation alloc] init];
    [annotation0 setCoordinate:cood2d];
    
     [annotation0 setTitle:address];
    
    [self.mapView addAnnotation:annotation0];
    //是否自动显示大头针内容
    [self.mapView selectAnnotation:annotation0 animated:YES];
    
    
//    //添加圆形覆盖物
    [self  MKCircleSettingCllcoationDD:cood2d fanweiNum:[distance intValue]];




}


-(void)addView{
    
    //121.460531 31.269620
    ///<31.21217300,+121.46099300>
    
    self.headView =[[UIView alloc]init];
    self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, PROPORTION_HIGHT(250));
    self.headView.backgroundColor = popBGColore;
    
    self.mapView =[[MKMapView alloc]init];
    self.mapView.frame =CGRectMake(0, 0, self.headView.width, PROPORTION_HIGHT(250));
    [self.headView addSubview:self.mapView];
    self.mapView.delegate =self;
    self.mapView.mapType = MKMapTypeStandard;//有多个样式此处用标准类型
    //设置追踪模式
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    //[self.mapView setRegion:MKCoordinateRegionMake(self.coo2d, MKCoordinateSpanMake(0.006, 0.006))];
    
    
    self.kaoqinTableView=[[UITableView alloc]initWithFrame:UIScreenBpunds style:(UITableViewStylePlain)];
    [self.view addSubview:self.kaoqinTableView];
    //tableview
    self.kaoqinTableView.tableHeaderView = self.headView;
    self.kaoqinTableView.dataSource = self;
    self.kaoqinTableView.delegate = self;
    self.kaoqinTableView.backgroundColor=GlobBackGroundColor;
    [self.kaoqinTableView registerClass:[KoaqinTableViewCell class] forCellReuseIdentifier:@"kaoqinCellId"];
   
    
}


-(void)creatMapView{
    self.addressLa=[[UILabel alloc]init];
    self.addressLa.frame =CGRectMake(0,CGRectGetMaxY(self.mapView.frame), SCREEN_WIDTH, 30);
    self.addressLa.font =[UIFont systemFontOfSize:14];
    [self.headView addSubview:self.addressLa];
    // self.addressLa.text =[[LocationHander handleCoo2D].handelcoo2dDic objectForKey:@"place"];
    
    self.mapView =[[MKMapView alloc]init];
    self.mapView.frame =CGRectMake(0, 0, self.headView.width, PROPORTION_HIGHT(190));
    [self.headView addSubview:self.mapView];
    self.mapView.delegate =self;
    self.mapView.mapType = MKMapTypeStandard;//有多个样式此处用标准类型

    if (self.requestDataArray.count ==0) {
      self.mapView.userTrackingMode = MKUserTrackingModeFollow;    //设置追踪模式
    [self.mapView setRegion:MKCoordinateRegionMake(self.coo2d, MKCoordinateSpanMake(0.006, 0.006))];
   // 大头针
        MKPointAnnotation *annotation0 = [[MKPointAnnotation alloc] init];
        [annotation0 setCoordinate:self.coo2d];
        [annotation0 setTitle:[[LocationHander handleCoo2D].handelcoo2dDic objectForKey:@"city"]];
        [annotation0 setSubtitle:[[LocationHander handleCoo2D].handelcoo2dDic objectForKey:@"place"]];
        [self.mapView addAnnotation:annotation0];
        //是否自动显示大头针内容
        [self.mapView selectAnnotation:annotation0 animated:YES];
    }

    
}

-(void)MKCircleSettingCllcoationDD:(CLLocationCoordinate2D)CLLocation fanweiNum:(NSInteger)fanweiNum{
    MKCircle * cirle = [MKCircle circleWithCenterCoordinate:CLLocation radius:fanweiNum];
    //添加覆盖物
    [_mapView addOverlay:cirle];
}
//覆盖物
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    MKCircleRenderer * render=[[MKCircleRenderer alloc]initWithCircle:overlay];
    render.lineWidth=1;    //填充颜色
    render.fillColor=[UIColor colorWithRed:250 green:0 blue:0 alpha:0.2];    //线条颜色
    render.strokeColor=[UIColor redColor];
    
    return render;
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D coord = [userLocation coordinate];

    if (self.requestDataArray.count==0) {//The data is not empty
        //show mapview
        [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(coord.latitude, coord.longitude), MKCoordinateSpanMake(0.0003, 0.0003))];
        
        //PointAnnotation
        MKPointAnnotation *annotation0 = [[MKPointAnnotation alloc] init];
        [annotation0 setCoordinate:CLLocationCoordinate2DMake(coord.latitude, coord.longitude)];
        [annotation0 setTitle:self.diZhiView.popTextFile.text];
        [self.mapView addAnnotation:annotation0];
        //automatic show PointAnnotation
        [self.mapView selectAnnotation:annotation0 animated:YES];
        

    }
    
    
}
//-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//    NSLog(@"%f,%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
//    self.mapviewLa =userLocation.location.coordinate.latitude;
//    self.mapViewLon=userLocation.location.coordinate.longitude;
//    //这个方法可以设置地图精度以及显示用户所在位置的地图
//    MKCoordinateSpan span=MKCoordinateSpanMake(0.005, 0.005);
//    MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
//    [mapView setRegion:region animated:YES];
//}

//给经纬度大头针
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    CLLocationCoordinate2D coord = [annotation coordinate];
    self.mapviewLa =coord.latitude;
    self.mapViewLon =coord.longitude;
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        MKAnnotationView* aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MKPointAnnotation"];
        aView.image = [UIImage imageNamed:@"home_dizhi"];
        aView.canShowCallout = YES;
        
        
        return aView;
    }
    return nil;
}

#pragma mark -------------delegate------------
// adressToco2d
-(void)getCoordinateByAddress:(NSString*)address withType:(NSString*)addresstype withscope:(NSString*)scope{
    
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if ([placemarks count] > 0 && error == nil) {
            NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            if ([addresstype isEqualToString:@"展示数据"]) {
                //地图显示位置
            [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(firstPlacemark.location.coordinate.latitude, firstPlacemark.location.coordinate.longitude), MKCoordinateSpanMake(0.0002, 0.0002))];
             //大头针
         MKPointAnnotation *annotation0 = [[MKPointAnnotation alloc] init];
            [annotation0 setCoordinate:CLLocationCoordinate2DMake(firstPlacemark.location.coordinate.latitude, firstPlacemark.location.coordinate.longitude)];
                
            [annotation0 setTitle:self.diZhiView.popTextFile.text];
                
            [self.mapView addAnnotation:annotation0];
            //是否自动显示大头针内容
            [self.mapView selectAnnotation:annotation0 animated:YES];
            
            
            //添加圆形覆盖物
            [self  MKCircleSettingCllcoationDD:CLLocationCoordinate2DMake(firstPlacemark.location.coordinate.latitude, firstPlacemark.location.coordinate.longitude) fanweiNum:[scope intValue]];
            self.addressLat =firstPlacemark.location.coordinate.latitude;
            self.addressLon=firstPlacemark.location.coordinate.longitude;
                
            }else if([addresstype isEqualToString:@"展示已有数据"]){
                //地图显示位置
                [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(firstPlacemark.location.coordinate.latitude, firstPlacemark.location.coordinate.longitude), MKCoordinateSpanMake(0.0002, 0.0002))];
                
                //大头针
                
                MKPointAnnotation *annotation0 = [[MKPointAnnotation alloc] init];
                [annotation0 setCoordinate:CLLocationCoordinate2DMake(firstPlacemark.location.coordinate.latitude, firstPlacemark.location.coordinate.longitude)];
                
               // [annotation0 setTitle:self.diZhiView.popTextFile.text];
                
                [self.mapView addAnnotation:annotation0];
                //是否自动显示大头针内容
                [self.mapView selectAnnotation:annotation0 animated:YES];
                
                CLLocationCoordinate2D  cllocation =CLLocationCoordinate2DMake(firstPlacemark.location.coordinate.latitude, firstPlacemark.location.coordinate.longitude);
                //添加圆形覆盖物
                NSString*string =[NSString stringWithFormat:@"%@%@",self.cityName,self.diZhiView.popTextFile.text];
                [self addDataMapView:cllocation addressName:string distance: @"0"];
                //地名反编译经纬度
                self.addressLat =firstPlacemark.location.coordinate.latitude;
                self.addressLon=firstPlacemark.location.coordinate.longitude;
            
            }
            
        }
        else if ([placemarks count] == 0 && error == nil) {
            NSLog(@"Found no placemarks.");
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
        
        //获取第一个坐标
      //  CLPlacemark* placeMark =[placemarks firstObject];
//        CLLocation* location = placeMark.location;//位置
//        CLRegion* region = placeMark.region;
//        NSDictionary* addressDic= placeMark.addressDictionary;//详细地址
        
        
    }];
    

    
}
//coo2d to adress
-(void)coo2dToAdressCoo2d:(CLLocationCoordinate2D)coo2d{
    
    //获取用户输入的经纬度
    double latitude = coo2d.latitude;
    double longitude = coo2d.longitude;
    //    double latitude= 31.267548;
    //    double longitude = 121.465180;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error){
        
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            NSString *city = placemark.locality;
            if (!city) {
                city = placemark.administrativeArea;
                
            }
     
            NSString* subLocality = placemark.subLocality;
            NSString* thorough = placemark.thoroughfare;
            NSString* name =placemark.name;
            
            NSLog(@"%@",name);
            NSString*string =[NSString stringWithFormat:@"%@%@%@%@",city, subLocality,thorough,name];
            
            NSLog(@"kkkk%@%@",placemark,string);

        
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    
    
}





#pragma mark ======delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  6;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KoaqinTableViewCell*cell=[self.kaoqinTableView dequeueReusableCellWithIdentifier:@"kaoqinCellId"];
    
    //[cell getValueModel:self.model cellIndex:indexPath UPpage:self.addtype dataArray:self.dataArray];
    
       cell.leftLa.text = self.dataArray[indexPath.row];
    
    if (self.requestDataArray.count!=0) {
        cell.rightLa.textColor =textColorPlace;
        if (self.addOrLoadType==1) {
        }else{
        
            
        if (indexPath.row ==0) {
         
                 cell.rightLa.text = self.model.area;
     
           
        }else if (indexPath.row ==1){
        
                cell.rightLa.text = self.model.address;
                self.addressLa.text =self.model.address;
            
          
        }else if (indexPath.row ==2){
         
                NSString*atted =[NSString stringWithFormat:@"%d",self.model.attendancescope ];
                cell.rightLa.text =atted;
            
           
        }else if (indexPath.row ==3){
          
                NSString*atted =[NSString stringWithFormat:@"%d",self.model.attendance];
                cell.rightLa.text =atted;
            
         
        }else if (indexPath.row ==4){
        
                NSString*atted =[NSString stringWithFormat:@"%d",self.model.fingerprinttime];
                cell.rightLa.text =atted;
            
           
        }else if (indexPath.row==5){
       
                NSString*atted =[NSString stringWithFormat:@"%d",self.model.contracttime];
                cell.rightLa.text =atted;
            
        }
        }
        
    } else {
    
        if ([cell.rightLa.text isEqualToString:@"去填写"]) {
               cell.rightLa.textColor= textBlueColor;
        }else{
          cell.rightLa.textColor= textColorPlace;
        }
       
    }

    //去除多余cell
    self.kaoqinTableView.tableFooterView=[[UIView alloc]init];
    
    return  cell;
}



//cell跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.addOrLoadType=1;;
    
    if (indexPath.row ==0) {
        
        KoaqinTableViewCell*cell=[self.kaoqinTableView cellForRowAtIndexPath:indexPath];
        CityViewController *controller = [[CityViewController alloc] init];
        controller.currentCityString = @"上海";
        controller.selectString = ^(NSString *string){
          
            cell.rightLa.text =string;
            [self getCoordinateByAddress:string withType:@"展示数据" withscope:@"0"];
            self.cityName =string;
            [self.kaoqinTableView reloadData];
              NSLog(@"%@--%@",string,self.cityName);
        };
        [self presentViewController:controller animated:YES completion:nil];

  
    }else if (indexPath.row ==1 ){
        
          [self address];
        
    }else if (indexPath.row ==2 ){
        
        [self fanWei];
        
    }else if (indexPath.row == 3){
        [self yueTianShu];
        
    }else if (indexPath.row == 4){
        [self luruView];
    }else if (indexPath.row == 5){
        [self Tishi];
    }

    
    
}

//地址
-(void)address{
    self.diZhiView=[[POPView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview:self.diZhiView];
    self.diZhiView.popTitle.text=@"签到地址";
    self.diZhiView.popTextFile.placeholder = @"例如： 复兴中路100号";
    [self.diZhiView.popDoneBtn addTarget:self action:@selector(dizhiAction:) forControlEvents:(UIControlEventTouchUpInside)];
}
//范围
-(void)fanWei{
    self.fanWeiView =[[POPView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview:self.fanWeiView];
    self.fanWeiView.popTitle.text=@"考勤范围";
    self.fanWeiView.popTextFile.placeholder = @"例如： 200 (米)";
    self.fanWeiView.popTextFile.keyboardType = UIKeyboardTypeNumberPad;
    [self.fanWeiView.popDoneBtn addTarget:self action:@selector(fanWeiAction:) forControlEvents:(UIControlEventTouchUpInside)];
}
//月考勤天数
-(void)yueTianShu{
    self.yueTianshuView =[[POPView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview:self.yueTianshuView];
    self.yueTianshuView.popTitle.text=@"月出勤天数";
    self.yueTianshuView.popTextFile.keyboardType = UIKeyboardTypeNumberPad;
    self.yueTianshuView.popTextFile.placeholder = @"例如： 26 (天)";
    [self.yueTianshuView.popDoneBtn addTarget:self action:@selector(yueTianShuAction:) forControlEvents:(UIControlEventTouchUpInside)];
}
//合同天数
-(void)Tishi{
    self.tiShiView =[[POPView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview:  self.tiShiView];
    self.tiShiView.popTitle.text=@"提示签合同时间";
       self.tiShiView.popTextFile.keyboardType = UIKeyboardTypeNumberPad;
    self.tiShiView.popTextFile.placeholder = @"例如： 26 (天)";
    [  self.tiShiView.popDoneBtn addTarget:self action:@selector(tiShiAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}

//录入指纹时间
-(void)luruView{
    self.LuRuView =[[POPView alloc]initWithFrame:UIScreenBpunds];
    [self.view addSubview: self.LuRuView];
    self.LuRuView.popTitle.text=@"提示录入指纹时间";
   self.LuRuView.popTextFile.keyboardType = UIKeyboardTypeNumberPad;
    self.LuRuView.popTextFile.placeholder = @"例如： 26 (天)";
    [ self.LuRuView.popDoneBtn addTarget:self action:@selector(luruAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}


// address
-(void)dizhiAction:(UIButton*)sender{
    [self popCellBack:self.diZhiView.popTextFile.text];
   
    self.diZhiView.hidden = YES;
   
    //地址获取坐标
    NSString*adressStr=[NSString stringWithFormat:@"%@,%@",self.cityName,self.diZhiView.popTextFile.text];
       self.adressName =adressStr;
       [self getCoordinateByAddress:adressStr withType:@"展示数据" withscope:@"0"];
    
}
//fanwei
-(void)fanWeiAction:(UIButton*)sender{
    
    [self popCellBack:self.fanWeiView.popTextFile.text];
    self.fanweiNum = [self.fanWeiView.popTextFile.text integerValue];
    self.fanWeiView.popTextFile.keyboardType =UIKeyboardTypePhonePad;
 
     [self getCoordinateByAddress:self.adressName withType:@"展示数据" withscope: self.fanWeiView.popTextFile.text];
//    self.circle = [MKCircle circleWithCenterCoordinate:self.coo2d radius:self.fanweiNum];
//    //添加覆盖物
//    [_mapView addOverlay:self.circle];
    [self.kaoqinTableView reloadData];
    
    self.fanWeiView.hidden = YES;
}
//yuetianshu
-(void)yueTianShuAction:(UIButton*)sender{
    if ([ self.yueTianshuView.popTextFile.text integerValue]>0 &&[ self.yueTianshuView.popTextFile.text integerValue]<31) {
        [self AlerVCtitleString:@"提示" messageString:@"请输入1-31之间的数字" doneString:@"确定"];
    } else {
        self.yueTianshuView.popTextFile.keyboardType = UIKeyboardTypePhonePad;
        [self popCellBack:self.yueTianshuView.popTextFile.text];
        self.yueTianshuView.hidden = YES;

    }
    }
//yuetianshu
-(void)tiShiAction:(UIButton*)sender{
    if ([ self.tiShiView.popTextFile.text integerValue]>0 &&[self.tiShiView.popTextFile.text integerValue]<31) {
        [self AlerVCtitleString:@"提示" messageString:@"请输入1-31之间的数字" doneString:@"确定"];
    } else {
    self.tiShiView.popTextFile .keyboardType =UIKeyboardTypePhonePad;
    [self popCellBack:self.tiShiView.popTextFile.text];
    self.tiShiView.hidden = YES;
    }
}

//yuetianshu
-(void)luruAction:(UIButton*)sender{
    if ([ self.LuRuView.popTextFile.text integerValue]>0 &&[  self.LuRuView.popTextFile.text integerValue]<31) {
        [self AlerVCtitleString:@"提示" messageString:@"请输入1-31之间的数字" doneString:@"确定"];
    } else {
    self.LuRuView.popTextFile.keyboardType = UIKeyboardTypePhonePad;
    [self popCellBack:self.LuRuView.popTextFile.text];
    self.LuRuView.hidden = YES;
    }
}




-(void)popCellBack:(NSString*)backString{
    
    NSIndexPath *indexPath = [self.kaoqinTableView indexPathForSelectedRow];
    
     KoaqinTableViewCell *cell = [self. kaoqinTableView cellForRowAtIndexPath: indexPath];
    cell.rightLa.text = backString;
    cell.rightLa.textColor = textColorPlace;
    [self.kaoqinTableView reloadData];
    
    
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
