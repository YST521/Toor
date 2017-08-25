//
//  BaoGangSelectGangweiViewController.m
//  WiseAPP
//
//  Created by app on 16/11/3.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaoGangSelectGangweiViewController.h"
#import "SelectgangweiTableViewCell.h"
#import "GangweiSetModel.h"

@interface BaoGangSelectGangweiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* selectGangweiTableView;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)NSString* pointName;
@property(nonatomic,assign)int pointID;
@property(nonatomic,strong)NSMutableArray* pointArray;

@end
static NSString* selectCell=@"selectCell";
@implementation BaoGangSelectGangweiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    [self addData];
    [self addView];
    
}
-(void)addData{
    self.pointArray =[NSMutableArray array];
    self.dataArray=[NSMutableArray array];
    
    //get gangwei data

        self.dataArray=[NSMutableArray array];
        NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
        NSDictionary*parm = @{@"projectid":ID};
        [RequestManger GetWithUrl:[self urlRequestChildreurl:@"postList"] Token:self.tokenString parmpar:parm succeed:^(id data) {
            for (NSDictionary*dic in data[@"resultMessage"]) {
                GangweiSetModel*model=[GangweiSetModel new];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
               NSLog(@"GGGG%@",data);
            [self.selectGangweiTableView reloadData];
            
            
        } failure:^(NSError *error) {
            
        }];
    
}

-(void)addView{
    
    self.selectGangweiTableView=[[UITableView alloc]initWithFrame:UIScreenBpunds style:(UITableViewStylePlain)];
    [self.view addSubview:self.selectGangweiTableView];
    self.selectGangweiTableView.dataSource =self;
    self.selectGangweiTableView.delegate = self;
    [self.selectGangweiTableView registerClass:[SelectgangweiTableViewCell class] forCellReuseIdentifier: selectCell];
    
}

-(void)saveAction:(UIButton*)sender{
    NSLog(@"pppppp%@",self.pointArray);
    
    [self.pointArray addObject:[NSString stringWithFormat:@"%d",self.pointID]];
      [self.pointArray addObject:[NSString stringWithFormat:@"%@",self.pointName]];
//    if (self.pointArray.count >1) {
//        [self AlerVCtitleString:@"提示" messageString:@"每次只能给一个岗位，设置报岗时间" doneString:@"确定"];
//    } else {
    self.pointIdStr( [NSString stringWithFormat:@"%d",self.pointID],self.pointName);
    //}

    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark --------tableviewDelegate-----

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectgangweiTableViewCell *cell=[self.selectGangweiTableView dequeueReusableCellWithIdentifier:selectCell];
//    if (!cell) {
//        cell=[[SelectgangweiTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:selectCell];
//    }
    
    GangweiSetModel*model=self.dataArray[indexPath.row];
    cell.selectLa.text =model.post;
    self.selectGangweiTableView.tableFooterView =[[UIView alloc]init];
    [cell.selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.selectBtn.tag = 2000+indexPath.row;
    return  cell;

}
-(void)selectBtnAction:(UIButton*)sender{
    sender.selected = !sender.selected;

    GangweiSetModel*model =self.dataArray [sender.tag -2000];
    if (sender.selected == YES) {
        
        self.pointID = model.gangweiID;
     
        self.pointName= model.post;
     
        [self.pointArray  addObject: @(model.gangweiID)];

       
    }else{
        self.pointID =1;
         self.pointName=@"1";
         [self.pointArray  removeObject: @(model.gangweiID)];
    }
   [self.selectGangweiTableView reloadData];
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
