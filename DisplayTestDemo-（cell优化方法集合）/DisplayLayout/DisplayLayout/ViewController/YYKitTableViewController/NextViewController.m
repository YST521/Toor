//
//  NextViewController.m
//  DisplayLayout
//
//  Created by youxin on 2017/7/10.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

#import "NextViewController.h"
#import "NextTableViewCell.h"
#import "DataSupport.h"
#import "TestDataModel.h"

@interface NextViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tabview;
@property (nonatomic, strong) DataSupport *dataSupport;
@property(nonatomic,strong)UIView*headView;
@property(nonatomic,strong)UIView *hview;

// 监测范围的临界点,>0代表向上滑动多少距离,<0则是向下滑动多少距离
@property (nonatomic, assign)CGFloat threshold;
// 记录scrollView.contentInset.top
@property (nonatomic, assign)CGFloat marginTop;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self creatUI];
        [self createDataSupport];
    
}

- (void)createDataSupport {
    self.dataSupport = [[DataSupport alloc] init];
    __weak typeof (self) weak_self = self;
    [self.dataSupport setUpdataDataSourceBlock:^(NSMutableArray *dataSource) {
        weak_self.dataSource = dataSource;
        [weak_self.tabview reloadData];
    }];
    [self addTestData];
}

- (void)addTestData {
    [self.dataSupport addTestData];
}

- (void)creatUI{
    
    self.tabview =[[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.view addSubview:self.tabview];
    self.tabview.dataSource = self;
    self.tabview.delegate  = self;
    [self.tabview registerClass:[NextTableViewCell class] forCellReuseIdentifier:@"CELL"];
    self.headView = [[UIView alloc]init];
    self.headView.frame = CGRectMake(0, 0, kScreenWidth, 200);
    self.headView.backgroundColor =[UIColor greenColor];
     self.tabview.tableHeaderView = self.headView;
    
    self.hview =[[UIView alloc]init];
    self.hview.frame = CGRectMake(kScreenWidth/2-50, 50, 100, 100);
    self.hview.backgroundColor =[UIColor yellowColor];
    [ self.tabview addSubview:self.hview];
    
    // 这里设值-80，即向下滑动80，-80到0就是咱们重点监测的范围
    self.threshold = -80;
    

    
//监听tabview滑动xy    http://www.cnblogs.com/sunfuyou/p/6245145.html
//
//    if (self.tabview.screenViewY <kScreenHeight*1.5) {
//         self.tabview.tableHeaderView = self.headView;
//    } else {
//          [self.view addSubview:self.headView];
//    }


    

}

-(void)aa{

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.marginTop != scrollView.contentInset.top) {
        self.marginTop = scrollView.contentInset.top;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat newoffsetY = offsetY + self.marginTop;
    
    // 临界值150，向上拖动时变透明
    if (newoffsetY >= 5 && newoffsetY <= 50) {

        [UIView animateWithDuration:3.0 animations:^{
            self.hview.frame =self.headView.bounds;
            self.hview.backgroundColor =[UIColor yellowColor];
            self.title = @"666";
            
        }];
        
  
    }else if (newoffsetY > 50){

          [UIView animateWithDuration:3.0 animations:^{
             self.hview.frame =self.headView.bounds;
                self.hview.backgroundColor =[UIColor purpleColor];
                self.title = @"888";
               }];
    }else{

        
        self.hview.frame = CGRectMake(kScreenWidth/2-50, 50, 100, 100);
        self.hview.backgroundColor =[UIColor cyanColor];
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //缓存cell行高
    if (indexPath.row < self.dataSource.count) {
        TestDataModel *model = self.dataSource[indexPath.row];
        return model.cellHeight;
    }
    return 100;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor =[UIColor redColor];
    view.frame = CGRectMake(0, 0, kScreenWidth, 40);
    
 
    
    return view;

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   return  @"666";
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NextTableViewCell *cell =[self.tabview dequeueReusableCellWithIdentifier:@"CELL"];
    
    [cell configCellData:self.dataSource[indexPath.row]];
    
    if (indexPath.row == self.dataSource.count - 30) {
        [self addTestData];
    }

    return cell;
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
