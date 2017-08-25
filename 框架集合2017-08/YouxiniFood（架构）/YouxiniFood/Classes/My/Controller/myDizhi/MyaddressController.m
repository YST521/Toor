//
//  MyaddressController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/28.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyaddressController.h"
#import "AddAddressController.h"
#import "MiaddressCell.h"

@interface MyaddressController ()<UITableViewDelegate,UITableViewDataSource,CellDelegate>
@property(nonatomic,strong)UITableView *addressTabview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

static NSString * adadressCellID = @"adadressCellID";
@implementation MyaddressController

-(NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];;
    [self creatData];
    [self creatNaItem];
    [self creatUI];
}

- (void)creatData{
    _dataArray = (NSMutableArray*)@[@[@"张三",@"1352569545",@"广东省东莞市南城区车站路优信通信大厦2楼研发中心",@"1"],@[@"张三",@"1352569545",@"广东省东莞市南城区车站路优信通信大厦2楼研发中心",@"0"],@[@"张三",@"1352569545",@"广东省东莞市南城区车站路优信通信大厦2楼研发中心",@"0"]];

}

-(void) creatNaItem{
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"+" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarItemAction:)];
    
}

-(void)creatUI{
    
    self.addressTabview =[[UITableView alloc]initWithFrame:CGRectMake(0, 10, SceneWidth, SceneHeight-10) style:(UITableViewStylePlain)];
    [self.view addSubview:self.addressTabview];
    
    self.addressTabview.dataSource = self;
    self.addressTabview.delegate   =  self;
    self.addressTabview.backgroundColor =[UIColor groupTableViewBackgroundColor ];
    [self.addressTabview registerClass:[MiaddressCell class] forCellReuseIdentifier:adadressCellID];
 self.addressTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.addressTabview.backgroundColor = BgColor;
//    self.addressTabview.contentInset = UIEdgeInsetsMake(+10, 0, 0, 0);
    UIView *footV =[[UIView alloc]init];
    footV.backgroundColor = [UIColor groupTableViewBackgroundColor];;
    footV.frame = CGRectMake(0, 0, SceneWidth, 20);
    self.addressTabview.tableFooterView = footV;
}

#pragma mark ---------------ClickAction-----------------

- (void)rightBarItemAction:(UIBarButtonItem*)sender{

    AddAddressController *addaddressVC =[[AddAddressController alloc]init];
    [self.navigationController pushViewController:addaddressVC animated:YES];
    
}

#pragma mark --------------tabvireDelegate--------------


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  MiaddressCell *cell =[self.addressTabview dequeueReusableCellWithIdentifier:adadressCellID];
    
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.myDizhidelegate = self;
    
    for (NSArray *aa in self.dataArray) {
        
        cell.nameLa.text = aa[0];
        cell.phoneNumLa.text = aa[1];
        cell.addressLa.text = aa[2];
        
//        if (indexPath.row == 0) {
//             [cell.defauitBtn setImage:[UIImage imageNamed:@"21_bg_xuanzhong"] forState:(UIControlStateNormal)];
//        } else {
//                       [cell.defauitBtn setImage:[UIImage imageNamed:@"icon_guanyuwomen"] forState:(UIControlStateNormal)];
//        }
      
    }
//    cell.defauitBtn.tag  = 300+indexPath.row;
//    cell.delegateBtn.tag = 400 + indexPath.row;
//    cell.changeBtn.tag   = 500 +indexPath.row;
//    
//    [cell.defauitBtn addTarget:self action:@selector(selectDefaultBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    return cell;
}

-(void)defaultButtonDidSelected:(UIButton *)button{
    
    self.addressTabview.backgroundColor = RandomColor;
//    UIButton* btn = (UIButton*) button;
    MiaddressCell *cell = (MiaddressCell*)button.superview.superview;
   NSIndexPath *indexPath = [self.addressTabview indexPathForCell:cell];
    
//    [self.dataArray removeObjectAtIndex:1];
//    [self.addressTabview reloadData];
    
    NSLog(@"**%lu",(unsigned long)self.dataArray.count);
    
}
//修改
-(void)editBtnAction:(UIButton *)sender{
    MiaddressCell *cell = (MiaddressCell*)sender.superview.superview;
    NSIndexPath *indexPath = [self.addressTabview indexPathForCell:cell];
    
    AddAddressController *editVC =[[AddAddressController alloc]init];
    editVC.adressArray = self.dataArray[indexPath.row];
    editVC.isEdit = YES;
    [self.navigationController pushViewController:editVC animated:YES];
}

//删除
-(void)delectBtnAction:(UIButton *)sender{


}

- (void)selectDefaultBtnAction:(UIButton*)sender{
    
    sender.selected=!sender.selected;
    
    UIButton* button = (UIButton*) sender;
   MiaddressCell *cell = (MiaddressCell*)button.superview.superview;
    NSIndexPath *indexPath = [self.addressTabview indexPathForCell:cell];
    
    
    NSLog(@"****%ld",(long)indexPath.row);
    
      [cell.defauitBtn setImage:[UIImage imageNamed:@"21_bg_xuanzhong"] forState:(UIControlStateNormal)];
    
    
  
    //取到 button所在的cell的indexPath
//    NSSet *touches =[event allTouches];
//    UITouch *touch =[touches anyObject];
//    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
//    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
//    if (indexPath != nil)
//    {
//        //do something
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
