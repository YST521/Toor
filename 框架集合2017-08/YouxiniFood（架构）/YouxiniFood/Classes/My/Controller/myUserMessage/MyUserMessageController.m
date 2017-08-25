//
//  MyUserMessageController.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/29.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MyUserMessageController.h"
#import "UserMessageCell.h"
#import "UserMessageImageCell.h"
#import "ZYQAssetPickerController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "BindFankaController.h"
#import "EditGenderController.h"
#import "EdituserMessageController.h"


@interface MyUserMessageController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate>{
    NSData *imgData;
}


@property (nonatomic,strong) UITableView     *tabview;
@property (nonatomic,strong) NSMutableArray  *titlesArray;
@property (nonatomic,strong) NSMutableArray  *dataArray;
@property (nonatomic,strong) UIButton          *bindBtn;
@property (nonatomic,strong) UIImage          *selectIamge;

@end

static NSString *messageCellID = @"messageCellID";
static NSString *messageImageCellID = @"messageImageCellID";
@implementation MyUserMessageController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    
    self.titlesArray = (NSMutableArray*)@[@[@"昵称",@"性别"],@[@"姓名",@"手机号码",@"身份证号",@"工厂名称",@"工号"]];
    
    [self creatTabView];
    [self creatBindBtn];
    
}

- (void)creatBindBtn{
    
    self.bindBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    if (SceneWidth>375) {
           self.bindBtn.frame = CGRectMake(20, self.tabview.height-130-100, SceneWidth-40, 40);
    } else {
           self.bindBtn.frame = CGRectMake(20, self.tabview.height-100-100, SceneWidth-40, 40);
    }
 
   
    self.bindBtn.layer.cornerRadius = ButtonLayerCornerRadius;
    self.bindBtn.clipsToBounds = YES;
    self.bindBtn.layer.borderWidth = 0.3;
    self.bindBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
    [self.bindBtn setTitle:@"前往绑定饭卡" forState:(UIControlStateNormal)];
    [self.bindBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
    [self.bindBtn setBackgroundColor:[UIColor whiteColor]];
    [self.tabview addSubview:self.bindBtn];
    [self.bindBtn addTarget:self action:@selector(bindBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];

}

#pragma mark -bindBtnclickAction

- (void)bindBtnClickAction:(UIButton*)sender{

    BindFankaController *bindVC =[[BindFankaController alloc]init];
    [self.navigationController pushViewController:bindVC animated:YES];
}


- (void)creatTabView{
  
    self.tabview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SceneWidth, SceneHeight+100) style:(UITableViewStylePlain)];
    self.tabview.backgroundColor = BgColor;
    [self.view addSubview:self.tabview];
    
    self.tabview.dataSource = self;
    self.tabview.delegate = self;
    
    [self.tabview registerClass:[UserMessageCell class] forCellReuseIdentifier:messageCellID];
    
     [self.tabview registerClass:[UserMessageImageCell class] forCellReuseIdentifier:messageImageCellID];
    
    self.tabview.tableFooterView =[[UIView alloc]init];
    
    //  隐藏第一个分区头
    self.tabview.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    self.tabview.separatorStyle = UITableViewCellAccessoryNone;
    
    //tabview 偏移
    self.tabview.contentSize = CGSizeMake(SceneWidth, SceneHeight*1.2);
    UIView*footV = [[UIView alloc]init];
    footV.frame = CGRectMake(0, 0, SceneWidth, 100);
//    footV.backgroundColor =[UIColor redColor];
    self.tabview.tableFooterView = footV;
    
}

#pragma mark -UITableViewDelegate 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        
        NSArray *array = self.titlesArray[0];
        return array.count ;
    }else if (section == 2){
        NSArray *array = self.titlesArray[1];
        return array.count ;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    } else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[[UIView alloc]init];
    view.frame = CGRectMake(0, 0, SceneWidth, 10);
    view.backgroundColor =BgColor;

    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        //第一个cell
        UserMessageImageCell *cell =[self.tabview dequeueReusableCellWithIdentifier:messageImageCellID];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.selectIamge != nil) {

        cell.userImageV.image = self.selectIamge;
        }
        return cell;
        
    } else {
        //非图片cell
        UserMessageCell *cell =[self.tabview dequeueReusableCellWithIdentifier:messageCellID];
        if (indexPath.section == 1) {
            
            NSArray * userMessageArray = self.titlesArray[0];
                cell.titleLa.text = userMessageArray[indexPath.row];
        }
        
        if (indexPath.section ==2) {
        
            NSArray * facMessageArray = self.titlesArray[1];
            cell.titleLa.text = facMessageArray[indexPath.row];
            cell.rightImageV.hidden = YES;
//            if(indexPath.row == 2){
//             
//                    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"卡号(非必填)"];
//                    
//                    [AttributedStr addAttribute:NSFontAttributeName
//                     value:[UIFont systemFontOfSize:14.0]
//                     range:NSMakeRange(3, 3)];
//                    
//                    [AttributedStr addAttribute:NSForegroundColorAttributeName
//                     value:[UIColor colorWithHexStringg:@"#999999"]
//                     range:NSMakeRange(3, 3)];
//                    
//                    cell.titleLa.attributedText = AttributedStr;
//                    
//                }

            
        }
    
        
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册获取", nil];
        [as showInView:self.view];

    }
    //分区2
    //姓名
    if (indexPath.section == 1 && indexPath.row ==0) {
        EdituserMessageController *editnameVC =[[EdituserMessageController alloc]init];
        editnameVC.naTitle = @"修改姓名";
        [self.navigationController pushViewController:editnameVC animated:YES];
        
    }
    
    //性别
    if (indexPath.section == 1 && indexPath.row ==1) {
        
        EditGenderController *genderVC =[[EditGenderController alloc]init];
        [self.navigationController pushViewController:genderVC animated:YES];
    }
    //手机号码
    if (indexPath.section == 1 && indexPath.row ==2) {
        
        EdituserMessageController *editPhoneNVC =[[EdituserMessageController alloc]init];
       editPhoneNVC.naTitle = @"修改手机号码";
        [self.navigationController pushViewController:editPhoneNVC animated:YES];
        
    }
    //身份证号
    if (indexPath.section == 1 && indexPath.row ==3) {
        
        EdituserMessageController *editIDNumVC =[[EdituserMessageController alloc]init];
        editIDNumVC.naTitle = @"修改身份证号码";
        [self.navigationController pushViewController:editIDNumVC animated:YES];
        
    }
    //分区3
    
    //工厂名称
    if (indexPath.section == 2 && indexPath.row ==0) {
        
        EdituserMessageController *ediFavNameVC =[[EdituserMessageController alloc]init];
        ediFavNameVC.naTitle = @"修改工厂名称";
        [self.navigationController pushViewController:ediFavNameVC animated:YES];
    }
    //工号
    if (indexPath.section == 2 && indexPath.row ==1) {
        EdituserMessageController *ediFavNumVC =[[EdituserMessageController alloc]init];
        ediFavNumVC.naTitle = @"修改工号";
        [self.navigationController pushViewController:ediFavNumVC animated:YES];
    }
    //卡号
    if (indexPath.section == 2 && indexPath.row ==2) {
        EdituserMessageController *ediFankaNumVC =[[EdituserMessageController alloc]init];
        ediFankaNumVC.naTitle = @"修改工号";
        [self.navigationController pushViewController:ediFankaNumVC animated:YES];
    }

}

//照片选取
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
        self.selectIamge = newImage;
        [self.tabview reloadData];
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
        self.selectIamge = newImage;
        [self.tabview reloadData];
        
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
