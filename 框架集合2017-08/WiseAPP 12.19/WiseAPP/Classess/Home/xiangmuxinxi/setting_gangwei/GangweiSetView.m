//
//  GangweiSetView.m
//  WiseAPP
//
//  Created by app on 16/11/1.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "GangweiSetView.h"

@implementation GangweiSetView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addView];
    }
    
    return self;
}

-(void)addView{
    UILabel* titleLa=[[UILabel alloc]init];
    titleLa.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 30);
    titleLa.text = @"岗位名称";
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
    self.produceFile.placeholder =@"例如：1号岗";
    //self.produceFile.text=@"你好";
    self.produceFile.textColor = textCententColor;
    //self.produceFile.backgroundColor=[UIColor blueColor];
    [imagBg addSubview:self.produceFile];
    
    UILabel* contentLa=[[UILabel alloc]init];
    contentLa.frame = CGRectMake(10, CGRectGetMaxY(imagBg.frame)+PROPORTION_HIGHT(20), STANDARD_WIDTH , 30);
    contentLa.text = @"岗位任务";
    contentLa.textColor = textCententColor;
    [self addSubview:contentLa];
    
    //输入框
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame =CGRectMake(STANDARD_X, CGRectGetMaxY(contentLa.frame)+10, STANDARD_WIDTH, PROPORTION_HIGHT(300));
    textfBg.image=[UIImage imageNamed:@"home_textView_contentbg.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    self.contentFile=[[UITextView alloc]init];
    self.contentFile.frame = textfBg.bounds;
    self.contentFile.backgroundColor=[UIColor clearColor];
    self.contentFile.font =[UIFont systemFontOfSize:16];
    [textfBg addSubview:self.contentFile];
    self.contentFile.text=@"例如：工作时间不得玩手机";
    self.contentFile.textColor=textColorPlace;
    
    UILabel*warinLa=[[UILabel alloc]init];
    warinLa.frame = CGRectMake(self.contentFile.width-100, self.contentFile.height-20, 100, 20);
    warinLa.text =@"210字";
    warinLa.textColor =[UIColor grayColor];
    warinLa.font =[UIFont systemFontOfSize:14];
    warinLa.textAlignment = NSTextAlignmentCenter;
    [self.contentFile addSubview:warinLa];
    
//    UILabel*la=[[UILabel alloc]init];
//    la.frame =CGRectMake(10, CGRectGetMaxY(textfBg.frame)+2, 200, 15);
//    la.text = @"提示：最多只能上传三张图片！";
//    la.font =[UIFont systemFontOfSize:12];
//    [self addSubview:la ];
//    
//    self.addImageView=[[UIView alloc]init];
//    self.addImageView.frame = CGRectMake(0, CGRectGetMaxY(la.frame)+10, SCREEN_WIDTH, PROPORTION_HIGHT(100));
//    //self.addImageView.backgroundColor=[UIColor yellowColor];
//    [self addSubview:self.addImageView];
 
    
    
}

@end
