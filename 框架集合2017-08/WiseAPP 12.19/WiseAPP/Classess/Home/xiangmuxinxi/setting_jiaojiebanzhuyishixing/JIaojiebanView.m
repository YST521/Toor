//
//  JIaojiebanView.m
//  WiseAPP
//
//  Created by yst911521 on 2016/10/30.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "JIaojiebanView.h"

@implementation JIaojiebanView
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        [self addView];
    }
    return self;
    
}

-(void)addView{
    UILabel* titleLa=[[UILabel alloc]init];
    titleLa.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 30);
    titleLa.text = @"交接班次";
    titleLa.textColor = textCententColor;
    [self addSubview:titleLa];
    
    UIImageView*imagBg=[[UIImageView alloc]init];
    imagBg.frame = STANDARDWH(CGRectGetMaxY(titleLa.frame)+10);
    //textfilebackgroundimage.png // textfile
    imagBg.image =[UIImage imageNamed:@"home_text_bg.png"];
    
    [self addSubview:imagBg];
    imagBg.userInteractionEnabled = YES;
    
    self.produceFile=[[UITextField alloc]init];
    self.produceFile.frame = CGRectMake(5, 0, imagBg.width-5, imagBg.height);
    self.produceFile.placeholder =@"日班";
    self.produceFile.textAlignment=NSTextAlignmentCenter;
    self.produceFile.textColor = textCententColor;
    [imagBg addSubview:self.produceFile];
    
    UILabel* contentLa=[[UILabel alloc]init];
    contentLa.frame = CGRectMake(10, CGRectGetMaxY(imagBg.frame)+PROPORTION_HIGHT(20), STANDARD_WIDTH , 30);
    contentLa.text = @"交接班注意事项内容";
    contentLa.textColor=textCententColor;
    contentLa.textColor = textCententColor;
    [self addSubview:contentLa];
    //输入框
     UIImage*image=[UIImage imageNamed:@"home_textView_contentbg.png"];
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame =CGRectMake(STANDARD_X, CGRectGetMaxY(contentLa.frame)+10, STANDARD_WIDTH, image.size.height);
    textfBg.image=[UIImage imageNamed:@"home_textView_contentbg.png"];
   // textfBg.backgroundColor=[UIColor redColor];
    [self addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;

    self.contentFile=[[UITextView alloc]init];
    self.contentFile.frame = textfBg.bounds;;
    self.contentFile.backgroundColor=[UIColor clearColor];
     self.contentFile.font =[UIFont systemFontOfSize:17];
    [textfBg addSubview:self.contentFile];
    self.contentFile.textColor=textColorPlace;
    
    UILabel*warinLa=[[UILabel alloc]init];
    warinLa.frame = CGRectMake(self.contentFile.width-100, self.contentFile.height-20, 100, 20);
    warinLa.text =@"210字";
    warinLa.textColor =[UIColor grayColor];
    warinLa.font =[UIFont systemFontOfSize:14];
    warinLa.textAlignment = NSTextAlignmentCenter;
    [self.contentFile addSubview:warinLa];
    
    self.photoView=[[UIView alloc]init];
    self.photoView.frame = CGRectMake(0, CGRectGetMaxY(textfBg.frame)+10, SCREEN_WIDTH, PROPORTION_HIGHT(100));
    //self.photoView.backgroundColor=[UIColor yellowColor];
    [self addSubview:self.photoView];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
