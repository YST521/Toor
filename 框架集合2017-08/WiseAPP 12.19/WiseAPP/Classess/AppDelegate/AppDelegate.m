//
//  AppDelegate.m
//  WQEWQ
//
//  Created by app on 16/10/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "AppDelegate.h"
#import "RootUITabBarController.h"
#import "WorkTypeMessageController.h"
#import "ImageViewController.h"//引导页
#import "LoginViewController.h"
#import "Header.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationHander.h"
#import "IQKeyboardManager.h"//键盘回收

@interface AppDelegate ()<CLLocationManagerDelegate>
@property(nonatomic,strong)NSString* la;
@property(nonatomic,strong)NSString* lon;
/** 地理编码管理器 */
@property (nonatomic, strong) CLGeocoder *geoC;

@end

@implementation AppDelegate
/** 地理编码管理器 */
- (CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}
//定位
- (CLLocationManager *)locationManager{
    if (!_locationManger) {
        _locationManger = [[CLLocationManager alloc]init];
        
        _locationManger.delegate = self;
       _locationManger.desiredAccuracy = kCLLocationAccuracyBest;
   
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0 ) {
            
            [_locationManger requestAlwaysAuthorization];
            [_locationManger requestWhenInUseAuthorization];
            
        }
    }
    return _locationManger;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

   // com.yishantaoiOS.WiseAPPP 941a66ca-da28-4b86-870e-a9e49158f3e7
    //com.yishantaoiOS.WiseAPP
    //com.yishantaoo 公司真机
    //家真机 com.shantaoiOS.-1
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //开始定位
    [self.locationManager startUpdatingLocation];
  
    
    //偏好设置存一个字符串判断是否是第一次登陆
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstEnterApp"])
//    {
//        ImageViewController*imageVC= [[ImageViewController alloc]init];
//        imageVC.view.backgroundColor = [UIColor whiteColor];
//        self.window.rootViewController =  imageVC;
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstEnterApp"];
//        [self.window makeKeyAndVisible];
//    }
//    else
//    {
        //tabar插入button框架
//            RootUITabBarController*rootTabar = [[RootUITabBarController alloc]init];
//             self.window.rootViewController = rootTabar;
        //自定义tabbar框架
        MainTabBarController*mainTabbar = [[MainTabBarController alloc]init];
         self.window.rootViewController = mainTabbar;
////        
//        WorkTypeMessageController*work=[[WorkTypeMessageController alloc]init];
//        RootUINavigationController*na=[[RootUINavigationController alloc]initWithRootViewController:work];
//        self.window.rootViewController = na;
        //测试登陆注册
//        LoginViewController*loginVC = [[LoginViewController alloc]init];
//       RootUINavigationController*na=[[RootUINavigationController alloc]initWithRootViewController:loginVC];
//        self.window.rootViewController = na;
//
        
       
         [self.window makeKeyAndVisible];
        //地图获取经纬度
       // [self creatMap];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstEnterApp"];
        
        //测试
        
//    }
    
    // 监听网络状态
   
    //[RequestManger startMonitoring];
   
    //去除多余打印信息  OS_ACTIVITY_MODE  disable
    
//     [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];;
//  
//
    NSLog(@"22%@",NSHomeDirectory());

  
    return YES;
}

#pragma MARK -----------获取经纬度-------


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //将经度显示到label上
    
 CGFloat longNum =newLocation.coordinate.longitude;
    //将纬度现实到label上
    
 CGFloat  laNum =newLocation.coordinate.latitude;

    //NSLog(@"PPPPPKKKKK****%f %f",laNum,newLocation.coordinate.longitude);

    //判断是不是属于国内范围
//        if (![WGS84TOGCJ02 isLocationOutOfChina:CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)]) {
    
            //转换后的coord
//       CLLocationCoordinate2D coord = [WGS84TOGCJ02 transformFromWGSToGCJ:CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)];
//            NSLog(@"CCCCC%f,%f",coord.latitude,coord.longitude);
//            if (laNum != 0 & longNum !=0) {
//                [ [LocationHander handleCoo2D].handercoo2dArray  addObject:[NSString stringWithFormat:@"%g",coord.latitude]];
//                [ [LocationHander handleCoo2D].handercoo2dArray  addObject:[NSString stringWithFormat:@"%g",coord.longitude]];
//            }else{
//                NSLog(@"经纬度为空");
//                
//            }
//
//            }
//单例存储经纬度
//    if (laNum != 0 & longNum !=0) {
//        [ [LocationHander handleCoo2D].handercoo2dArray  addObject:[NSString stringWithFormat:@"%g",laNum]];
//        [ [LocationHander handleCoo2D].handercoo2dArray  addObject:[NSString stringWithFormat:@"%g",longNum]];
//    }else{
//        NSLog(@"经纬度为空");
//    
//    }
 // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
//获取城市 place.name               //  位置名
//place.thoroughfare              //  街道
//place.subAdministrativeArea //  子街道
//place.locality);               //  市
//place.subLocality            //  区
//  NSLog(@"country =%@",place.country)国家
     
     NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
               
            }
            
            //  NSString* county = placemark.country;
            NSString* subLocality = placemark.subLocality;
            NSString* thorough = placemark.thoroughfare;
           // NSString*subAdmin = placemark.subAdministrativeArea;
            NSString* name =placemark.name;

            NSLog(@"%@",name);
             NSString*string =[NSString stringWithFormat:@"%@%@%@%@",city, subLocality,thorough,name];
            
            NSLog(@"kkkk%@%@",placemark,string);
            //街道具体信息
            [[LocationHander handleCoo2D].handelcoo2dDic setObject:string forKey:@"place"];
            //单例保存城市名
            [[LocationHander handleCoo2D].handelcoo2dDic setObject:city forKey:@"city"];
            //根据地名编码
            [self getCode];
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
# warning =======
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}
-(void)getCode{
    
    //NSString *address = self.addressTV.text;
    //NSString *address = @"上海市静安区民和路221号";
    NSString *address = [[LocationHander handleCoo2D].handelcoo2dDic objectForKey:@"place"];
    NSLog(@"反编译地址信息%@",address);
    // 容错处理
    if([address length] == 0)
    {
        return;
    }
    
    // 根据地址关键字, 进行地理编码
    [self.geoC geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        /**
         *  CLPlacemark : 地标对象
         *  location : 对应的位置对象
         *  name : 地址全称
         *  locality : 城市
         *  按相关性进行排序
         */
        CLPlacemark *pl = [placemarks firstObject];
        
        if(error == nil)
        {
            NSLog(@"AA%f----%f", pl.location.coordinate.latitude, pl.location.coordinate.longitude);
            
            NSLog(@"BB%@", pl.name);
        
            NSLog(@"反编译经纬度%@**%@",@(pl.location.coordinate.latitude).stringValue,@(pl.location.coordinate.longitude).stringValue);
            //单例存储经纬度
//                if ( pl.location.coordinate.latitude!=0) {
//                    [ [LocationHander handleCoo2D].handercoo2dArray  addObject:[NSString stringWithFormat:@"%g",pl.location.coordinate.latitude]];
//                    [ [LocationHander handleCoo2D].handercoo2dArray  addObject:[NSString stringWithFormat:@"%g",pl.location.coordinate.longitude]];
//                }else{
//                    NSLog(@"经纬度为空");
//                
//                }
        }
    }];
    
    
}

#pragma mark ------横竖屏----------
//在 APPDelegate.m 文件中增加方法，控制全部不支持横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.allowRotation) {
        return  UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}
//需在上面#import "AppDelegate.h"
//AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//appDelegate.allowRotation = YES;
//不让横屏的时候 appDelegate.allowRotation = NO;即可

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
      
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"WQEWQ"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
