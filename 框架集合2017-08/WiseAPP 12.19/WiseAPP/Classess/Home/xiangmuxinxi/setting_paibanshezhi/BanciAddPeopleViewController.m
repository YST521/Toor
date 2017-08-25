//
//  BanciAddPeopleViewController.m
//  WiseAPP
//
//  Created by app on 16/11/2.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BanciAddPeopleViewController.h"
#import "PaddPeopleTableViewCell.h"
#import "UserModel.h"

@interface BanciAddPeopleViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* addPeopleTabView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSString* selectUserId;
@property(nonatomic,strong)NSString* selectUserName;

@property(nonatomic,strong)NSMutableArray* selectIdArray;
@property(nonatomic,strong)NSMutableArray* selectNameArray;

@end

static NSString *addPeopleID = @"addPeopleID";
@implementation BanciAddPeopleViewController
//-(NSMutableArray *)dataArray{
//    if (_dataArray) {
//        _dataArray=[NSMutableArray array];
//    }
//
//    return _dataArray;
//}
-(NSMutableArray *)selectIdArray{
    if (!_selectIdArray) {
        _selectIdArray=[NSMutableArray array];
    }
    return _selectIdArray;
}

-(NSMutableArray *)selectNameArray{
    if (!_selectNameArray) {
        _selectNameArray=[NSMutableArray array];
    }
    return _selectNameArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    [self addData];
    [self addView];
    
}
-(void)saveAction:(UIButton*)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//get user
-(void)addData{
    self.dataArray=[NSMutableArray array];
    
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    NSMutableDictionary*parm=[NSMutableDictionary dictionary];
    [parm setObject:ID forKey:@"projectid"];
    NSString*time=[NSString stringWithFormat:@"%ld-%ld-%ld",(long)self.year,(long)self.month,(long)self.days];
    [parm setObject:time forKey:@"date"];
    
    [RequestManger GetWithUrl:[self urlRequestChildreurl:@"personalHours/UserList"] Token:self.tokenString parmpar:parm succeed:^(id data) {
               // dispatch_async(dispatch_get_main_queue(), ^{
        
                    for (NSDictionary*dic in data[@"resultMessage"]) {
                        UserModel*model=[UserModel new];
                        [model setValuesForKeysWithDictionary:dic];
                        [self.dataArray addObject:model];
                        [self.addPeopleTabView reloadData];
                    }

        
       // });
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

-(void)addView{

    self.addPeopleTabView=[[UITableView alloc]initWithFrame:UIScreenBpunds style:(UITableViewStylePlain)];
    [self.view addSubview:self.addPeopleTabView];
    self.addPeopleTabView.dataSource =self;
    self.addPeopleTabView.delegate =self;
    [self.addPeopleTabView registerClass:[PaddPeopleTableViewCell class] forCellReuseIdentifier:addPeopleID];
//    self.addPeopleTabView.userInteractionEnabled=YES;

}

#pragma mark -------tableviewDeleagte-------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PaddPeopleTableViewCell* cell=[self.addPeopleTabView dequeueReusableCellWithIdentifier:addPeopleID];
    UserModel*model=self.dataArray[indexPath.row];
    
    cell.leftLa.text = model.name;
    cell.leftLa.textColor =[UIColor grayColor];
    cell.rightLa.text = @"剩余班次";
    cell.rightLa.textColor = textColorPlace;
    cell.rightNumLa.text =@"26";
    cell.rightNumLa.font = [UIFont systemFontOfSize:12];
    cell.rightNumLa.textAlignment = NSTextAlignmentCenter;
    self.addPeopleTabView.tableFooterView=[[UIView alloc]init];
    cell.leftBtn.tag = 500+indexPath.row;
    [cell.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return  cell;
}
-(void)leftBtnAction:(UIButton*)sender{

    sender.selected = !sender.selected;
    if (sender.selected==YES) {
        UserModel*model=self.dataArray[sender.tag-500];
        NSLog(@"%d--%@",model.userID,model.username);
        self.selectUserId= [NSString stringWithFormat:@"%d",model.userID];
        self.selectUserName=model.username;
        
        [self.selectIdArray addObject:self.selectUserId];
        [self.selectNameArray addObject:model.name];
    } else {
          [self.selectIdArray  removeObject: self.selectUserId];
          [self.selectNameArray  removeObject: self.selectUserName];
       
    }

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
