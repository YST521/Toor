//
//  LinBaoAddViewController.m
//  WiseAPP
//
//  Created by app on 16/11/3.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "LinBaoAddViewController.h"
#import "LinbaoAddView.h"
#import "LinbaoModel.h"
#import "LinbaoViewController.h"
#import "TimeYYMMDDViewController.h"

@interface LinBaoAddViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,passTimYMDHMvalue>

@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)LinbaoAddView*linbaoAddView;
@property(nonatomic,strong)UIScrollView* scrollview;

@end
static NSString* linbaoCellID =@"linbaoCellID";
@implementation LinBaoAddViewController
-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

//-(void)loadView{
//    self.linbaoAddView =[[LinbaoAddView alloc]initWithFrame:UIScreenBpunds];
//    self.view = self.linbaoAddView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title =@"临保设置";;
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    
    [self addView];
    [self textViewDelegate];
    
    if (self.pageType ==1) {
        self.linbaoAddView.peopleFi.text =self.model.projectleader;
        self.linbaoAddView.activeNameFi.text =self.model.projectname;
        self.linbaoAddView.starTimFi.text =self.model.startingtime;
        self.linbaoAddView.endTimFi.text =self.model.endtime;
        self.linbaoAddView.describeFv.text =self.model.description;
        self.linbaoAddView.phoneFi.text =self.model.phone;
        self.linbaoAddView.placeFi.text =self.model.address;
        
    }
    
}
-(void)addView{
    self.scrollview =[[UIScrollView alloc]initWithFrame:UIScreenBpunds];
    self.scrollview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.scrollview];
    self.scrollview.showsHorizontalScrollIndicator=NO;
       self.linbaoAddView =[[LinbaoAddView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+PROPORTION_HIGHT(250))];
    [self.scrollview addSubview:self.linbaoAddView];
    self.scrollview.contentSize =CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+PROPORTION_HIGHT(250));
    
    self.linbaoAddView.starTimFi.delegate=self;
    self.linbaoAddView.endTimFi.delegate =self;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //turn page
    if (textField ==self.linbaoAddView.starTimFi) {
       TimeYYMMDDViewController*daVC=[[TimeYYMMDDViewController alloc]init];
        daVC.delegate =self;
        daVC.timeTitle = @"开始时间";
        daVC.uppagetype=@"开始时间";
        [self presentViewController:daVC animated:YES completion:nil];
    }else{
        TimeYYMMDDViewController*timeVC=[[TimeYYMMDDViewController alloc]init];
        timeVC.modalTransitionStyle= UIModalPresentationNone;
        timeVC.delegate =self;
        timeVC.timeTitle = @"结束时间";
        timeVC.uppagetype=@"结束时间";
        [self presentViewController:timeVC animated:YES completion:nil];
        
    }
    
}
-(void)passYMRTime:(NSString *)timeString type:(NSString *)typeString{
    if ([typeString isEqualToString:@"开始时间"]) {
      self.linbaoAddView.starTimFi.text = timeString;
      self.linbaoAddView.starTimFi.textColor=textCententColor;
        
    } else {
        
        self.linbaoAddView.endTimFi.text= timeString;
        self.linbaoAddView.endTimFi.textColor =textCententColor;
    }
    

    
}
#pragma mark - UITextViewDelegate
-(void)textViewDelegate{
    
    self.linbaoAddView.describeFv.text=@"例如：1.维护场地秩序";
    self.linbaoAddView.describeFv.delegate=self;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"例如：1.维护场地秩序";
        
        textView.textColor = textColorPlace;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"例如：1.维护场地秩序"]){
        textView.text=@"";
        
        textView.textColor=[UIColor blackColor];
    }
    
}

-(void)saveAction:(UIButton*)sender{
    [self requestTitle];
   
    
}
//conditions
-(void)requestTitle{
    if ([self.linbaoAddView.activeNameFi.text isEqualToString:@" "]||self.linbaoAddView.activeNameFi.text.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"请输入活动名称" doneString:@"确定"];
    } else {
        [self requestPlace];
    }


}
-(void)requestPlace{
    if ([self.linbaoAddView.placeFi.text isEqualToString:@" "]|| self.linbaoAddView.placeFi.text.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"请输入临保活动地点" doneString:@"确定"];
    } else {
        [self requestPeope];
        
    }


}
-(void)requestPeope{
    if ([self.linbaoAddView.peopleFi.text isEqualToString:@" "]||self.linbaoAddView.peopleFi.text.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"请输入临保负责人名字" doneString:@"确定"];
    } else {
        [self requestPhone];
    }
}
-(void)requestPhone{

    if ([self.linbaoAddView.phoneFi.text isEqualToString:@" "]||self.linbaoAddView.phoneFi.text .length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"请输入临保负责人手机号码" doneString:@"确定"];
    } else {
        if ([self valiMobile:self.linbaoAddView.phoneFi.text]) {
             [self requestNumber];
            
        } else {
             [self AlerVCtitleString:@"提示" messageString:@"手机号格式错误" doneString:@"确定"];
            
        }

    }

}
-(void)requestNumber{
    if ([self.linbaoAddView.numberFi.text isEqualToString:@" "]||self.linbaoAddView.numberFi.text.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"临保人数不能为空" doneString:@"确定"];
    } else {
        [self requestTime];
    }

}

-(void)requestTime{

    if ([self.linbaoAddView.starTimFi.text isEqualToString:@" "]||self.linbaoAddView.starTimFi.text .length==0||[self.linbaoAddView.endTimFi.text isEqualToString:@" "]||self.linbaoAddView.endTimFi.text .length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"请输入临保开始结束时间" doneString:@"确定"];
    } else {
        [self requestDetail];
    }




}
-(void)requestDetail{
    if ([self.linbaoAddView.describeFv.text isEqualToString:@"例如：1.维护场地秩序"]) {
        [self AlerVCtitleString:@"提示" messageString:@"请输入临保活动描述" doneString:@"确定"];
    } else {
        
    
    if ([self.linbaoAddView.describeFv.text isEqualToString:@" "]||self.linbaoAddView.describeFv.text.length==0) {
        
        [self AlerVCtitleString:@"提示" messageString:@"请输入临保活动描述" doneString:@"确定"];
    
    }else{
    
        if (self.pageType ==1) {
            [self updateData];
        }else{
            [self addData];
        }

    }
    }
    
    

}






-(void)updateData{
   
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    [dic setValue:ID forKey:@"projectid"];
    [dic setValue:self.linbaoAddView.activeNameFi.text forKey:@"projectname"];
      [dic setObject:@(self.model.id) forKey:@"id"];
    [dic setValue:self.linbaoAddView.peopleFi.text forKey:@"projectleader"];
    [dic setValue:self.linbaoAddView.starTimFi.text forKey:@"startingtime"];
    [dic setValue:self.linbaoAddView.endTimFi.text forKey:@"endtime"];
    [dic setValue:self.linbaoAddView.describeFv.text forKey:@"description"];
    [dic setValue:self.linbaoAddView.phoneFi.text forKey:@"phone"];
    [dic setValue:self.linbaoAddView.phoneFi.text forKey:@"address"];
     [dic setValue:@([self.linbaoAddView.numberFi.text intValue]) forKey:@"number"];
    
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"proinsuranceUpdate"] Token:self.tokenString parmpar:dic succeed:^(id data) {
        for (NSArray*ARRY in [data allValues]) {
            NSLog(@"wwww%@",ARRY);
        }
        //if (data[@"resultCode"] ==0) {
            [self turnUpPage];
       // }
        
    } failure:^(NSError *error) {
        
    }];

}

-(void)addData{

    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
       NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    [dic setValue:ID forKey:@"projectid"];
      [dic setValue:self.linbaoAddView.activeNameFi.text forKey:@"projectname"];
    [dic setValue:self.linbaoAddView.peopleFi.text forKey:@"projectleader"];
    [dic setValue:self.linbaoAddView.starTimFi.text forKey:@"startingtime"];
    [dic setValue:self.linbaoAddView.endTimFi.text forKey:@"endtime"];
    [dic setValue:self.linbaoAddView.describeFv.text forKey:@"description"];
    [dic setValue:self.linbaoAddView.phoneFi.text forKey:@"phone"];
    [dic setValue:self.linbaoAddView.placeFi.text forKey:@"address"];
    [dic setValue:@([self.linbaoAddView.numberFi.text intValue])  forKey:@"number"];
    
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"proinsuranceAdd"] Token:self.tokenString parmpar:dic succeed:^(id data) {
      
       // if (data[@"resultCode"] ==0) {
            [self turnUpPage];
       // }
    } failure:^(NSError *error) {
        
    }];
    
    


}
-(void)turnUpPage{
    for (UIViewController*collector in self.navigationController.viewControllers) {
        if ([collector isKindOfClass:[LinbaoViewController class]]) {
            LinbaoViewController*linbaoVC =(LinbaoViewController*)collector;
            [self.navigationController popToViewController:linbaoVC animated:YES];
        }
    }
}



//    self.linBaoTabView=[[UITableView alloc]initWithFrame:UIScreenBpunds style:(UITableViewStylePlain)];
//    [self.view addSubview:self.linBaoTabView];
//    self.linBaoTabView.dataSource =self;
//    self.linBaoTabView.delegate =self;
//    [self.linBaoTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:linbaoCellID];
//
//}
//
//#pragma mark ---tableviewdelegate------
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    return self.dataArray.count;
//}
//
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell*cell=[self.linBaoTabView dequeueReusableCellWithIdentifier:linbaoCellID ];
//    cell
//    
//    return cell;
//
//
//}

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
