//
//  TimeYYMMDDViewController.m
//  WiseAPP
//
//  Created by app on 16/11/16.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "TimeYYMMDDViewController.h"
#import "TimeYYMMDDView.h"

@interface TimeYYMMDDViewController ()
@property(nonatomic,strong)TimeYYMMDDView* timeYMDView;
@property(nonatomic,assign)NSInteger curreYear;
@property(nonatomic,assign)NSInteger curreMonth;
@property(nonatomic,assign)NSInteger curreDay;
@property(nonatomic,assign)NSInteger curreHour;
@property(nonatomic,assign)NSInteger curreMinuts;

@property(nonatomic,strong)UILabel* yearLa;
@property(nonatomic,strong)UILabel* monthLa;
@property(nonatomic,strong)UILabel* dayLa;
@property(nonatomic,strong)UILabel* hourLa;
@property(nonatomic,strong)UILabel* mintusLa;

//
@property(nonatomic,strong)UIImageView* titleImagewView;
@property(nonatomic,strong)UILabel* titleLa;
//turn
@property(nonatomic,strong)UIButton* btn;
@property(nonatomic,strong)UILabel* la;
@property(nonatomic,strong)UIImageView* labg;
@property(nonatomic,strong)UIButton* jianbtn;
@property(nonatomic,strong)UIButton* DoneBtn;

//@property(nonatomic,strong)NSString* selectTimeString;

@end

@implementation TimeYYMMDDViewController
//-(void)loadView{
//    self.timeYMDView =[[TimeYYMMDDView alloc]init];
//
//    self.view = self.timeYMDView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self currredate];
    [self addView];
    [self labelData];
   
}
-(void)addView{
    self.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.view.backgroundColor=popBGColore;
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(250));
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    bgView.userInteractionEnabled = YES;
    
    UIImageView*titleBg=[[UIImageView alloc]init];
    titleBg.frame = CGRectMake(0, 0, bgView.width,  STANDARD_HEIGHT);
    titleBg.image =[UIImage imageNamed:@"nabackgroundImage.png"];
    [bgView addSubview:titleBg];
    
    self.titleLa=[[UILabel alloc]init];
    self.titleLa.frame =titleBg.bounds;
    self.titleLa.textColor =[UIColor whiteColor];
    self.titleLa.textAlignment = NSTextAlignmentCenter;
    [titleBg addSubview:self.titleLa];
    
    self.titleLa.text= self.timeTitle;
    
    for (int i = 0 ; i < 5; i++) {
        // 圆角按钮
        UIButton* dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        dateBtn.frame =CGRectMake(i*(PROPORTION_WIDTH(44)+PROPORTION_WIDTH(15))+PROPORTION_WIDTH(44),CGRectGetMaxY(self.titleLa.frame)+10, PROPORTION_WIDTH(44), PROPORTION_HIGHT(30));
        
        [dateBtn setImage:[UIImage imageNamed:@"home_jiahao"] forState:(UIControlStateNormal)];
        
        
        [bgView addSubview:dateBtn];
        self.btn =dateBtn;
        dateBtn.tag = 600+ i;
        
        [dateBtn addTarget:self action:@selector(jiaBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    
    for (int i = 0 ; i < 5; i++) {
        
        UIImageView* hourBg =[[UIImageView alloc]init];
        hourBg.frame =CGRectMake(i*(PROPORTION_WIDTH(44)+PROPORTION_WIDTH(15))+PROPORTION_WIDTH(44),CGRectGetMaxY(self.btn.frame)+15, PROPORTION_WIDTH(44), PROPORTION_HIGHT(30));
        [bgView addSubview:hourBg];
        [hourBg setImage:[UIImage imageNamed:@"home_time_la"]];
        hourBg.userInteractionEnabled =YES;
        self.labg =hourBg;
        UILabel* timeLa = [[UILabel alloc]init];
        timeLa.frame =CGRectMake(2, 0, hourBg.width-4, hourBg.height);
        //timeLa.backgroundColor=[UIColor greenColor];
        self.la =timeLa;
        self.la.textAlignment =NSTextAlignmentCenter;
        [hourBg addSubview:timeLa];
        //self.la.text =@"2325345456";
        self.la.tag = 800+i;
    }
    //jian btn
    for (int i = 0 ; i < 5; i++) {
        
        UIButton* jianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        jianBtn.frame =CGRectMake(i*(PROPORTION_WIDTH(44)+PROPORTION_WIDTH(15))+PROPORTION_WIDTH(44),CGRectGetMaxY(self.labg.frame)+15, PROPORTION_WIDTH(44), PROPORTION_HIGHT(30));
        
        //[jianBtn setBackgroundImage:[UIImage imageNamed:@"loginbutton.png"] forState:(UIControlStateNormal)];
        [jianBtn setImage:[UIImage imageNamed:@"home_jianhao"] forState:(UIControlStateNormal)];
        
        //[jianBtn setTitle:@"-" forState:(UIControlStateNormal)];
        
        [bgView addSubview:jianBtn];
        
//        self.jianbtn =jianBtn;
        jianBtn.tag =300+i;
        
        [jianBtn addTarget:self action:@selector(jianBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];

    }
    
   
    

    
    self.DoneBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.DoneBtn.frame = CGRectMake(PROPORTION_WIDTH(16), bgView.height-PROPORTION_HIGHT(60), (bgView.width-PROPORTION_WIDTH(16)*2-10), STANDARD_HEIGHT);
    KUIbutton( self.DoneBtn);
    KUIbuttonClick(self.DoneBtn);
    [self.DoneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [bgView addSubview:self.DoneBtn];
    
    [self.DoneBtn addTarget:self action:@selector(doneAction:) forControlEvents:(UIControlEventTouchUpInside)];
 
    
}

-(void)currredate{
    NSDate *now = [NSDate date];
 
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        NSInteger year = [dateComponent year];
        NSInteger month =  [dateComponent month];
        NSInteger day = [dateComponent day];
      NSInteger hour =  [dateComponent hour];
      NSInteger minute =  [dateComponent minute];
    
    self.curreYear =year;
    self.curreMonth =month;
    self.curreDay =day;
    self.curreHour=hour;
    self.curreMinuts =minute;
    self.timeString=[NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld",(long)self.curreYear,(long)self.curreMonth,(long)self.curreDay ,(long)self.curreHour,(long)self.curreMinuts];
    
}
-(void)labelData{
    //原始数据
    self.yearLa = (UILabel *)[self.view viewWithTag:800];
    self.yearLa.text=[NSString stringWithFormat:@"%ld",self.curreYear];
    NSString* monthS=nil;
    if (self.curreMonth>0 &&self.curreMonth<10) {
        monthS=[NSString stringWithFormat:@"0%ld",self.curreMonth];
    } else {
        monthS=[NSString stringWithFormat:@"%ld",self.curreMonth];
    }
    self.monthLa = (UILabel *)[self.view viewWithTag:801];
    self.monthLa.text =monthS;
    NSString* dayS=nil;
    if (self.curreDay>0 &&self.curreDay<10) {
        dayS=[NSString stringWithFormat:@"0%ld",self.curreDay];
    } else {
        dayS=[NSString stringWithFormat:@"%ld",self.curreDay];
    }
    self.dayLa = (UILabel *)[self.view viewWithTag:802];
    self.dayLa.text =dayS;
    
    NSString* hourS=nil;
    if (self.curreHour>0 &&self.curreHour<10) {
        hourS=[NSString stringWithFormat:@"0%ld",self.curreHour];
    } else {
        hourS=[NSString stringWithFormat:@"%ld",self.curreHour];
    }
    self.hourLa = (UILabel *)[self.view viewWithTag:803];
    self.hourLa.text =hourS;
    
    NSString* mintuS=nil;
    if (self.curreMinuts>0 &&self.curreMinuts<10) {
        mintuS=[NSString stringWithFormat:@"0%ld",self.curreMinuts];
    } else {
        mintuS=[NSString stringWithFormat:@"%ld",self.curreMinuts];
    }
    self.mintusLa = (UILabel *)[self.view viewWithTag:804];
    self.mintusLa.text =mintuS;
    

}
//donebtn
-(void)doneAction:(UIButton*)sender{
 self.timeString=[NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld",(long)self.curreYear,(long)self.curreMonth,(long)self.curreDay ,(long)self.curreHour,(long)self.curreMinuts];
    
  // NSLog(@"************ %@-%@-%@ %@:%@",self.yearLa.text,self.monthLa.text,self.dayLa.text,self.hourLa.text,self.mintusLa.text);
    NSString*selectTime= [NSString stringWithFormat:@" %@-%@-%@ %@:%@",self.yearLa.text,self.monthLa.text,self.dayLa.text,self.hourLa.text,self.mintusLa.text];
    self.timeString =selectTime;

    
    [self.delegate passYMRTime: self.timeString  type:self.uppagetype];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//jiabtn
-(void)jiaBtnAction:(UIButton*)sender{
    if (sender.tag ==600) {
        [self addyear];
    } else if(sender.tag==601) {
        [self addMonth];
    }else if(sender.tag==602) {
        [self addDay];
    }else if(sender.tag==603) {
        [self addHour];
    }else if(sender.tag==604) {
        [self addMinutes];
    }



    
}
//jianbtn
-(void)jianBtnAction:(UIButton*)sender{
    
    if (sender.tag ==300) {
        [self reduceYear];
    } else if(sender.tag==301) {
        [self reduceMonth];
    }else if(sender.tag==302) {
        [self reduceDay];
    }else if(sender.tag==303) {
        [self reduceHours];
    }else if(sender.tag==304) {
        [self reduceMinutes];
    }

    
}
//加
-(void)addyear{
    self.curreYear++;
    self.yearLa.text= [NSString stringWithFormat:@"%ld",(long)self.curreYear];
    
}

-(void)addMonth{
    
      self.curreMonth++;
    
    
    if (self.curreMonth>=0 &&self.curreMonth<=12) {
  
   
    if (self.curreMonth<10) {
        self.monthLa.text= [NSString stringWithFormat:@"0%ld",(long)self.curreMonth];
    } else {
           self.monthLa.text= [NSString stringWithFormat:@"%ld",(long)self.curreMonth];
    }
    if (self.curreMonth>12) {
        self.monthLa.text= [NSString stringWithFormat:@"%ld",(long)self.curreMonth];
    }
    }
    
    
    
}
-(void)addDay{
    self.curreDay++;
    
    if (self.curreDay>=0 &&self.curreDay<=31) {
        
    if (self.curreDay<10) {
         self.dayLa.text= [NSString stringWithFormat:@"0%ld",(long)self.curreDay];
    } else {
        self.dayLa.text= [NSString stringWithFormat:@"%ld",(long)self.curreDay];
    }
    }
    
    

}
-(void)addHour{
    self.curreHour++;
    if (self.curreHour>=0 &&self.curreHour<=24) {
        
    
    if (self.curreHour<10) {
        self.hourLa.text= [NSString stringWithFormat:@"0%ld",(long)self.curreHour];
    } else {
        self.hourLa.text= [NSString stringWithFormat:@"%ld",(long)self.curreHour];
    }
    if (self.curreHour>24) {
        self.hourLa.text= [NSString stringWithFormat:@"%ld",(long)self.curreHour];
    }
    }


}
-(void)addMinutes{
    self.curreMinuts++;
    if (self.curreMinuts>=0 &&self.curreMinuts<=60) {
        
    
    
    if (self.curreMinuts<10) {
        self.mintusLa.text= [NSString stringWithFormat:@"0%ld",(long)self.curreMinuts];
    } else {
        self.mintusLa.text= [NSString stringWithFormat:@"%ld",(long)self.curreMinuts];
    }
    }
//    if (self.curreMinuts>60) {
//        self.mintusLa.text= @"01";
//    }else{
//    }
    
    
    
}

//减
-(void)reduceYear{

    self.curreYear--;
    self.yearLa.text= [NSString stringWithFormat:@"%ld",(long)self.curreYear];
}

-(void)reduceMonth{
    
    self.curreMonth--;
    if (self.curreMonth>=0 &&self.curreMonth<=12) {
        
    if (self.curreMonth>=0 &&self.curreMonth<12) {
 
    if (self.curreMonth<10) {
        self.monthLa.text= [NSString stringWithFormat:@"0%ld",(long)self.curreMonth];
    } else {
        self.monthLa.text= [NSString stringWithFormat:@"%ld",(long)self.curreMonth];
    }
    }
    }
//    if (self.curreMonth>12) {
//        self.monthLa.text= @"01";
//    }

    
}

-(void)reduceDay{
    self.curreDay--;
    if (self.curreDay>=0 &&self.curreDay<=31) {

    if (self.curreDay<10) {
        self.dayLa.text= [NSString stringWithFormat:@"0%ld",(long)self.curreDay];
    } else {
        self.dayLa.text= [NSString stringWithFormat:@"%ld",(long)self.curreDay];
    }
    }
//    if (self.curreDay>31) {
//        self.dayLa.text= @"01";
//    }
    
}
-(void)reduceHours{
    self.curreHour--;
        if (self.curreHour>=0 &&self.curreHour<=24) {
    if (self.curreHour<10) {
        self.hourLa.text= [NSString stringWithFormat:@"0%ld",(long)self.curreHour];
    } else {
        self.hourLa.text= [NSString stringWithFormat:@"%ld",(long)self.curreHour];
    }
        }


    
}
-(void)reduceMinutes{
    self.curreMinuts--;
     if (self.curreMinuts>=0 &&self.curreMinuts<=60) {
    if (self.curreMinuts<10) {
        self.mintusLa.text= [NSString stringWithFormat:@"0%ld",(long)self.curreMinuts];
    } else {
        self.mintusLa.text= [NSString stringWithFormat:@"%ld",(long)self.curreMinuts];
    }
     }
    
//    if (self.curreMinuts>60) {
//        self.mintusLa.text= @"01";
//    }
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
