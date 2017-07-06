//
//  YYccaheViewController.m
//  YYKitDemo
//
//  Created by youxin on 2017/6/29.
//  Copyright © 2017年 ibireme. All rights reserved.
//

#import "YYccaheViewController.h"
#import "YYCache.h"

@interface YYccaheViewController (){
    YYCache *yyCache;
     YYCache *yyCache2;
}
@property(nonatomic,strong)UILabel*lable1;
@end

@implementation YYccaheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    http://blog.ibireme.com/#still
// YYCache使用   http://www.jianshu.com/p/01f306ceace1
//   http://www.cnblogs.com/huilixieqi/p/6494772.html
    
    
//小数据存储   http://www.jianshu.com/p/e51eac1467a8
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.lable1 =[[UILabel alloc]init];
    self.lable1.frame = CGRectMake(0, 64,SceneWidth, 40);
    [self.view addSubview:self.lable1];

    
//    
//    YYCache *yyCache=[YYCache cacheWithName:@"LCJCache"];
//    [yyCache.memoryCache setCountLimit:50];//内存最大缓存数据个数
//    [yyCache.memoryCache setCostLimit:1*1024];//内存最大缓存开销 目前这个毫无用处
//    [yyCache.diskCache setCostLimit:10*1024];//磁盘最大缓存开销
//    [yyCache.diskCache setCountLimit:50];//磁盘最大缓存数据个数
//    [yyCache.diskCache setAutoTrimInterval:60];//设置磁盘lru动态清理频率 默认 60秒
   [self cacheNum];
//    [self tongbu];
//    [self yibu];

}

-(void)tongbu{
    //模拟数据
    NSString *value=@"I want to know who is lcj ?";
    //模拟一个key
    //同步方式
    NSString *key=@"key";
   yyCache=[YYCache cacheWithName:@"LCJCache"];
    //根据key写入缓存value
    [yyCache setObject:value forKey:key];
    //判断缓存是否存在
    BOOL isContains=[yyCache containsObjectForKey:key];
    NSLog(@"containsObject : %@", isContains?@"YES":@"NO");
    //根据key读取数据
    id vuale= [yyCache objectForKey:key];
    NSLog(@"value : %@",vuale);
    //根据key移除缓存
//    [yyCache removeObjectForKey:key];
    //移除所有缓存
//    [yyCache removeAllObjects];
    if (isContains) {
        self.lable1.text = [NSString stringWithFormat:@"%@",vuale];
    }else{
    self.lable1.text =@"666";
    }
}

-(void)yibu{


    //模拟数据
    NSString *value=@"I want to know who is lcj ?";
    //模拟一个key
    //异步方式
    NSString *key=@"key";
    YYCache *yyCache1=[YYCache cacheWithName:@"LCJCache"];
    //根据key写入缓存value
    [yyCache1 setObject:value forKey:key withBlock:^{
        NSLog(@"setObject sucess");
    }];
    //判断缓存是否存在
    [yyCache1 containsObjectForKey:key withBlock:^(NSString * _Nonnull key, BOOL contains) {
        NSLog(@"containsObject : %@", contains?@"YES":@"NO");
    }];
    
    //根据key读取数据
    [yyCache1 objectForKey:key withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        NSLog(@"objectForKey : %@",object);
    }];
    
    //根据key移除缓存
    [yyCache1 removeObjectForKey:key withBlock:^(NSString * _Nonnull key) {
        NSLog(@"removeObjectForKey %@",key);
    }];
    //移除所有缓存
    [yyCache1 removeAllObjectsWithBlock:^{
        NSLog(@"removeAllObjects sucess");
    }];
    
    //移除所有缓存带进度
    [yyCache1 removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
        NSLog(@"removeAllObjects removedCount :%d  totalCount : %d",removedCount,totalCount);
    } endBlock:^(BOOL error) {
        if(!error){
            NSLog(@"removeAllObjects sucess");
        }else{
            NSLog(@"removeAllObjects error");
        }
    }];
}
//http://www.cnblogs.com/huilixieqi/p/6494772.html
-(void)cacheNum{

    //模拟数据

//  YYCache*  yyCache2=[YYCache cacheWithName:@"666"];
//    [yyCache2 setCountLimit:100];//磁盘最大缓存数据个数
//       [yyCache2.diskCache setCountLimit:50];//磁盘最大缓存数据个数

  
    //模拟一个key
    //同步方式
//    NSString *key=@"key";
    yyCache2=[YYCache cacheWithName:@"666"];
    
    
    for(int i=0 ;i<100;i++){
        
        //模拟一个key
        NSString *key=[NSString stringWithFormat:@"key%d",i];
        //模拟数据
        NSString *value=[NSString stringWithFormat:@"存储数据: %d行",i];
        [yyCache2 setObject:value forKey:key];

        //判断缓存是否存在
//       BOOL isContains=[yyCache2 containsObjectForKey:key];
//  
//        
//        if (isContains) {
//            
//            id ss =[yyCache2 objectForKey:key];
//            NSString*str =[NSString stringWithFormat:@"%@",ss];
//            self.lable1.text = str;
//            
//            NSLog(@"666--key-%@-%@",key,ss);
//        }
    
 
    }

    
   dispatch_async(dispatch_get_main_queue(), ^{
    
           for(int i=0 ;i<100;i++){
               
               //判断缓存是否存在
               NSString *key=[NSString stringWithFormat:@"key%d",i];
               BOOL isContains=[yyCache2 containsObjectForKey:key];
               if (isContains) {
                   
               id ss =[yyCache2 objectForKey:key];
               NSString*str =[NSString stringWithFormat:@"%@",ss];
                self.lable1.text = str;
                NSLog(@"读取缓存：key:%@-%@",key,ss);
               }
           }
});
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //根据key移除缓存
    [yyCache removeObjectForKey:@"key"];
     [yyCache2 removeAllObjects];
    self.lable1.text =(NSString*) [yyCache objectForKey:@"key"];
    self.view.backgroundColor =[UIColor greenColor];

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
