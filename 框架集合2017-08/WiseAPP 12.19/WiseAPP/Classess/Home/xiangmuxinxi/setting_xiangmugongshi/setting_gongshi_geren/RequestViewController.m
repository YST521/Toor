//
//  RequestViewController.m
//  WiseAPP
//
//  Created by app on 16/12/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "RequestViewController.h"
#import "RequestCell.h"
#import "RequestFootView.h"
#import "SelectPeopleViewController.h"
#import "BanciModel.h"

@interface RequestViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,passUserIdDelegate>
@property(nonatomic,strong)UITableView* requestTabView;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)RequestFootView* footView;
@property(nonatomic,strong)UIView* bgView;
@property(nonatomic,strong)UIPickerView*pickView;
@property(nonatomic,strong)NSMutableArray*pickArray;

@property(nonatomic,strong)NSString* selectBanciStr;
@property(nonatomic,strong)NSString* selectDaysStr;
@property(nonatomic,strong)NSString* userid;

@end
static NSString*  requestCellID =@"requestCellID";
@implementation RequestViewController
-(UITableView *)requestTabView{
    if (!_requestTabView) {
        _requestTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStylePlain)];
    }
    return _requestTabView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title =@"工时申请";
    [self addData];
    [self addView];
    [self textViewDelegate];
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
}
//load data request work hours
-(void)saveAction:(UIBarButtonItem*)sender{

    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    NSMutableDictionary*parm=[NSMutableDictionary dictionary];
    [parm setObject:@([ID intValue]) forKey:@"projectid"];
    NSInteger index=[self.banciArray indexOfObject:self.selectBanciStr];
    NSString* service = self.banciID[index];
       [parm setObject:@([service intValue]) forKey:@"serviced"]; //????? serviced[]数组
    [parm setObject:@([self.selectDaysStr intValue]) forKey:@"day"];
    [parm setObject:@([self.userid intValue]) forKey:@"userid"];
    [parm setObject:self.footView.contentTextView.text forKey:@"reason"];
    
            NSLog(@"hhhh%@--%@",parm,self.banciID);
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"applicationAdd/hours"] Token:self.tokenString parmpar:parm succeed:^(id data) {
        
        NSLog(@"hhhh%@----",data);
        
    } failure:^(NSError *error) {
        
    }];

}



-(void)addData{
    self.dataArray=(NSMutableArray*)@[@"班次",@"天数",@"人员"];


}
-(void)addView{

    [self.view addSubview:self.requestTabView];
    [self.requestTabView registerClass:[RequestCell class] forCellReuseIdentifier:requestCellID];
    self.requestTabView.dataSource=self;
    self.requestTabView.delegate=self;
    
    self.footView=[[RequestFootView alloc]init];
    self.footView.frame =CGRectMake(0, 0, SCREEN_WIDTH, PROPORTION_HIGHT(300));
    self.requestTabView.tableFooterView=self.footView;

}
#pragma mark - UITextViewDelegate
-(void)textViewDelegate{
    
    self.footView.contentTextView.text=@"例如：1.工时不足";
     self.footView.contentTextView.delegate=self;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"例如：1.工时不足";
        
        textView.textColor = textColorPlace;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"例如：1.工时不足"]){
        textView.text=@"";
        
        textView.textColor=[UIColor blackColor];
    }
    
}
#pragma mark------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RequestCell*cell=[self.requestTabView dequeueReusableCellWithIdentifier:requestCellID];
    cell.leftLa.text =self.dataArray[indexPath.row];
    if ([cell.rightLa.text isEqualToString:@"去选择"]) {
        cell.rightLa.textColor =textBlueColor;
    }else{
    cell.rightLa.textColor =textCententColor;
    
    }

    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [self selectBanci];
    } else if(indexPath.row==1) {
        [self selectTime];
    }else if (indexPath.row==2){
    
      [self selectPeople];
    
    }

}
#pragma mark ------pickViewDelegate----------
-(void)selectBanci{
   // self.pickArray=self.banciID;
    self.pickArray=self.banciArray;

    [self creatPickView:@"选择班次"];

}

-(void)selectPeople{
    SelectPeopleViewController*selectVC=[[SelectPeopleViewController alloc]init];
    selectVC.userIdDelegate=self;
    [self.navigationController pushViewController:selectVC animated:YES];
}
-(void)passUserId:(NSString *)userId userName:(NSString *)username{
    self.userid =userId;
    NSIndexPath*index=[self.requestTabView indexPathForSelectedRow];
    RequestCell*cell=[self.requestTabView cellForRowAtIndexPath:index];
    cell.rightLa.text=username;
    cell.rightLa.textColor =textCententColor;
    [self.requestTabView reloadData];

}
-(void)selectTime{
    self.pickArray=(NSMutableArray*)@[@"1",@"2",@"3",@"4",@"5"];
    [self creatPickView:@"选择天数"];

}
#pragma mark --pickviewDelegate -------pickview------

//pickViewdelegate
-(void)creatPickView:(NSString*)title {
    self.bgView=[[UIView alloc]initWithFrame:UIScreenBpunds];
    self.bgView.backgroundColor = popBGColore;
    [self.view addSubview:self.bgView];
    self.bgView.userInteractionEnabled = YES;
    
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT((self.pickArray.count+2)*45)+30);
    bgView.backgroundColor=[UIColor whiteColor];
    [self.bgView addSubview:bgView];
    
    UIImageView*titleBg=[[UIImageView alloc]init];
    titleBg.frame = CGRectMake(0, 0, bgView.width,  STANDARD_HEIGHT);
    titleBg.image =[UIImage imageNamed:@"nabackgroundImage.png"];
    [bgView addSubview:titleBg];
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:titleBg.bounds];
    titleLabel.text =  title;
    titleLabel.textAlignment =NSTextAlignmentCenter;
    titleLabel.textColor =  [UIColor whiteColor];
    [bgView addSubview: titleLabel];
    
    self.pickView=[[UIPickerView alloc]init];
    self.pickView.frame = CGRectMake(0, CGRectGetMaxY(titleBg.frame), bgView.width, PROPORTION_HIGHT(45*self.pickArray.count));
    [bgView addSubview:self.pickView];
    self.pickView.delegate =self;
    self.pickView.dataSource = self;
    self.pickView.userInteractionEnabled = YES;
    self.bgView.hidden = NO;
    
    UIButton* XueLibackBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    XueLibackBtn.frame = CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(self.pickView.frame)+10, (bgView.width-PROPORTION_WIDTH(10)*2-10)/2, STANDARD_HEIGHT);
    KUIbutton( XueLibackBtn);
    KUIbuttonClick(XueLibackBtn);
    [ XueLibackBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [bgView addSubview: XueLibackBtn];
    
    UIButton* XueLidoneBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    XueLidoneBtn.frame=CGRectMake(CGRectGetMaxX( XueLibackBtn.frame)+10,  XueLibackBtn.y,  XueLibackBtn.width,  XueLibackBtn.height);
    KUIbutton(XueLidoneBtn);
    KUIbuttonClick(XueLidoneBtn);
    [XueLidoneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [bgView addSubview:XueLidoneBtn];
    
    
    [XueLibackBtn addTarget:self action:@selector(xueliBackAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [XueLidoneBtn addTarget:self action:@selector(xueliDoneAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)xueliBackAction:(UIButton*)sender{
    
    self.bgView.hidden = YES;
    
}
-(void)xueliDoneAction:(UIButton*)sender{
    
    self.bgView.hidden = YES;
    [self.requestTabView reloadData];
}
#pragma mark UIPickerView Delegate Method 代理方法
//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;//第一个展示字母、第二个展示数字
}
//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    return self.pickArray.count;
}

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title = nil;
    title = self.pickArray[row];
    
    if ([[self.pickArray firstObject] isEqualToString:@"1"]) {
        self.selectDaysStr=title;
    } else {
        self.selectBanciStr=title;
    }
    
    NSIndexPath *indexPath = [self.requestTabView indexPathForSelectedRow];
    RequestCell *cell = [self.requestTabView cellForRowAtIndexPath: indexPath];
    cell.rightLa.text = self.pickArray[row];
    
    cell.rightLa.textColor= textCententColor;
    
    return title;
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
