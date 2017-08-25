//
//  RequestFootView.m
//  WiseAPP
//
//  Created by app on 16/12/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "RequestFootView.h"

@implementation RequestFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
     
        [self adView];
    }
    return self;
}
-(void)adView{
    UIView*lineView=[[UIView alloc]init];
    lineView.frame =CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    lineView.backgroundColor=[UIColor grayColor];
    [self addSubview:lineView];
    
    UILabel*la=[[UILabel alloc]init];
    la.frame=CGRectMake(10, 0.5, SCREEN_WIDTH-20, PROPORTION_HIGHT(30));
    la.text=@"申请原因";
    la.textColor=textCententColor;
    la.font =[UIFont systemFontOfSize:16];
    [self addSubview:la];
    
    //输入框
    UIImage*image=[UIImage imageNamed:@"home_textView_contentbg.png"];
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame =CGRectMake(STANDARD_X, CGRectGetMaxY(la.frame)+10, STANDARD_WIDTH, image.size.height);
    textfBg.image=[UIImage imageNamed:@"home_textView_contentbg.png"];
    // textfBg.backgroundColor=[UIColor redColor];
    [self addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    self.contentTextView=[[UITextView alloc]init];
    self.contentTextView.frame = textfBg.bounds;;
    self.contentTextView.backgroundColor=[UIColor clearColor];
    self.contentTextView.font =[UIFont systemFontOfSize:17];
    [textfBg addSubview: self.contentTextView];
    self.contentTextView.textColor=textColorPlace;
    
    UILabel*warinLa=[[UILabel alloc]init];
    warinLa.frame = CGRectMake( self.contentTextView.width-100,  self.contentTextView.height-20, 100, 20);
    warinLa.text =@"210字";
    warinLa.textColor =[UIColor grayColor];
    warinLa.font =[UIFont systemFontOfSize:14];
    warinLa.textAlignment = NSTextAlignmentCenter;
    [self.contentTextView addSubview:warinLa];
    

}

@end
