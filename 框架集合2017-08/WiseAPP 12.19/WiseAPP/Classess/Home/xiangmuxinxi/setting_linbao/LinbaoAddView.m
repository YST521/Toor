//
//  LinbaoAddView.m
//  WiseAPP
//
//  Created by app on 16/11/3.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "LinbaoAddView.h"

@implementation LinbaoAddView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addView];
    }
    return  self;
}

-(void)addView{
    
   // self.backgroundColor=[UIColor redColor];
    self.backgroundColor=[UIColor whiteColor];
    
    UILabel* titleLa=[[UILabel alloc]init];
    titleLa.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 30);
    titleLa.text = @"活动名称";
    titleLa.textColor = textCententColor;
    [self addSubview:titleLa];
    
    UIImageView*imagBg=[[UIImageView alloc]init];
    imagBg.frame = STANDARDWH(CGRectGetMaxY(titleLa.frame)+10);
    //textfilebackgroundimage.png // textfile
    imagBg.image =[UIImage imageNamed:@"home_text_bg.png"];
    
    [self addSubview:imagBg];
    imagBg.userInteractionEnabled = YES;
    
    self.activeNameFi=[[UITextField alloc]init];
    self.activeNameFi.frame = CGRectMake(10, 0, imagBg.width-20, imagBg.height);
    self.activeNameFi.placeholder =@"例如： 文化广场";
    self.activeNameFi.textColor = [UIColor grayColor];
    //self.produceFile.backgroundColor=[UIColor blueColor];
    [imagBg addSubview:self.activeNameFi];
    
    UILabel* placeLa=[[UILabel alloc]init];
    placeLa.frame = CGRectMake(titleLa.x , CGRectGetMaxY(imagBg.frame)+10, titleLa.width, 30);
    placeLa.text = @"活动地点";
    placeLa.textColor = textCententColor;
    [self addSubview:placeLa];
    //活动地点
    UIImageView*placeBg=[[UIImageView alloc]init];
    placeBg.frame = STANDARDWH(CGRectGetMaxY(placeLa.frame)+10);
    //textfilebackgroundimage.png // textfile
    placeBg.image =[UIImage imageNamed:@"home_text_bg.png"];
    
    [self addSubview:placeBg];
    placeBg.userInteractionEnabled = YES;
    
    self.placeFi=[[UITextField alloc]init];
    self.placeFi.frame = CGRectMake(10, 0, imagBg.width-20, imagBg.height);
    self.placeFi.placeholder =@"例如：上海市人民广场";
    self.placeFi.textColor = textCententColor;
    //self.produceFile.backgroundColor=[UIColor blueColor];
    [ placeBg addSubview:self.placeFi];
    
    UILabel* peopleLa=[[UILabel alloc]init];
    peopleLa.frame = CGRectMake(titleLa.x , CGRectGetMaxY(placeBg.frame)+10, titleLa.width, 30);
    peopleLa.text = @"任务负责人";
    peopleLa.textColor = textCententColor;
    [self addSubview:peopleLa];
    
    UIImageView*peopleBg=[[UIImageView alloc]init];
    peopleBg.frame = STANDARDWH(CGRectGetMaxY( peopleLa.frame)+10);
    //textfilebackgroundimage.png // textfile
    peopleBg.image =[UIImage imageNamed:@"home_text_bg.png"];
    
    [self addSubview:peopleBg];
    peopleBg.userInteractionEnabled = YES;
    
    self.peopleFi=[[UITextField alloc]init];
    self.peopleFi.frame = CGRectMake(10, 0, imagBg.width-20, imagBg.height);
    self.peopleFi.placeholder =@"例如： 张三";
    self.peopleFi.textColor = textCententColor;
    //self.produceFile.backgroundColor=[UIColor blueColor];
    [ peopleBg addSubview:self.peopleFi];
    
    UILabel* phoneLa=[[UILabel alloc]init];
    phoneLa.frame = CGRectMake(titleLa.x , CGRectGetMaxY(peopleBg.frame)+10, titleLa.width, 30);
    phoneLa.text = @"电话号码";
    phoneLa.textColor = textCententColor;
    [self addSubview:phoneLa];
    
    UIImageView*phoneBg=[[UIImageView alloc]init];
    phoneBg.frame = STANDARDWH(CGRectGetMaxY(phoneLa.frame)+10);
    //textfilebackgroundimage.png // textfile
    phoneBg.image =[UIImage imageNamed:@"home_text_bg.png"];
    
    [self addSubview:phoneBg];
    phoneBg.userInteractionEnabled = YES;
    
    self.phoneFi=[[UITextField alloc]init];
    self.phoneFi.frame = CGRectMake(10, 0, imagBg.width-20, imagBg.height);
    self.phoneFi.placeholder =@"例如：188888888";
    self.phoneFi.textColor = textCententColor;
    //self.produceFile.backgroundColor=[UIColor blueColor];
    [ phoneBg addSubview:self.phoneFi];
    self.phoneFi.keyboardType =UIKeyboardTypeNumberPad;
    
    UILabel* numberLa=[[UILabel alloc]init];
    numberLa.frame = CGRectMake(titleLa.x , CGRectGetMaxY(phoneBg.frame)+10, titleLa.width, 30);
    numberLa.text = @"执行人数";
    numberLa.textColor = textCententColor;
    [self addSubview:numberLa];
    
    UIImageView*numberBg=[[UIImageView alloc]init];
    numberBg.frame = STANDARDWH(CGRectGetMaxY(numberLa.frame)+10);
    //textfilebackgroundimage.png // textfile
    numberBg.image =[UIImage imageNamed:@"home_text_bg.png"];
    
    [self addSubview:numberBg];
    numberBg.userInteractionEnabled = YES;
    
    self.numberFi=[[UITextField alloc]init];
    self.numberFi.frame = CGRectMake(10, 0, imagBg.width-20, imagBg.height);
    self.numberFi.placeholder =@"例如:临保人数";
    self.numberFi.textColor = textCententColor;
    //self.produceFile.backgroundColor=[UIColor blueColor];
    self.numberFi.keyboardType=UIKeyboardTypeNumberPad;
    [ numberBg addSubview:self.numberFi];
    
   
    
    UILabel* activeTimLa=[[UILabel alloc]init];
    activeTimLa.frame = CGRectMake(titleLa.x , CGRectGetMaxY( numberBg.frame)+10, titleLa.width, 30);
    activeTimLa.text = @"活动时间";
    activeTimLa.textColor = textCententColor;
    [self addSubview:activeTimLa];
    
    UIImageView*starBg=[[UIImageView alloc]init];
    starBg.frame = CGRectMake( imagBg.x, CGRectGetMaxY(activeTimLa.frame)+10,STANDARD_WIDTH,  numberBg.height);
    //textfilebackgroundimage.png // textfile
    //home_textfile_duanbg.png
    starBg.image =[UIImage imageNamed:@"home_text_bg.png"];
    
    [self addSubview:starBg];
    starBg.userInteractionEnabled = YES;
    
    self.starTimFi=[[UITextField alloc]init];
    self.starTimFi.frame = starBg.bounds;
    self.starTimFi.placeholder =@"开始时间：2016—12—12 08：00";
    self.starTimFi.textAlignment =NSTextAlignmentCenter;
    self.starTimFi.textColor = textCententColor;
    //self.produceFile.backgroundColor=[UIColor blueColor];
    [ starBg addSubview:self.starTimFi];
    self.starTimFi.keyboardType =UIKeyboardTypeNumberPad;
    
    UIImageView*endBg=[[UIImageView alloc]init];
    endBg.frame = CGRectMake(starBg.x, CGRectGetMaxY(starBg.frame)+10, STANDARD_WIDTH, peopleBg.height);
    endBg.image =[UIImage imageNamed:@"home_text_bg.png"];
    
    [self addSubview:endBg];
    endBg.userInteractionEnabled = YES;
    
    self.endTimFi=[[UITextField alloc]init];
    self.endTimFi.frame = endBg.bounds;
    self.endTimFi.placeholder =@"结束时间：2016—12—12 12：00";
    self.endTimFi.textAlignment =NSTextAlignmentCenter;
    self.endTimFi.textColor = textCententColor;
    [endBg addSubview:self.endTimFi];
    self.endTimFi.keyboardType =UIKeyboardTypeNumberPad;
    
    UILabel* descLa=[[UILabel alloc]init];
    descLa.frame = CGRectMake(titleLa.x , CGRectGetMaxY(endBg.frame)+10, STANDARD_WIDTH, 30);
    descLa.text = @"活动描述";
    descLa.textColor = textCententColor;
    [self addSubview:descLa];
    
    
    //    //输入框
    UIImage*image=[UIImage imageNamed:@"home_textView_contentbg.png"];
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame =CGRectMake(STANDARD_X, CGRectGetMaxY(descLa.frame)+10, STANDARD_WIDTH,image.size.height);
    //home_textView_contentbg  home_pu_content.png
    textfBg.image=[UIImage imageNamed:@"home_textView_contentbg.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    //
    self.describeFv=[[UITextView alloc]init];
    self.describeFv.frame = CGRectMake(5, 0, textfBg.width-10, textfBg.height);
    self.describeFv.font =[UIFont systemFontOfSize:17];
    self.describeFv.backgroundColor =[UIColor clearColor];
    self.describeFv.textColor =textColorPlace;
    [textfBg addSubview:self.describeFv];
    //
    UILabel*warinLa=[[UILabel alloc]init];
    warinLa.frame = CGRectMake(self.describeFv.width-100, self.describeFv.height-20, 100, 20);
    warinLa.text =@"210字";
    warinLa.font =[UIFont systemFontOfSize:14];
    warinLa.textColor =[UIColor grayColor];
    warinLa.textAlignment = NSTextAlignmentCenter;
    [self.describeFv addSubview:warinLa];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
