//
//  GangweiPeixunView.m
//  WiseAPP
//
//  Created by app on 16/11/1.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "GangweiPeixunView.h"

@implementation GangweiPeixunView
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
       
        [self addView];
    }

    return self;
}

-(void)addView{

    
    UILabel* titleLa=[[UILabel alloc]init];
    titleLa.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 30);
    titleLa.text = @"培训主题名称";
    titleLa.textColor = textCententColor;
    [self addSubview:titleLa];
    
    
    UIImageView*imagBg=[[UIImageView alloc]init];
    imagBg.frame = STANDARDWH(CGRectGetMaxY(titleLa.frame)+10);
    //textfilebackgroundimage.png // textfile
    imagBg.image =[UIImage imageNamed:@"home_text_bg.png"];
    
    [self addSubview:imagBg];
    imagBg.userInteractionEnabled = YES;
    
    
    self.produceFile=[[UITextField alloc]init];
    self.produceFile.frame =CGRectMake(5, 0, imagBg.width-5, imagBg.height);
    self.produceFile.placeholder =@"例如： 微笑礼仪";
    self.produceFile.textColor = textCententColor;
    [imagBg addSubview:self.produceFile];
    
    UILabel* contentLa=[[UILabel alloc]init];
    contentLa.frame = CGRectMake(10, CGRectGetMaxY(imagBg.frame)+PROPORTION_HIGHT(20), STANDARD_WIDTH , 30);
    contentLa.text = @"培训内容";
    contentLa.textColor = textCententColor;
    [self addSubview:contentLa];
    
    //输入框
    UIImage*image=[UIImage imageNamed:@"home_textView_contentbg.png"];
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame =CGRectMake(STANDARD_X, CGRectGetMaxY(contentLa.frame)+10, STANDARD_WIDTH, image.size.height);
    //home_content.png
    textfBg.image=[UIImage imageNamed:@"home_textView_contentbg.png"];
    textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    self.contentFile=[[UITextView alloc]init];
    self.contentFile.frame = textfBg.bounds;;
    self.contentFile.font =[UIFont systemFontOfSize:17];
    self.contentFile.backgroundColor=[UIColor clearColor];
   
    self.contentFile.textColor =textColorPlace;
    [textfBg addSubview:self.contentFile];
    
    UILabel*warinLa=[[UILabel alloc]init];
    warinLa.frame = CGRectMake(self.contentFile.width-100, self.contentFile.height-20, 100, 20);
    warinLa.text =@"210字";
    warinLa.textColor =[UIColor grayColor];
    warinLa.textAlignment = NSTextAlignmentCenter;
     warinLa.font =[UIFont systemFontOfSize:14];
    [self.contentFile addSubview:warinLa];
    
    
    self.addImageView=[[UIView alloc]init];
    self.addImageView.frame = CGRectMake(0, CGRectGetMaxY(textfBg.frame)+10, SCREEN_WIDTH, PROPORTION_HIGHT(100));
    [self addSubview:self.addImageView];
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
