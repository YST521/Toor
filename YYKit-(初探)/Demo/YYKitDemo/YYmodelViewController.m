//
//  YYmodelViewController.m
//  YYKitDemo
//
//  Created by youxin on 2017/6/29.
//  Copyright © 2017年 ibireme. All rights reserved.
//

#import "YYmodelViewController.h"
#import "YYKit.h"
#import "YYsModel.h"

@interface YYmodelViewController ()

@end

@implementation YYmodelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
//    NSString *str =[[NSBundle mainBundle] pathForResource:@"aa" ofType:@"json"];
    //JSON文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"aa.json" ofType:nil];
    
//    NSDictionary *dic =[[NSDictionary alloc]initWithContentsOfFile:path];
    
    NSData *data =[NSData dataWithContentsOfFile:path];
    NSMutableDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];

        YYsModel *model =[YYsModel modelWithJSON:dic];
        NSLog(@"***666**%@**%@",dic,model.value);
  
    
    
    
//    YYsModel *model =[YYsModel modelWithJSON:dic];
//    
//    NSLog(@"*******%@",model.value);
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
