
//

#import "PublicTableViewController.h"
#import "PublicCell.h"
#import "PublicWeiboViewModel.h"

@interface PublicTableViewController ()
@property (strong, nonatomic) NSArray *publicModelArray;
@end

@implementation PublicTableViewController
#pragma mark - lift cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewModel];
    
    //http://www.cocoachina.com/ios/20150122/10987.html
    
    [self.tableView registerClass:[PublicCell class] forCellReuseIdentifier:@"cell"];
    
//    CAGradientLayer *grad = [CAGradientLayer layer];
//    grad.frame = self.tableView.bounds;
//
//    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:256.0f/255.0f green:50.0f/255.0f blue:51.0f/255.0f alpha:1.0f] CGColor], (id)[[UIColor colorWithRed:35.0f/255.0f green:34.0f/255.0f blue:34.0f/255.0f alpha:1.0f] CGColor], nil];
//    

    
    CAGradientLayer *selectedGrad = [CAGradientLayer layer];
   selectedGrad.frame = self.tableView.bounds;
//      selectedGrad.frame = CGRectMake(0, 0, 414, 736*3);
    selectedGrad.colors = [NSArray arrayWithObjects:(id)[[UIColor greenColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    
    //    [cell setSelectedBackgroundView:[[UIView alloc] init]];
    //    [cell.selectedBackgroundView.layer insertSublayer:selectedGrad atIndex:0];
    
    
    [self.tableView.layer insertSublayer:selectedGrad atIndex:0];
    
    //MVVM 思想双向绑定 将VC里面的数据请求逻辑放在viewModel里面 MVC  -> m vm v
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - config

/**
 创建ViewModel
 */
- (void)createViewModel {
    
    PublicWeiboViewModel *publicViewModel = [[PublicWeiboViewModel alloc] init];

    [publicViewModel setBlockWithReturnBlock:^(id returnValue) {
        [SVProgressHUD dismiss];
        _publicModelArray = returnValue;
        [self.tableView reloadData];
        DDLog(@"%@",_publicModelArray);
        
    } WithErrorBlock:^(id errorCode) {
        [SVProgressHUD dismiss];
    } WithFailureBlock:^{
        [SVProgressHUD dismiss];
    }];
    
 
    
    [publicViewModel fetchPublicWeiBo];
    [SVProgressHUD showWithStatus:@"正在获取用户信息……" maskType:SVProgressHUDMaskTypeBlack];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _publicModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PublicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    
    [cell setValueWithDic:_publicModelArray[indexPath.row]];
    
    
    //cell渐变色
    
    [cell setBackgroundColor:[UIColor clearColor]];
//    
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = cell.bounds;
    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:256.0f/255.0f green:50.0f/255.0f blue:51.0f/255.0f alpha:1.0f] CGColor], (id)[[UIColor colorWithRed:35.0f/255.0f green:34.0f/255.0f blue:34.0f/255.0f alpha:1.0f] CGColor], nil];
    
    [cell setBackgroundView:[[UIView alloc] init]];
    [cell.backgroundView.layer insertSublayer:grad atIndex:0];
    
    CAGradientLayer *selectedGrad = [CAGradientLayer layer];
    selectedGrad.frame = cell.bounds;
    selectedGrad.colors = [NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    
    [cell setSelectedBackgroundView:[[UIView alloc] init]];
    [cell.selectedBackgroundView.layer insertSublayer:selectedGrad atIndex:0];
    
    
//        [tableView.layer insertSublayer:selectedGrad atIndex:0];

    
    return cell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublicModel *model = (PublicModel *)_publicModelArray[indexPath.row];
    return model.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   PublicWeiboViewModel *publicViewModel = [[PublicWeiboViewModel alloc] init];
    [publicViewModel weiboDetailWithPublicModel:_publicModelArray[indexPath.row] WithViewController:self];
}


@end
