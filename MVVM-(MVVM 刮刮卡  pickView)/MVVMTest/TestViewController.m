//
//  TestViewController.m
//  MVVMTest
//
//  Created by youxin on 2017/7/17.
//  Copyright © 2017年 李泽鲁. All rights reserved.
//

#import "TestViewController.h"
#import "NSDate+TTDate.h"
#import "HYScratchCardView.h"


@interface TestViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSDate *date;
    NSDate *date2;
    
}
@property (nonatomic,strong)HYScratchCardView * hys;
@property(nonatomic,strong)UIImageView *imageView ;

@property(nonatomic,strong)UIPickerView *picker;
@property(nonatomic,strong)UIPickerView *pick2;

@end

@implementation TestViewController
{
    NSDictionary *books;
NSMutableArray*authors;
    //selectedAuthor保存当前选中的作者
    NSString *selectAuthor;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
//    NSDate *date = [NSDate dateFromString:@"12:01" ];
//    NSDate *date2 = [NSDate dateFromString:@"22:22" ];
    
    _picker =[[UIPickerView alloc]init];
    _picker.frame = CGRectMake(0, 400, 414, 336);
    [self.view addSubview:   _picker];
      _picker.backgroundColor =[UIColor redColor];
      _picker.delegate = self;
    
//    self.pick2 =[[UIPickerView alloc]init];
//    self.pick2.frame = CGRectMake(414/2, 400, 414/2, 336);
//    [self.view addSubview:self.pick2];
//    self.pick2.backgroundColor =[UIColor greenColor];
//    self.pick2.delegate = self;


//数据源
    authors = (NSMutableArray*)@[@"ios讲义",@"andros讲义",@"java讲义",@"xml讲义",@"ios讲义"];

    selectAuthor = [authors objectAtIndex:0];
    
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    [self createSubViews];
    [self mohuImage];
}

-(void)mohuImage{

    _hys = [[HYScratchCardView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds)/2, 150, CGRectGetMaxX(self.view.bounds)/2, 200)];
    
    UIImage * image = [UIImage imageNamed:@"1.jpg"];
    
    //顶图
    _hys.surfaceImage = image;
    //低图，此函数为马赛克算法
    _hys.image = [self transToMosaicImage:image blockLevel:10];
    
    [self.view addSubview:_hys];
    
  
//  马赛克  链接：http://www.jianshu.com/p/e4bebae1b36f
    }
#define kBitsPerComponent (8)
#define kBitsPerPixel (32)
#define kPixelChannelCount (4)

/*
 *转换成马赛克,level代表一个点转为多少level*level的正方形
 */
- (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level
{
    //获取BitmapData
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imgRef = orginImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  kBitsPerComponent,        //每个颜色值8bit
                                                  width*kPixelChannelCount, //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit
                                                  colorSpace,
                                                  kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    unsigned char *bitmapData = CGBitmapContextGetData (context);
    
    //这里把BitmapData进行马赛克转换,就是用一个点的颜色填充一个level*level的正方形
    unsigned char pixel[kPixelChannelCount] = {0};
    NSUInteger index,preIndex;
    for (NSUInteger i = 0; i < height - 1 ; i++) {
        for (NSUInteger j = 0; j < width - 1; j++) {
            index = i * width + j;
            if (i % level == 0) {
                if (j % level == 0) {
                    memcpy(pixel, bitmapData + kPixelChannelCount*index, kPixelChannelCount);
                }else{
                    memcpy(bitmapData + kPixelChannelCount*index, pixel, kPixelChannelCount);
                }
            } else {
                preIndex = (i-1)*width +j;
                memcpy(bitmapData + kPixelChannelCount*index, bitmapData + kPixelChannelCount*preIndex, kPixelChannelCount);
            }
        }
    }
    
    NSInteger dataLength = width*height* kPixelChannelCount;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData, dataLength, NULL);
    //创建要输出的图像
    CGImageRef mosaicImageRef = CGImageCreate(width, height,
                                              kBitsPerComponent,
                                              kBitsPerPixel,
                                              width*kPixelChannelCount ,
                                              colorSpace,
                                              kCGImageAlphaPremultipliedLast,
                                              provider,
                                              NULL, NO,
                                              kCGRenderingIntentDefault);
    CGContextRef outputContext = CGBitmapContextCreate(nil,
                                                       width,
                                                       height,
                                                       kBitsPerComponent,
                                                       width*kPixelChannelCount,
                                                       colorSpace,
                                                       kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(outputContext, CGRectMake(0.0f, 0.0f, width, height), mosaicImageRef);
    CGImageRef resultImageRef = CGBitmapContextCreateImage(outputContext);
    UIImage *resultImage = nil;
    if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
        float scale = [[UIScreen mainScreen] scale];
        resultImage = [UIImage imageWithCGImage:resultImageRef scale:scale orientation:UIImageOrientationUp];
    } else {
        resultImage = [UIImage imageWithCGImage:resultImageRef];
    }
    //释放
    if(resultImageRef){
        CFRelease(resultImageRef);
    }
    if(mosaicImageRef){
        CFRelease(mosaicImageRef);
    }
    if(colorSpace){
        CGColorSpaceRelease(colorSpace);
    }
    if(provider){
        CGDataProviderRelease(provider);
    }
    if(context){
        CGContextRelease(context);
    }
    if(outputContext){
        CGContextRelease(outputContext);
    }
    return resultImage  ;
    
}

-(void)createSubViews {
    /**
     注意:
     1. 这两个控件的位置要相同
     2. 一定要先创建下面的label, 再创建图片
     */
    
    // 展示刮出来的效果的view
    UILabel *labelL        = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 150, 200)];
    labelL.text            = @"特等奖：一亿";
    labelL.numberOfLines   = 0;
    labelL.backgroundColor = [UIColor brownColor];
    labelL.font            = [UIFont systemFontOfSize:30];
    labelL.textAlignment   = NSTextAlignmentCenter;
    [self.view addSubview:labelL];
    
    // 被刮的图片
    self.imageView       = [[UIImageView alloc] initWithFrame:labelL.frame];
    self.imageView.image = [UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:self.imageView];
}


//链接：http://www.jianshu.com/p/7c2042764e0c

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 触摸任意位置
    UITouch *touch = touches.anyObject;
    // 触摸位置在图片上的坐标
    CGPoint cententPoint = [touch locationInView:self.imageView];
    // 设置清除点的大小
    CGRect  rect = CGRectMake(cententPoint.x, cententPoint.y, 10, 10);
    // 默认是去创建一个透明的视图
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
    // 获取上下文(画板)
    CGContextRef ref = UIGraphicsGetCurrentContext();
    // 把imageView的layer映射到上下文中
    [self.imageView.layer renderInContext:ref];
    // 清除划过的区域
    CGContextClearRect(ref, rect);
    // 获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束图片的画板, (意味着图片在上下文中消失)
    UIGraphicsEndImageContext();
    
    self.imageView.image = image;
}



//该方法返回控件该控件包含多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}


//该方法返回值决定该控件的制定列包含多少个列表项
-(NSInteger)pickerView:(UIPickerView *)pickerView                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              numberOfRowsInComponent:(NSInteger)component
{
    if (component == 2) {
        
        return 1;
    }else{
      return  authors.count;
    }
  
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //若果是第一列，则返回authors中的元素的个数
    //即authors有多少个元素，那么第一列就包含多少个列表项
    if (component == 2) {
        
//        [self clearSeparatorWithView:self.picker];
        
//
//        ((UIView *)[self.picker.subviews objectAtIndex:1]).backgroundColor = [UIColor clearColor];
//        
//        ((UIView *)[self.picker.subviews objectAtIndex:2]).backgroundColor = [UIColor clearColor];
//

        return @"至";
 
    }
    
    
    //否则其他列返回的个数是books中的键值对中值对应的数组地元素的个数
    return [authors objectAtIndex:row];
}

- (UIView *)viewForRow:(NSInteger)row forComponent:(NSInteger)component{

    if (component == 2) {
        return  [[UIView alloc]init];
    }
    return nil;
}




- (void)clearSeparatorWithView:(UIView * )view
{
    if(view.subviews != 0  )
    {
        if(view.bounds.size.height < 5 )
        {
            view.backgroundColor = [UIColor clearColor];
            
        }
        
        [view.subviews enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
            
           [self clearSeparatorWithView:obj];
        }];
    }
    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    //如果是第一列，则宽度是90

    return 414/5;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  
    
    if (pickerView == self.picker ) {
     
            selectAuthor = [authors objectAtIndex:row];

        NSLog(@"*****%@",selectAuthor);
}else{
   
        //改变选中的作者
        selectAuthor = [authors objectAtIndex:row];
      NSLog(@"*****%@",selectAuthor);

}
    
    

}


@end
