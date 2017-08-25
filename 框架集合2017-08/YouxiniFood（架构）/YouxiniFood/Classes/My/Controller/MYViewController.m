//
//  MYViewController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/26.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MYViewController.h"
#import "MyCollectionViewCell.h"
#import "MyControllerheadView.h"
#import "MyAdminViewController.h"
#import "MyfankaController.h"
#import "MyqianbaoController.h"
#import "MyaddressController.h"
#import "MyfuliquanController.h"
#import "MyChongzhiViewController.h"
#import "MyPassWordController.h"
#import "MyshoufuController.h"
#import "MyOrdelController.h"
#import "MyUserMessageController.h"
#import "MyBankCardController.h"
#import "MyZhifumimaController.h"
#import "ServeCenterController.h"
#import "AboutUsController.h"
#import "ZYQAssetPickerController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "TestWebViewController.h" //测试
#import "LoginViewController.h"
#import "MainNavigationController.h"




@interface MYViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,myCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate>{
NSData *imgData;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView       *NavView;
@property(nonatomic,strong)MyControllerheadView *headView;

@property(nonatomic,strong) NSArray       *cellheadTitleArray;
@property(nonatomic,strong) NSArray       *cellTitleArray;
@property(nonatomic,strong) NSArray       *cellImageArray;
@property(nonatomic,strong) NSArray       *cellSquareColor;

@property(nonatomic,assign) BOOL          isPop;

@end

static NSString *myCellid =@"mycollectCellID";
@implementation MYViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = YES;
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"naImage.png"] forBarMetrics:UIBarMetricsDefault];
   
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //title 设为 透明色
     NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17];
        dict[NSForegroundColorAttributeName] = [UIColor clearColor];
        [self.navigationController.navigationBar setTitleTextAttributes:dict];
    
//     self.navigationController.extendedLayoutIncludesOpaqueBars = YES;
}



- (void)viewWillDisappear:(BOOL)animated{
    
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
  
     self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
//    [self initView];
    
//    [self initScrollView];
//
    [self creatData];
    [self setNav];
    [self creatCollectView];
  
}

- (void)creatData{
    //cell数据
    self.cellheadTitleArray = @[@"我的订单",@"我的福利",@"卡包管理",@"更多设置"];
    self.cellTitleArray = @[@[@"订单",@"地址管理"],@[@"福利券",@"充值有奖"],@[@"银行卡",@"支付密码"],@[@"客服中心",@"修改密码",@"关于我们",@"退出登录"]];
     self.cellSquareColor = @[SquareColorCyan,SquareColorYellow,SquareColorOrange,SquareColorGray];
    self.cellImageArray = @[@[@"icon_dingdan",@"icon_dizhiguangli"],@[@"icon_fulijuan",@"icon_chongzhiyoujinag"],@[@"icon_yinghangkaguangli",@"icon_zhifumimaguanli"],@[@"icon_kefuzhongxin",@"icon_xiugaimima",@"icon_guanyuwomen",@"icon_tuichudenglu"]];
}

- (void)creatCollectView{
    
   

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight-49) collectionViewLayout:layout];
     self.collectView.delegate = self;
     self.collectView.dataSource = self;
     self.collectView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [ self.collectView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:myCellid];
    [self.view addSubview: self.collectView];
    
    self.headView =[[MyControllerheadView alloc]init];
     self.headView.frame =CGRectMake(0, -281, SceneWidth, 281);
    self.collectView.contentInset = UIEdgeInsetsMake(281, 0, 0, 0);
    
    [self.collectView addSubview: self.headView];
    
    //管理 btn
    [self.headView.adminBtn addTarget:self action:@selector(adminBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //饭卡 钱包 收付款 点击事件
    [self.headView.fankaBtn addTarget:self action:@selector(fankaYueBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
     [self.headView.qianbaoBtn addTarget:self action:@selector(qianbaoBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
     [self.headView.shouFunBtn addTarget:self action:@selector(shoufukuanBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //头像
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUserImageTapAcxtion:)];
    self.headView.userIamgeView.userInteractionEnabled = YES;
    [self.headView.userIamgeView addGestureRecognizer:tap];
    
    //个人信息
    UITapGestureRecognizer *userMessagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userMessageTapAction:)];
    self.headView.userInteractionEnabled = YES;
    [self.headView addGestureRecognizer:userMessagetap];
    
}


- (void)userMessageTapAction:(UITapGestureRecognizer*)tap{

    MyUserMessageController *userMessage =[[MyUserMessageController alloc]init];
    userMessage.title = @"个人资料";
    [self.navigationController pushViewController:userMessage animated:YES];
}


-(void)changeUserImageTapAcxtion:(UITapGestureRecognizer*)sender{
    
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册获取", nil];
    [as showInView:self.view];

}

-(void)adminBtnClickAction:(UIButton*)btn{

//    MyAdminViewController *vc = [MyAdminViewController new];
//    vc.title = @"管理";
//    [self.navigationController pushViewController:vc animated:YES];
    TestWebViewController *vc = [TestWebViewController new];

    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)fankaYueBtnClickAction:(UIButton*)btn{

    MyfankaController *fankaVC =[[MyfankaController alloc]init];
    fankaVC.title = @"饭卡消费账单";
    [self.navigationController pushViewController:fankaVC animated:YES];
}

- (void)qianbaoBtnClickAction:(UIButton*)btn{
    
    MyqianbaoController *qianbaoVC =[[MyqianbaoController alloc]init];
    qianbaoVC.title = @"我的钱包";
    [self.navigationController pushViewController:qianbaoVC animated:YES];
}

- (void)shoufukuanBtnClickAction:(UIButton*)btn{
    
    MyshoufuController *shoufuKaunVC =[[MyshoufuController alloc]init];
    shoufuKaunVC.title = @"收付款";
    [self.navigationController pushViewController:shoufuKaunVC animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cellheadTitleArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:myCellid forIndexPath:indexPath];
    
    cell.section = indexPath.row;
    cell.squareColor = self.cellSquareColor[indexPath.row];
    cell.iconArr = self.cellImageArray[indexPath.row];
    cell.title = self.cellheadTitleArray[indexPath.row];
    cell.contentArr =self.cellTitleArray[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (SceneWidth -40)/4*0.8;
    if ([self.cellTitleArray[indexPath.row] count]%4) {
        NSInteger row = [self.cellTitleArray[indexPath.row] count]/4 +1;
        return CGSizeMake(SceneWidth-20, width*row+55);
    }else{
        NSInteger row = [self.cellTitleArray[indexPath.row] count]/4 ;
        return CGSizeMake(SceneWidth-20, width*row+55);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)wiseLifeDidSelectRow:(NSInteger)row andSection:(NSInteger)section{
    

    if (section == 0 && row == 0) {
        MyOrdelController *vc = [MyOrdelController new];
        vc.title = self.cellTitleArray[section][row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (section == 0 && row == 1) {
        MyaddressController *vc = [MyaddressController new];
        vc.title = self.cellTitleArray[section][row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (section == 1 && row == 0) {
        MyfuliquanController *vc = [ MyfuliquanController new];
        vc.title = self.cellTitleArray[section][row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (section == 1 && row == 1) {
        MyChongzhiViewController *vc = [[MyChongzhiViewController alloc]init];
        vc.title = self.cellTitleArray[section][row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    //卡包
    if (section == 2 && row == 0) {
        MyBankCardController *vc = [[MyBankCardController alloc]init];
        vc.title = self.cellTitleArray[section][row];
        [self.navigationController pushViewController:vc animated:YES];
    }

    if (section == 2 && row == 1) {
        MyZhifumimaController *vc = [[MyZhifumimaController alloc]init];
        vc.title = self.cellTitleArray[section][row];
        [self.navigationController pushViewController:vc animated:YES];
    }

    if (section == 3 && row == 0) {
        
        ServeCenterController *vc = [[  ServeCenterController alloc]init];
        vc.title = self.cellTitleArray[section][row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (section == 3 && row == 1) {
        MyPassWordController *vc = [[ MyPassWordController alloc]init];
        vc.title = self.cellTitleArray[section][row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    if (section == 3 && row == 2) {
        
        AboutUsController *vc = [[AboutUsController alloc]init];
        vc.title = self.cellTitleArray[section][row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    

    
    if (section == 3 && row == 3) {
        NSUserDefaults  *userDefault =  [NSUserDefaults standardUserDefaults];
        [userDefault removeObjectForKey:@"iFoodPassword"];
        [userDefault removeObjectForKey:CacheSessionID];
        [userDefault synchronize];
        
        LoginViewController*loginVC = [[LoginViewController alloc]init];
        MainNavigationController*na=[[MainNavigationController alloc]initWithRootViewController:loginVC];
        [UIApplication sharedApplication].keyWindow.rootViewController = na;
    }
    

}




-(void)setNav {
    self.NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SceneWidth, 64)];
    self.NavView.backgroundColor = GoldColor;
//      self.NavView.backgroundColor =  [UIColor whiteColor];
    self.NavView.backgroundColor = [self.NavView.backgroundColor colorWithAlphaComponent:0];
    [self.view addSubview:self.NavView];
//    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SceneWidth, 40)];
//    lab.textAlignment = NSTextAlignmentCenter;
//    lab.text = @"我的";
//    lab.textColor = [UIColor blackColor];
//    [self.NavView addSubview:lab];
//   
    
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            
            imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                      (NSString*)kUTTypeImage,
                                      nil];
            imagePicker.videoMaximumDuration = 30;
            
            [imagePicker setDelegate:self];
            
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持拍照" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } else if (buttonIndex == 1) {
        NSLog(@"从手机相册选择");
        
        ZYQAssetPickerController *assetPicker = [[ZYQAssetPickerController alloc] init];
        //最多可选张数
        assetPicker.maximumNumberOfSelection = 1;
        assetPicker.assetsFilter = [ALAssetsFilter allPhotos];
        assetPicker.showEmptyGroups=NO;
        assetPicker.delegate = self;
        assetPicker.showCancelButton = YES;
        assetPicker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
                //                NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                //                return duration >= 5;
                return NO;
            } else {
                return YES;
            }
        }];
        
        [self presentViewController:assetPicker animated:YES completion:^{
            
        }];
        
    }
}

#pragma mark - UIImagePickerControllerDelegate 图片选择完成

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断是静态图像还是视频
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage  * chosedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        UIImage *newImage = [self scaleImage:chosedImage toWidth:chosedImage.size.width/2 toHeight:chosedImage.size.height/2];
        //相机拍摄图片
          self.headView.userIamgeView.image = newImage;
//        [self showLoadView];
        
//        WeakSelf;
//        [APIHelper requestWithUrl:@"/rest/v1/pyqquanzi/replaceUserHeadImage" pramas:nil imageData:imgData fileName:@"headimage" className:nil afCompletionBlock:^(BaseApiResult *result) {
//            [this closeLoadView];
//            
//            if (result.rspResult == 1) {
//                ivHead.image = newImage;
//                
//            } else {
//                [this showTipInfo:result.message];
//            }
//        }];
//        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

/**
 * 压缩图片的方法
 */
-(UIImage *)scaleImage:(UIImage *)image toWidth:(int)toWidth toHeight:(int)toHeight{
    //    int width=0;
    //    int height=0;
    //    int x=0;
    //    int y=0;
    //
    //    if (image.size.width<toWidth){
    //        width = toWidth;
    //        height = image.size.height*(toWidth/image.size.width);
    //        y = (height - toHeight)/2;
    //    }else if (image.size.height<toHeight){
    //        height = toHeight;
    //        width = image.size.width*(toHeight/image.size.height);
    //        x = (width - toWidth)/2;
    //    }else if (image.size.width>toWidth){
    //        width = toWidth;
    //        height = image.size.height*(toWidth/image.size.width);
    //        y = (height - toHeight)/2;
    //    }else if (image.size.height>toHeight){
    //        height = toHeight;
    //        width = image.size.width*(toHeight/image.size.height);
    //        x = (width - toWidth)/2;
    //    }else{
    //        height = toHeight;
    //        width = toWidth;
    //    }
    //
    //    CGSize size = CGSizeMake(width, height);
    //    UIGraphicsBeginImageContext(size);
    //    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //    image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //
    //    CGSize subImageSize = CGSizeMake(toWidth, toHeight);
    //    CGRect subImageRect = CGRectMake(x, y, toWidth, toHeight);
    //    CGImageRef imageRef = image.CGImage;
    //    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
    //    UIGraphicsBeginImageContext(subImageSize);
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextDrawImage(context, subImageRect, subImageRef);
    //    UIImage* subImage = [UIImage imageWithCGImage:subImageRef];
    //    CGImageRelease(subImageRef);
    //    UIGraphicsEndImageContext();
    //
    //    NSData *fData = UIImageJPEGRepresentation(subImage, 0.5);
    //    imgData = fData;
    //    subImage = [[UIImage alloc] initWithData:fData];
    //
    //    return subImage;
    
    
    NSData *fData = UIImageJPEGRepresentation(image, 0.5);
    imgData = fData;
    if (imgData.length > 30*1024) {
        int width = image.size.width / 4;
        int height = image.size.height / 4;
        int x=0;
        int y=0;
        
        CGSize size = CGSizeMake(width, height);
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGSize subImageSize = CGSizeMake(toWidth, toHeight);
        CGRect subImageRect = CGRectMake(x, y, toWidth, toHeight);
        CGImageRef imageRef = image.CGImage;
        CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
        UIGraphicsBeginImageContext(subImageSize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, subImageRect, subImageRef);
        UIImage* subImage = [UIImage imageWithCGImage:subImageRef];
        CGImageRelease(subImageRef);
        UIGraphicsEndImageContext();
        
        fData = UIImageJPEGRepresentation(subImage, 0.5);
//        imgData = fData;
        subImage = [[UIImage alloc] initWithData:fData];
        
        return subImage;
    }
    image = [[UIImage alloc] initWithData:fData];
    
    return image;
}


#pragma mark - ZYQAssetPickerControllerDelegate

-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    if (assets.count > 0) {
        
        ALAsset *asset=assets[0];
        
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        
        UIImage *newImage = [self scaleImage:tempImg toWidth:tempImg.size.width/2 toHeight:tempImg.size.height/2];
        //相册选取图片
        self.headView.userIamgeView.image = newImage;
        
//        WeakSelf;
//        [APIHelper requestWithUrl:@"/rest/v1/pyqquanzi/replaceUserHeadImage" pramas:nil imageData:imgData fileName:@"headimage" className:nil afCompletionBlock:^(BaseApiResult *result) {
//            [this closeLoadView];
//            
//            if (result.rspResult == 1) {
//                ivHead.image = newImage;
//             
//                if ([result.data isKindOfClass:[NSDictionary class]]) {
//                    [[AppData shareInstance].personCell setPyqData:result.data];
//                }
//            } else {
//                [this showTipInfo:result.message];
//            }
//        }];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        newImage = nil;
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

-(void)assetPickerController:(ZYQAssetPickerController *)picker didSelectAsset:(ALAsset*)asset
{

    
}

-(void)assetPickerController:(ZYQAssetPickerController *)picker didDeselectAsset:(ALAsset*)asset
{
    
}

-(void)assetPickerControllerDidCancel:(ZYQAssetPickerController *)picker
{
}



//-(void)initScrollView {
//    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -50, SceneWidth, 50)];
//    self.scrollView.backgroundColor = GoldColor;
//    [self.scrollView setContentOffset:CGPointMake(SceneWidth, 0)];
//    self.scrollView.delegate = self;
//    self.scrollView.showsVerticalScrollIndicator = NO;
//    [self.tableView addSubview:self.scrollView];
//    
//}
-(void)initView {
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight+40) style:UITableViewStyleGrouped];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    self.tableView.showsVerticalScrollIndicator = NO;
    //self.tableView.tableHeaderView = self.scrollView;
//    [self.view addSubview:self.tableView];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        CGFloat offsetY = self.tableView.contentOffset.y;
        if (offsetY <= 0 && offsetY >= -100) {
            self.scrollView.frame = CGRectMake(0, -50 + offsetY / 2, SceneWidth, 220 - offsetY / 2);
            self.NavView.backgroundColor = [self.NavView.backgroundColor colorWithAlphaComponent:0];
            
        }
        else if (offsetY < -100) {
            [self.tableView setContentOffset:CGPointMake(0, -100)];
        }
        else if (offsetY > 0) {
            
            self.NavView.backgroundColor = [self.NavView.backgroundColor colorWithAlphaComponent:offsetY / 120];
            self.scrollView.frame = CGRectMake(0, -50 + offsetY / 2, SceneWidth, 220 - offsetY / 2);
            
        }
    }
}
//
//
//#pragma mark - tableview
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 5;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 50;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if(section == 0) {
//        return 180;
//    }else {
//        return 3;
//    }
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *CEllID = @"tangshuo";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CEllID];
//    if(cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CEllID];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
//    return cell;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
