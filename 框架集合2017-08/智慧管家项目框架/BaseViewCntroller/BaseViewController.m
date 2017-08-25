//
//  BaseViewController.m
//  WiseAPP
//
//  Created by app on 16/10/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addView];
}


-(void)addView{
/*
    UIImageView*image = [[UIImageView alloc]init];
    image.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    image.image = [UIImage imageNamed:@"Rectangle 5.png"];
    [self.view addSubview:image];
 */
    
     UINavigationBar *bar = [UINavigationBar appearance];
    [bar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:21],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//    UIImage*imagev=[UIImage imageNamed:@"Rectangle 5.png"];
//    UIImageView*imageView = [[UIImageView alloc]init];
//    imageView.frame = CGRectMake(0, 0, 414, 64);
//    imageView.image = imagev;
   // self.navigationItem.titleView =  imageView;
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Rectangle 5.png"] forBarMetrics:UIBarMetricsDefault];
    
    NSLog(@"%@",self.navigationController.navigationBar);
    
   
    [bar setBackgroundImage:[UIImage imageNamed:@"Rectangle 5"] forBarMetrics:UIBarMetricsDefault];
    
    
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
