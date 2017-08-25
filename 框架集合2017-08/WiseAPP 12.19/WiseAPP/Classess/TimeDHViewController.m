//
//  TimeDHViewController.m
//  SelectTime
//
//  Created by app on 16/11/15.
//  Copyright © 2016年 i. All rights reserved.
//

#import "TimeDHViewController.h"
#import "TimeDHview.h"


@interface TimeDHViewController ()
@property(nonatomic,strong)TimeDHview* timedhView;

@property(nonatomic,assign)NSInteger hour;
@property(nonatomic,assign)NSInteger mine;

@end

@implementation TimeDHViewController
-(void)loadView{
    self.timedhView =[[TimeDHview alloc]init];
    self.view =self.timedhView;
    
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self curretime];
    [self addView];
    

    
}
-(void)curretime{
    
    NSDate *now = [NSDate date];
    NSLog(@"now date is: %@", now);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
//    NSInteger year = [dateComponent year];
//    NSInteger month =  [dateComponent month];
//    NSInteger day = [dateComponent day];
    NSInteger hour =  [dateComponent hour];
    NSInteger minute =  [dateComponent minute];
    
    self.hour = hour;
    self.mine= minute;
    
    if (hour < 10) {
          self.timedhView.hourLa.text = [NSString stringWithFormat:@"%0ld",hour];
    } else {
          self.timedhView.hourLa.text = [NSString stringWithFormat:@"%ld",hour];
    }
  
    if (minute<10) {
         self.timedhView.mineLa.text = [NSString stringWithFormat:@"%0ld",minute];
    } else {
         self.timedhView.mineLa.text = [NSString stringWithFormat:@"%ld",minute];
    }
    
   
    
    
       NSString*timestring=[NSString stringWithFormat:@"%ld:%ld",(long)self.hour,(long)self.mine];
       self.timeString =timestring;
}
-(void)addView{
    
    self.timedhView.titleLa.text=self.title;
    [self.timedhView.hourJiaBtn addTarget:self action:@selector(hourJia:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.timedhView.mineJiaBtn addTarget:self action:@selector(mineJia:) forControlEvents:(UIControlEventTouchUpInside)];
    
     [self.timedhView.hourJianBtn addTarget:self action:@selector(hourJian:) forControlEvents:(UIControlEventTouchUpInside)];
     [self.timedhView.mineJianBtn addTarget:self action:@selector(mineJian:) forControlEvents:(UIControlEventTouchUpInside)];
    

    
    [self.timedhView.timeDoneBtn addTarget:self action:@selector(timdone:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
-(void)hourJia:(UIButton*)sender{
  
    if (self.hour>=0 && self.hour<=23) {
       // self.hour=01;
        self.hour+=1;
        if (self.hour>=0&&self.hour<10) {
              self.timedhView.hourLa.text = [NSString stringWithFormat:@"0%ld",(long)self.hour];
        } else {
            self.timedhView.hourLa.text = [NSString stringWithFormat:@"%ld",(long)self.hour];
        }
        
    }
//    else if(self.hour==0){
//        self.hour=24;
//        self.hour-=1;
//        if (self.hour>=0&&self.hour<10) {
//            self.timedhView.hourLa.text = [NSString stringWithFormat:@"0%ld",(long)self.hour];
//        } else {
//            self.timedhView.hourLa.text = [NSString stringWithFormat:@"%ld",(long)self.hour];
//        }
//
//        
//    }

}
-(void)hourJian:(UIButton*)sender{

    if (self.hour>0 &&self.hour<24) {
        self.hour-=1;
        if (self.hour>=0&&self.hour<10) {
            self.timedhView.hourLa.text = [NSString stringWithFormat:@"0%ld",(long)self.hour];
        } else {
            if (self.hour>=0&&self.hour<10) {
                self.timedhView.hourLa.text = [NSString stringWithFormat:@"0%ld",(long)self.hour];
            } else {
                self.timedhView.hourLa.text = [NSString stringWithFormat:@"%ld",(long)self.hour];
            }

        }

    }else if (self.hour==24){
    
        self.hour-=1;
        if (self.hour>=0&&self.hour<10) {
            self.timedhView.hourLa.text = [NSString stringWithFormat:@"0%ld",(long)self.hour];
        } else {
            self.timedhView.hourLa.text = [NSString stringWithFormat:@"%ld",(long)self.hour];
        }

    }
    
}
-(void)mineJia:(UIButton*)sender{
    if (self.mine>=0 &&self.mine<60) {
        self.mine+=1;
        if (self.mine>=0 &&self.mine<10) {
             self.timedhView.mineLa.text = [NSString stringWithFormat:@"0%ld",(long)self.mine];
        } else {
             self.timedhView.mineLa.text = [NSString stringWithFormat:@"%ld",(long)self.mine];
        }
       
    }
}

-(void)mineJian:(UIButton*)sender{
   
    if (self.mine>0 &&self.mine<60) {
        self.mine-=1;
        if (self.mine>=0 &&self.mine<10) {
            self.timedhView.mineLa.text = [NSString stringWithFormat:@"0%ld",(long)self.mine];
        } else {
            self.timedhView.mineLa.text = [NSString stringWithFormat:@"%ld",(long)self.mine];
        }

    }else if (self.mine ==60){
        self.mine-=1;
        if (self.mine>=0 &&self.mine<10) {
            self.timedhView.mineLa.text = [NSString stringWithFormat:@"0%ld",(long)self.mine];
        } else {
            self.timedhView.mineLa.text = [NSString stringWithFormat:@"%ld",(long)self.mine];
        }

    }
}

-(void)timdone:(UIButton*)sender{
    
    NSString*timestring=[NSString stringWithFormat:@"%ld:%ld",(long)self.hour,(long)self.mine];

 if (self.hour<10&&self.mine>=10){
    timestring =[NSString stringWithFormat:@"0%ld:%ld",(long)self.hour,(long)self.mine];
    }else if(self.hour<10&&self.mine<10){
      timestring =[NSString stringWithFormat:@"0%ld:0%ld",(long)self.hour,(long)self.mine];
    }else if (self.hour>=10&&self.mine>=10){
       timestring =[NSString stringWithFormat:@"%ld:%ld",(long)self.hour,(long)self.mine];
    }else{
     timestring =[NSString stringWithFormat:@"%ld:0%ld",(long)self.hour,(long)self.mine];
    }
    
       self.timeString =timestring;
    [self.delegate passTime:self.timeString type:self.uppagetype];
    
    [UIView animateWithDuration:0.01 animations:^{
    //[self.navigationController popViewControllerAnimated:NO];
        //if ([self.uppagetype isEqualToString:@"开始时间"]) {
            
           [self dismissViewControllerAnimated:YES completion:nil];
       // }
        
        
    }];
 
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
