//
//  GangweiSetAddViewController.m
//  WiseAPP
//
//  Created by app on 16/11/1.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "GangweiSetAddViewController.h"
#import "GangweiSetView.h"
#import "WSImagePickerView.h"
#import "GangweiSetModel.h"
#import "GangweiViewController.h"

@interface GangweiSetAddViewController ()<UITextViewDelegate>
@property(nonatomic,strong)GangweiSetView* ganWeiSetAddView;
@property (nonatomic, strong) WSImagePickerView *pickerView;

@end

@implementation GangweiSetAddViewController
-(void)loadView{

    self.ganWeiSetAddView =[[GangweiSetView alloc]initWithFrame:UIScreenBpunds];

    self.view =self.ganWeiSetAddView;
    [self setupPickerView];
    if (self.UpPageType==1) {
       // self.ganWeiSetAddView.produceFile.text =[NSString stringWithFormat:@"%d",self.model.id];
        self.ganWeiSetAddView.produceFile.text =self.model.post;
        self.ganWeiSetAddView.contentFile.text = self.model.jobassignment;
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.title =@"岗位设置";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    [self textViewDelegate];

}
    - (void)setupPickerView {

        WSImagePickerConfig *config = [WSImagePickerConfig new];
        config.itemSize = CGSizeMake(80, 80);
        config.photosMaxCount = 9;
        
        WSImagePickerView *pickerView = [[WSImagePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0) config:config];
        //Height changed with photo selection
        __weak typeof(self) weakSelf = self;
        pickerView.viewHeightChanged = ^(CGFloat height) {
            //weakSelf.photoViewHieghtConstraint.constant = height;
            [weakSelf.view setNeedsLayout];
            [weakSelf.view layoutIfNeeded];
        };
        pickerView.navigationController = self.navigationController;
        [self.ganWeiSetAddView.addImageView  addSubview:pickerView];
        self.pickerView = pickerView;
        
        //refresh superview height
        [pickerView refreshImagePickerViewWithPhotoArray:nil];
    }
#pragma mark - UITextViewDelegate
-(void)textViewDelegate{
    
    self.ganWeiSetAddView.contentFile.text=@"例如：工作时间不得玩手机";
    self.ganWeiSetAddView.contentFile.delegate=self;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"例如：工作时间不得玩手机";
        
        textView.textColor = textColorPlace;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"例如：工作时间不得玩手机"]){
        textView.text=@"";
        
        textView.textColor=[UIColor blackColor];
    }
    
}
    
-(void)saveAction:(UIBarButtonItem*)sender{

    if (self.UpPageType ==1) {
   
         [self editorData];
    } else {
           [self UploadData]; 
    }
    
    [self requestPointName];
        
    }

//conditons
-(void)requestPointName{

    if ([self.ganWeiSetAddView.produceFile.text isEqualToString:@" "]||self.ganWeiSetAddView.produceFile.text.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"点位名称不能为空" doneString:@"确定"];
    } else {
        
    }

}
-(void)requestContent{
    if ([self.ganWeiSetAddView.contentFile.text isEqualToString:@" "]||self.ganWeiSetAddView.contentFile.text.length==0) {
        [self AlerVCtitleString:@"提示" messageString:@"点位内容不能为空" doneString:@"确定"];
    } else {
        [self UploadData];
    }

}

-(void)editorData{

    //项目ID
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];

    //账号密码
    [param setObject:ID forKey:@"projectid"];
    [param setObject:@(self.model.gangweiID) forKey:@"id"];
    [param setObject:self.ganWeiSetAddView.produceFile.text forKey:@"post"];
    [param setObject:self.ganWeiSetAddView.contentFile.text forKey:@"jobassignment"];
 
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"postUpdate"] Token:self.tokenString parmpar:param succeed:^(id data) {
        for (NSArray*array in [data allValues]) {
            NSLog(@"上传图片成功---%@",array);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //if (data[@"resultCode"] ==0) {
                [self bacKturnPage];
           // }
            
        });
        
           } failure:^(NSError *error) {
        
    }];
    
    

}

-(void)UploadData{
    
    //项目ID
    NSString* ID= [ [SingleXiangmuxnxi SingleXiangmuxinxiManger].xiangmuprojectIdDic objectForKey:@"projectId"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];

    
    //账号密码
    [param setObject:ID forKey:@"projectid"];
    //[param setObject:@(self.model.id) forKey:@"id"];
    [param setObject:self.ganWeiSetAddView.produceFile.text forKey:@"post"];
    [param setObject:self.ganWeiSetAddView.contentFile.text forKey:@"jobassignment"];
    
    [RequestManger PostRequestUrl:[self urlRequestChildreurl:@"postAdd"] Token:self.tokenString parmpar:param succeed:^(id data) {
        for (NSArray*array in [data allValues]) {
                        NSLog(@"上传图片成功---%@",array);
                    }
        dispatch_async(dispatch_get_main_queue(), ^{
           // if (data[@"resultCode"] ==0) {
                [self bacKturnPage];
           // }
            
        });

    } failure:^(NSError *error) {
        
    }];
    
   
    
}
//turnpage
-(void)bacKturnPage{
  
    for (UIViewController*controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[GangweiViewController class]]) {
            GangweiViewController*gangweiVC=(GangweiViewController*)controller ;
            [self.navigationController popToViewController:gangweiVC animated:YES];
        }
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
