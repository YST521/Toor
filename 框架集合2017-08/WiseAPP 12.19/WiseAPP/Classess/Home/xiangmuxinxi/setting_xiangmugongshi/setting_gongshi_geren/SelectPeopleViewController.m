//
//  SelectPeopleViewController.m
//  WiseAPP
//
//  Created by app on 16/12/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "SelectPeopleViewController.h"
#import "UserModel.h"
#import "RequestSelectPeopleCell.h"

@interface SelectPeopleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tabview;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSString* selectPeopleID;
@property(nonatomic,assign)int userID;
@property(nonatomic,assign)NSString* userName;
@end

@implementation SelectPeopleViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addData];
    [self addView];
    self.navigationItem.title =@"选择人员";
     self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
}
-(void)saveAction:(UIBarButtonItem*)sender{

    [self.userIdDelegate passUserId:[NSString stringWithFormat:@"%d",self.userID] userName:self.userName];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)addData{
 
        NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
        NSMutableDictionary*parm=[NSMutableDictionary dictionary];
        [parm setObject:ID forKey:@"projectid"];
        NSString*time=[NSString stringWithFormat:@"%ld-%ld-%ld",(long)self.year,(long)self.month,(long)self.days];
        [parm setObject:time forKey:@"date"];
        
        [RequestManger GetWithUrl:[self urlRequestChildreurl:@"personalHours/UserList"] Token:self.tokenString parmpar:parm succeed:^(id data) {
            
        
     
                for (NSDictionary*dic in data[@"resultMessage"]) {
                        UserModel*model=[UserModel new];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.dataArray addObject:model];
                }
             
            
            NSLog(@"%@",data);
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [self.tabview reloadData];
                if (self.dataArray==0) {
                    [self AlerVCtitleString:@"提示" messageString:@"暂无员工，请添加员工" doneString:@"确定"];
                }
                
            });
            
            
        } failure:^(NSError *error) {
            
        }];

}

-(void)addView{
    self.tabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:(UITableViewStylePlain)];
    [self.view addSubview:self.tabview];
    self.tabview.dataSource=self;
    self.tabview.delegate=self;
    [self.tabview registerClass:[RequestSelectPeopleCell class] forCellReuseIdentifier:@"gongshicell"];


}
#pragma mark------tabviewdelegate------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     RequestSelectPeopleCell*cell=[self.tabview dequeueReusableCellWithIdentifier:@"gongshicell"];
    self.tabview.backgroundColor =GlobBackGroundColor;
    
    UserModel*model=self.dataArray[indexPath.row];
    cell.peopleNameLa.text =model.name;
    self.tabview.tableFooterView =[[UIView alloc]init];
    
    cell.leftBtn.tag = 1700+indexPath.row;
    [cell.leftBtn addTarget:self action:@selector(leftBtnAction:event:) forControlEvents:(UIControlEventTouchUpInside)];
    return  cell;
}


-(void)leftBtnAction:(UIButton*)sender event:(id)event{
      sender.selected = !sender.selected;

    if (sender.selected == YES) {
        NSSet * touches =[event allTouches];
        UITouch * touch =[touches anyObject];
        CGPoint currentTouchPosition = [touch locationInView:self.tabview];
        NSIndexPath * indexPath = [self.tabview indexPathForRowAtPoint:currentTouchPosition];
        
        if (indexPath!= nil) {
   UserModel*model=self.dataArray[indexPath.row];
  self.userID=model.userID;
            self.userName= model.name;
    
    }else{
   
    self.userID = 0;
   
    }
    
    [self.tabview reloadData];
    

    

}
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 UserModel*model=self.dataArray[indexPath.row];
    self.selectPeopleID =[NSString stringWithFormat:@"%d",model.userID];
 
   
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
