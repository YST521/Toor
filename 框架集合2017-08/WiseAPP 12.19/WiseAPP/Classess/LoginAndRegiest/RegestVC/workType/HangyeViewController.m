//
//  HangyeViewController.m
//  WiseAPP
//
//  Created by app on 16/10/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "HangyeViewController.h"

//#define Start_X 46.0f           // 第一个按钮的X坐标
#define Start_Y 20.0f           // 第一个按钮的Y坐标
#define Width_Space 5.0f        // 2个按钮之间的横间距
#define Height_Space 10.0f      // 竖间距
//#define Button_Height 45.0f    // 高
//#define Button_Width 88.0f      // 宽

@interface HangyeViewController ()
@property(nonatomic,assign)NSInteger indexBtn;
@property(nonatomic,strong)UIButton*opBtn;
@property(nonatomic,strong)NSMutableArray*array;
@property(nonatomic,strong)POPView* otherView;

@end

@implementation HangyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.modalPresentationStyle = .custom
  
    //self.view.backgroundColor = popBGColore;
        self.indexBtn = 1000;
    self.navigationItem.title = @"行业";
    self.array=[NSMutableArray array];
    [self addButtonS];

}

-(void)addButtonS
{
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, PROPORTION_HIGHT(220));
    //bgView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:bgView];
    for (int i = 0 ; i < 7; i++) {
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        
        // 圆角按钮
       self.opBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
      self.opBtn.frame = CGRectMake(index * (PROPORTION_WIDTH(279/3) + Width_Space) + PROPORTION_WIDTH(46), page  * (PROPORTION_HIGHT(45) + Height_Space)+Start_Y, PROPORTION_WIDTH(279/3), PROPORTION_HIGHT(45));
       
        //KUIbutton(self.opBtn);
        NSArray*array=@[@"保安",@"消防",@"工程",@"保洁",@"客服",@"其它",@"+"];
        [self.opBtn setTitle:array[i] forState:(UIControlStateNormal)];
        self.opBtn.tag = self.indexBtn+i;
        [self.opBtn setBackgroundImage:[UIImage imageNamed:@"loginbutton.png"] forState:(UIControlStateNormal)];
        [self.opBtn setBackgroundImage:[UIImage imageNamed:@"home_btnc"] forState:(UIControlStateSelected)];

        [bgView addSubview:self.opBtn];
        [self.opBtn addTarget:self action:@selector(abtAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    //loginbuttonclick.png

    UIButton*commitBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    commitBtn.frame =  STANDARDWH(CGRectGetMaxY(bgView.frame)+10);
    KUIbutton(commitBtn);
    KUIbuttonClick(commitBtn);
    [commitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [self.view addSubview:commitBtn];
    [commitBtn addTarget:self action:@selector(commitBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UILabel*label=[[UILabel alloc]init];
    label.frame = CGRectMake(PROPORTION_WIDTH(46), CGRectGetMaxY(commitBtn.frame)+PROPORTION_HIGHT(20), SCREEN_WIDTH-PROPORTION_WIDTH(46*2), 20);
    label.text = @"* 请选择您的技能，最多选择3个";
    label.font =[UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    }
-(void)commitBtnAction:(UIButton*)sender{
    NSLog(@"****%@",self.array);
    
    if (self.array.count>1&&self.array.count<4) {
         self.passHangyeBlock(self.array);        [self.navigationController popViewControllerAnimated:YES];
    } else{

        [self AlerVCtitleString:@"提示" messageString:@"最多只能选择三项,最少选择一项" doneString:@"确定"];
    }


}

-(void)abtAction:(UIButton*)sender{
        sender.selected = !sender.selected;

    if (sender.tag == 1000) {
     
        if (sender.selected == YES) {
                   [self.array addObject:@"保安"];
        }else{
              [self.array removeObject:@"保安"];
        }
     }else if (sender.tag == 1001){
    
         if (sender.selected == YES) {
             [self.array addObject:@"消防"];
         }else{
             [self.array removeObject:@"消防"];
         }

    
    }else if (sender.tag == 1002){
        
        if (sender.selected == YES) {
            [self.array addObject:@"工程"];
        }else{
            [self.array removeObject:@"工程"];
        }

    }else if (sender.tag == 1003){
        
        if (sender.selected == YES) {
            [self.array addObject:@"保洁"];
        }else{
            [self.array removeObject:@"保洁"];
        }
        
    }else if (sender.tag == 1004){
        
        if (sender.selected == YES) {
            [self.array addObject:@"客服"];
        }else{
            [self.array removeObject:@"客服"];
        }
        
    }else if (sender.tag == 1005){
        
        if (sender.selected == YES) {
            self.otherView=[[POPView alloc]init];
            self.otherView.frame =UIScreenBpunds;
            [self.view addSubview:self.otherView];
            self.otherView.popTitle.text = @"其它";
            self.otherView.popTextFile.placeholder =@"请输入你的行业";
         
            [self.otherView.popDoneBtn addTarget:self action:@selector(popDoneAction:) forControlEvents:(UIControlEventTouchUpInside)];
            
        }else{
            [self.array removeObject:@"其它"];
        };
        
    }else if (sender.tag == 1006){
        
      [self.array addObject:@"+"];
        
    }
    

}
-(void)popDoneAction:(UIButton*)sender{
    
    [self.array addObject:self.otherView.popTextFile.text];
    self.otherView.hidden = YES;

}

-(void)AlerVCtitleString:(NSString*)title messageString:(NSString*)message doneString:(NSString*)doneString{
    
    UIAlertController*alerVC= [UIAlertController alertControllerWithTitle:title message:message preferredStyle:( UIAlertControllerStyleAlert)];
    UIAlertAction*al= [UIAlertAction actionWithTitle:doneString style:(UIAlertActionStyleDefault) handler:nil];
    [alerVC addAction:al];
    [self presentViewController:alerVC animated:YES completion:nil];
    
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
