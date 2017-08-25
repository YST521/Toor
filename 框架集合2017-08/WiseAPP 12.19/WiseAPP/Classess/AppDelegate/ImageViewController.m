//
//  ImageViewController.m
//  app 引导页面
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "ImageViewController.h"
#import "RootUITabBarController.h"
#import "LoginViewController.h"
#import "RootUINavigationController.h"


#define kWidth  self.view.bounds.size.width
#define kheight  self.view.bounds.size.height
#define  kImageMath   4 

@interface ImageViewController ()<UIScrollViewDelegate>



@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 //设置背景图片
    [self creatRootImageView];
    [self createScroller];
    [self createpage];
  }

#pragma mark 创建背景图片

-(void)creatRootImageView
{
   
    //全屏
    UIImageView *rootImageView =[[UIImageView alloc]initWithFrame:self.view.bounds];
//添加一个背景图片
    [rootImageView setImage:[UIImage imageNamed:@"new_feature_background.png" ]];
    [self.view addSubview:rootImageView];
//开启交互
    self.view.userInteractionEnabled =YES;

}
//添加引导图 图片
-(void)createScroller
{
    self.scroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    //放四张引导图
    self.scroll.contentSize =CGSizeMake(kWidth*kImageMath , 0);
    
    for(int i =0;i<kImageMath;i++)
    {
        UIImageView *pageImageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*kWidth, 0, kWidth,kheight)];
        pageImageView .image=[UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i+1 ]];
       
        if(i==3)
        {
            [self createIntoButton:pageImageView];
        
        }
        
        [self.scroll addSubview:pageImageView];
    
    }
    
    
    //设置分页,否则滚动效果很糟糕
    [self.scroll setPagingEnabled:YES];
    //    去掉弹性
    [self.scroll setBounces:NO];
    //    去掉滚动条
    [self.scroll setShowsHorizontalScrollIndicator:NO];
    [self.scroll setShowsVerticalScrollIndicator:NO];
    //    设置代理,以便于滑动时改变pageControl
    [self.scroll setDelegate:self];
    //    scrollView目前为第二层视图
    [self.view addSubview:self.scroll];
 }
//创建page
-(void)createpage
{

    self.page=[[UIPageControl alloc] init];
    //    设置位置
    [self.page setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height * 0.9)];
    //page位置
    [self.page setBounds:CGRectMake(0, 0, 150, 44)];
    
    //    设置页数
    [self.page setNumberOfPages:4];
    //    设置页面轨道颜色
    //非当前点的颜色
    [self.page setPageIndicatorTintColor:[UIColor grayColor]];
    //当前点的颜色
    [self.page setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    
    //    注意，父视图不是ScrollView!
    [self.view addSubview:self.page];


}
//最后一个页面button
-(void)createIntoButton:(UIImageView*)pageImageView
{
    //    开启父视图交互
    [pageImageView setUserInteractionEnabled:YES];
    
    //创建进入下个页面 button
    UIButton *intoButton=[[UIButton alloc] init];
    //    设置背景图片
    UIImage *backImage=[UIImage imageNamed:@"new_feature_finish_button.png"];
    UIImage *backImageHL=[UIImage imageNamed:@"new_feature_finish_button_highlighted.png"];
    [intoButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [intoButton setBackgroundImage:backImageHL forState:UIControlStateHighlighted];
    //    设置中心点和大小,大小根据背景
    CGFloat centerX=pageImageView.bounds.size.width/2;
    CGFloat centerY=pageImageView.bounds.size.height * 0.8;
//    CGFloat width=backImage.size.width;
//    CGFloat height=backImage.size.height;
    [intoButton setBounds:CGRectMake(50, kheight-30, kWidth-100, 40)];
    [intoButton setCenter:CGPointMake(centerX, centerY)];
    //    消息响应
    [intoButton addTarget:self action:@selector(intoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    添加到pageImageView
    [pageImageView addSubview:intoButton];
    



}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/scrollView.bounds.size.width;
    [self.page setCurrentPage:index];
}
#pragma mark "立即体验"按钮消息响应
//点击立即体验跳到下一个页面
-(void)intoButtonClick:(UIButton*)sender{
    //跳转到主页
    RootUITabBarController*rootTabar= [[RootUITabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = rootTabar;
  //跳转到登陆页面
    LoginViewController*loginVC = [[LoginViewController alloc]init];
    RootUINavigationController*na=[[RootUINavigationController alloc]initWithRootViewController:loginVC];
   [UIApplication sharedApplication].keyWindow.rootViewController = na;
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
