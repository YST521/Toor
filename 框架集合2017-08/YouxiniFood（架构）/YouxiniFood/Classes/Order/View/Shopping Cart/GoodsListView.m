//
//  GoodsListView.m
//  MeiTuanWaiMai
//
//  Created by maxin on 16/1/6.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import "GoodsListView.h"
#import "GoodslistCell.h"
#import "OrderModel.h"
#import "ViewModel.h"
#import "CanteenViewController.h"

@implementation GoodsListView


-(instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects{

     return [self initWithFrame:frame withObjects:objects canReorder:NO];
}

-(instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects canReorder:(BOOL)reOrder{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.objects = [NSMutableArray arrayWithArray:objects];
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI
{
    self.backgroundColor = [UIColor clearColor];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gouwuche_bg"]];
    imgView.frame = CGRectMake(0, 0, self.frame.size.width, 50);
    [self addSubview:imgView];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 40)];
    lb.text = @"购物车";
    [imgView addSubview:lb];
    
    UIButton *clearbtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 80, 10, 60, 40)];
    [clearbtn setTitle:@"全部清除" forState:UIControlStateNormal];
    clearbtn .titleLabel.font = [UIFont systemFontOfSize:13];
    [clearbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [clearbtn   addTarget:self action:@selector(clickClearBtn:) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:clearbtn];
    imgView.userInteractionEnabled = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, imgView.bottom, self.frame.size.width, self.frame.size.height - 30)];
    self.tableView.bounces = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodslistCell" bundle:nil] forCellReuseIdentifier:@"GoodslistCell"];

   
}


#pragma mark - TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objects count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     return 50;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    GoodslistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodslistCell" forIndexPath:indexPath];
    OrderModel *model = [[OrderModel alloc]initWithDictionary:[self.objects objectAtIndex:indexPath.row]];
   
    [cell ListModel:model];
    cell.operationBlock=^(NSInteger number,BOOL plus){
        
        NSMutableDictionary * dic = self.objects[indexPath.row];
        //更新选中订单列表中的数量
        [dic setValue:[NSNumber numberWithInteger:number] forKey:@"orderCount"];

        NSMutableDictionary *notification = [[NSMutableDictionary alloc]init];
        [notification setValue:[NSNumber numberWithBool:plus] forKey:@"isAdd"];
        [notification setValue:dic forKey:@"update"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUI" object:self userInfo:notification];
    };
    return cell;

}

- (void)clickClearBtn:(UIButton *)sender{
    for (int i = 0; i<self.objects.count; i ++) {
        NSMutableDictionary * dic = self.objects[i];
        [dic setValue:[NSNumber numberWithInteger:0] forKey:@"orderCount"];
        NSMutableDictionary *notification = [[NSMutableDictionary alloc]init];
        [notification setValue:[NSNumber numberWithBool:NO] forKey:@"isAdd"];
        [notification setValue:dic forKey:@"update"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUI" object:self userInfo:notification];
    }
}


@end
