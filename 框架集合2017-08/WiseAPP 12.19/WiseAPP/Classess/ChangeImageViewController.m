//
//  ChangeImageViewController.m
//  ADimage
//
//  Created by yst911521 on 2016/10/29.
//  Copyright © 2016年 yst911521. All rights reserved.
//

#import "ChangeImageViewController.h"
#import "UIImage+ImageBlur.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define btnWH 70
#define btnMargin 50

@interface ChangeImageViewController ()<UIGestureRecognizerDelegate>
{
    CGFloat lastScale;
    CGRect oldFrame;    //保存图片原来的大小
    CGRect largeFrame;  //确定图片放大最大的程度
}
@property(nonatomic,strong)UIView* footView;
@property(nonatomic,strong) UIButton* leftBtn;
@property(nonatomic,strong) UIButton* leftMBtn;
@property(nonatomic,strong) UIButton* rightMBtn;
@property(nonatomic,strong) UIButton* rightBtn;
@property(nonatomic,strong) UIButton* shuiyinBtn;
@property(nonatomic,strong)UITextField* shuiyinTe;

@property(nonatomic,assign) NSInteger index;

@property(nonatomic,strong)UIImageView* jiantouImage;
@property(nonatomic,strong)UIImageView* yuanquanImage;

@property(nonatomic,strong) UISlider *mySlider;  //高斯模糊
@property(nonatomic,strong)UILabel* sliderLa;

@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UIImageView*  lastImage;

@end

@implementation ChangeImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = @"图片标注";
    [self addView];
    //手势处理 http://blog.csdn.net/crazy_frog/article/details/8664108/
    //http://bbs.csdn.net/topics/390344118 高斯
}
-(void)addView{
    //需要编辑的图片
    self.baseImage=[[UIImageView alloc]init];
    self.baseImage.frame = CGRectMake(0, 0, screenW, screenH-150);
    self.baseImage.backgroundColor=[UIColor greenColor];
    [self.view addSubview:self.baseImage];
    self.baseImage.image=[UIImage imageNamed:@"baseimage"];
    self.baseImage.userInteractionEnabled = YES;
   
    
   // UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    //[self.baseImage addGestureRecognizer:pinchGestureRecognizer];
    
   
    
   //底部视图
    self.footView =[[UIView alloc]init];
    self.footView.frame=CGRectMake(0, screenH-100, screenW, 100);
    self.footView.backgroundColor=[UIColor blueColor];
    [self.view addSubview:self.footView];
    
     self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(backAction:)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(savaAction:)];
    //slider 压缩质量
    self.mySlider = [[UISlider alloc] initWithFrame:CGRectMake(0,0, 200.0f, 25.0f)];
    _mySlider.center = CGPointMake(screenW/2, CGRectGetMaxY(self.baseImage.frame)+15);
    self.mySlider.minimumValue = 0.0f;//滑动条的最小值
    self.mySlider.maximumValue = 100.0f;//滑动条的最大值
    self.mySlider.value = _mySlider.maximumValue/3.0;//滑动条的当前值
    [ self.mySlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];//添加滑动事件
     self.mySlider.continuous = NO;//设置只有在离开滑动条的最后时刻才触发滑动事件
    [ self.mySlider setThumbImage:[UIImage imageNamed:@"slider.png"] forState:UIControlStateHighlighted];//设置滑动的时候显示的图片
    [self.view addSubview: self.mySlider];//添加视图
      self.mySlider.hidden = YES;
    self.sliderLa=[[UILabel alloc]init];
    self.sliderLa.frame = CGRectMake(CGRectGetMaxX(self.mySlider.frame)+2, self.mySlider.frame.origin.y, 80, 25);
    self.sliderLa.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.sliderLa];
    self.sliderLa.text=[NSString stringWithFormat:@"%.2f",_mySlider.maximumValue/3.0];
    self.sliderLa.hidden = YES;
    
    //下面四个按钮
    for (int i =0; i<5; i++) {
       UIButton* btn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(i*screenW/5, 0, screenW/5, self.footView.frame.size.height);
        [self.footView addSubview:btn];
        
        btn.tag = 100+ i;
        self.index = i;
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        if (btn.tag==100) {
            btn.backgroundColor =[UIColor redColor];
            [btn setTitle:@"箭头" forState:(UIControlStateNormal)];
        }else if (btn.tag==101){
        
            btn.backgroundColor=[UIColor greenColor];
             [btn setTitle:@"圈" forState:(UIControlStateNormal)];
        }else if (btn.tag==102){
            
            btn.backgroundColor=[UIColor blueColor];
             [btn setTitle:@"压缩比例" forState:(UIControlStateNormal)];
        }else if(btn.tag == 103){
        btn.backgroundColor=[UIColor yellowColor];
             [btn setTitle:@"高斯模糊" forState:(UIControlStateNormal)];
        }else{
        
            btn.backgroundColor=[UIColor blackColor];
            [btn setTitle:@"水印" forState:(UIControlStateNormal)];
        
        }
        
    }
    
    //水印lable
    self.shuiyinTe=[[UITextField alloc]init];
    self.shuiyinTe.frame = CGRectMake(20, self.mySlider.frame.origin.y, 200, 25);
    self.shuiyinTe.placeholder = @"请输入备注";
    [self.view addSubview:self.shuiyinTe];
    self.shuiyinTe.hidden=YES;
    

}

//添加水印
- (UIImage *) addText:(UIImage *)img text:(NSString *)mark {
    int w = img.size.width;
    int h = img.size.height;
    UIGraphicsBeginImageContext(img.size);
    [[UIColor redColor] set];
    [img drawInRect:CGRectMake(0, 0, w, h)];
    [mark drawInRect:CGRectMake(100, 345, 130, 80) withFont:[UIFont systemFontOfSize:30]];
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aimg;
    
}


-(void)backAction:(UIBarButtonItem*)sender{
    
    [self  dismissViewControllerAnimated:YES completion:nil];
    
    
}
//保存
-(void)savaAction:(UIBarButtonItem*)sender{


    NSLog(@"666saveImage");
    self.lastImage=[[UIImageView alloc]init];
    self.lastImage.frame = CGRectMake(0, 0, screenW, screenH);
    [self.view addSubview:self.lastImage];
    self.lastImage.backgroundColor=[UIColor yellowColor];
    self.lastImage.image =[self imageFromView:self.baseImage atFrame:self.baseImage.bounds];
}

//获得某个范围内的屏幕图像
- (UIImage *)imageFromView: (UIImageView *) theView  atFrame:(CGRect)r
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}


-(void)btnAction:(UIButton*)sender{

  
    if (sender.tag ==100) {
         NSLog(@"999");
        [self jiantouAction];
    }else if (sender.tag ==101){
          NSLog(@"99988");
        [self yuanquanAaction];
    
    }else if (sender.tag ==102){
             NSLog(@"999995");
        [self sizeValue];
        
    }else if (sender.tag ==103){
        
             NSLog(@"999532143");
        [self mohuAAction];
    }else if (sender.tag ==104){
        
        self.shuiyinTe.hidden = NO;
        UIImage*im=[[UIImage alloc]init];
        im=[self addText:self.baseImage.image text:self.shuiyinTe.text];
        self.baseImage.image = im;
    
    }


}

-(void)sizeValue{

    self.mySlider.hidden =NO;
    self.sliderLa.hidden = NO;
}

//添加滑动事件
-(void)sliderValueChanged:(UISlider *)paramSender{
    if ([paramSender isEqual:self.mySlider]) {
        NSLog(@"New value=%f",paramSender.value);
        if (paramSender.value >10) {
            
        
        self.sliderLa.text =  [NSString stringWithFormat:@"%.2f",paramSender.value];
        
        [self addImageinputRadiusValue:paramSender.value];
        }else{
        //[self addImageinputRadiusValue:0];
            self.baseImage.image =[UIImage imageNamed:@"baseimage"];
        }
    }
}




//箭头点击事件
-(void)jiantouAction{
    self.jiantouImage=[[UIImageView alloc]init];
    self.jiantouImage.frame = CGRectMake(0, 0, 50, 50);
    self.jiantouImage.center = self.view.center;
    [self.baseImage addSubview:self.jiantouImage];
    self.jiantouImage.image=[UIImage imageNamed:@"jiantou"];
    self.jiantouImage.userInteractionEnabled=YES;
    //self.baseImage.userInteractionEnabled =NO;
    [self addGestureRecognizerToView:self.jiantouImage];
    

}

-(void)yuanquanAaction{

    self.yuanquanImage=[[UIImageView alloc]init];
   self.yuanquanImage.frame = CGRectMake(0, 0, 70, 50);
  self.yuanquanImage.center = self.baseImage.center;
    [self.baseImage addSubview:self.yuanquanImage];
   self.yuanquanImage.image=[UIImage imageNamed:@"yuanquan"];
   self.yuanquanImage.userInteractionEnabled=YES;
    [self addGestureRecognizerToView:self.yuanquanImage];

}
-(void)mohuAAction{

 self.imageView = self.baseImage;

    
   //self.baseImage = [[UIImageView alloc] initWithFrame:<span class="s1">CGRectMake</span>(<span class="s2">0</span>, <span class="s2">0</span>, 320, 480)];
//    [self.yuanquanImage setMultipleTouchEnabled:YES];
//    [self.yuanquanImage setUserInteractionEnabled:YES];
//    [self.yuanquanImage setImage:[UIImage imageNamed:@"1.jpg"]];
//    
//    oldFrame = self.baseImage.frame;
//    largeFrame = CGRectMake(0 - screenW, 0 - screenH, 3 * oldFrame.size.width, 3 * oldFrame.size.height);
//    
//    [self addGestureRecognizerToView:self.baseImage];
//    [self.baseImage addSubview:self.yuanquanImage];
}
//高斯模糊
-(void)addImageinputRadiusValue:(CGFloat)value {
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self.baseImage.image];
    // create gaussian blur filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:1.0] forKey:@"inputRadius"];//调整模糊度
    // blur image
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    self.baseImage.image = image;
    
}

// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [view addGestureRecognizer:rotationGestureRecognizer];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}

// 处理缩放手势 优化缩放
//- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
//{
//    UIView *view = pinchGestureRecognizer.view;
//    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
//        if (self.baseImage.frame.size.width < oldFrame.size.width) {
//           self.baseImage.frame = oldFrame;
//            //让图片无法缩得比原图小
//        }
//        if (self.baseImage.frame.size.width > 3 * oldFrame.size.width) {
//           self.baseImage.frame = largeFrame;
//        }
//        pinchGestureRecognizer.scale = 1;
//    }
//}

//高斯模糊
- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
    
    
}
- (UIImage *) addImageToImage:(UIImage *)img withImage2:(UIImage *)img2 andRect:(CGRect)cropRect{
    
    CGSize size = CGSizeMake(self.imageView.image.size.width, self.imageView.image.size.height);
    UIGraphicsBeginImageContext(size);
    
    CGPoint pointImg1 = CGPointMake(0,0);
    [img drawAtPoint:pointImg1];
    
    CGPoint pointImg2 = cropRect.origin;
    [img2 drawAtPoint: pointImg2];
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}
-(UIImage *)roundedRectImageFromImage:(UIImage *)image withRadious:(CGFloat)radious {
    
    if(radious == 0.0f)
        return image;
    
    if( image != nil) {
        
        CGFloat imageWidth = image.size.width;
        CGFloat imageHeight = image.size.height;
        
        CGRect rect = CGRectMake(0.0f, 0.0f, imageWidth, imageHeight);
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        const CGFloat scale = window.screen.scale;
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, scale);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextBeginPath(context);
        CGContextSaveGState(context);
        CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextScaleCTM (context, radious, radious);
        
        CGFloat rectWidth = CGRectGetWidth (rect)/radious;
        CGFloat rectHeight = CGRectGetHeight (rect)/radious;
        
        CGContextMoveToPoint(context, rectWidth, rectHeight/2.0f);
        CGContextAddArcToPoint(context, rectWidth, rectHeight, rectWidth/2.0f, rectHeight, radious);
        CGContextAddArcToPoint(context, 0.0f, rectHeight, 0.0f, rectHeight/2.0f, radious);
        CGContextAddArcToPoint(context, 0.0f, 0.0f, rectWidth/2.0f, 0.0f, radious);
        CGContextAddArcToPoint(context, rectWidth, 0.0f, rectWidth, rectHeight/2.0f, radious);
        CGContextRestoreGState(context);
        CGContextClosePath(context);
        CGContextClip(context);
        
        [image drawInRect:CGRectMake(0.0f, 0.0f, imageWidth, imageHeight)];
        
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    } 
    return nil;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UIImage *croppedImg = nil;
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.imageView];
    
    double ratioW=self.imageView.image.size.width/self.imageView.frame.size.width ;
    
    double ratioH=self.imageView.image.size.height/self.imageView.frame.size.height;
    
    currentPoint.x *= ratioW;
    currentPoint.y *= ratioH;
    
    double circleSizeW = 30 * ratioW;
    double circleSizeH = 30 * ratioH;
    
    
    currentPoint.x = (currentPoint.x - circleSizeW/2<0)? 0 : currentPoint.x - circleSizeW/2;
    currentPoint.y = (currentPoint.y - circleSizeH/2<0)? 0 : currentPoint.y - circleSizeH/2;
    
    
    CGRect cropRect = CGRectMake(currentPoint.x , currentPoint.y,   circleSizeW,  circleSizeH);
    
    NSLog(@"x %0.0f, y %0.0f, width %0.0f, height %0.0f", cropRect.origin.x, cropRect.origin.y,   cropRect.size.width,  cropRect.size.height );
    
    croppedImg = [self croppIngimageByImageName:self.imageView.image toRect:cropRect];
    
    // Blur Effect
    croppedImg = [croppedImg imageWithGaussianBlur9];
    
    // Contrast Effect
    // croppedImg = [croppedImg imageWithContrast:50];
    
    
    
    croppedImg = [self roundedRectImageFromImage:croppedImg withRadious:4];
    
   self.imageView.image = [self addImageToImage:self.imageView.image withImage2:croppedImg andRect:cropRect];
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
