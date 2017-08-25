//
//  EditGenderController.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/4.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "EditGenderController.h"

@interface EditGenderController (){
    UIImageView *iv;
    UIButton *boy, *girl;
    
    
}

@end

@implementation EditGenderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"修改性别"];
    
    iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"21_bg_xuanzhong"]];
    iv.top = 20 - iv.height/2;
    iv.layer.cornerRadius = iv.width/2;
    iv.clipsToBounds = YES;
    iv.backgroundColor =[UIColor lightGrayColor];
    iv.left = SceneWidth - 20 - iv.width;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 74, SceneWidth, 80)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
    boy = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SceneWidth, 40)];
    [boy addTarget:self action:@selector(boyAction:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:boy];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 20, 40)];
    lab.text = @"男";
    [boy addSubview:lab];
    
    girl = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, SceneWidth, 40)];
    [girl addTarget:self action:@selector(girlAction:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:girl];
    lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 20, 40)];
    lab.text = @"女";
    [girl addSubview:lab];
    
    lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, SceneWidth-40, 0.5)];
    lab.backgroundColor = [UIColor grayColor];
    [v addSubview:lab];
//    [boy addSubview:iv];
//    [girl addSubview:iv];
    
//    
//    if ([[AppData shareInstance].personCell.pyq_user_sex isKindOfClass:[NSString class]] && [AppData shareInstance].personCell.pyq_user_sex.length && [[AppData shareInstance].personCell.pyq_user_sex isEqualToString:@"男"]) {
//        [boy addSubview:iv];
//    } else {
//        [girl addSubview:iv];
//    }
    
}

- (void)boyAction:(UIButton *)btn
{
    if (iv.superview == btn) {
        return;
    }
    [boy addSubview:iv];
    //    [girl addSubview:iv];
//    [self showLoadView];
//    WeakSelf;
//    [APIHelper requestWithUrl:@"/rest/v1/pyqquanzi/updateUserBaseInfo" pramas:@{@"pyq_user_sex" : @"男"} afCompletionBlock:^(BaseApiResult *result) {
//        [this closeLoadView];
//        [this showTipInfo:result.message];
//        if (result.rspResult == 1) {
//            //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            //                [this.navigationController popViewControllerAnimated:YES];
//            //            [AppData shareInstance].personCell.pyq_user_sex = @"男";
//            [[AppData shareInstance].personCell setPyqData:result.data];
//            [iv removeFromSuperview];
//            [boy addSubview:iv];
//            //            });
//        } else {
//            [this showTipInfo:result.message];
//        }
//    }];
}

- (void)girlAction:(UIButton *)btn
{
    if (iv.superview == btn) {
        return;
    }
//    [boy addSubview:iv];
        [girl addSubview:iv];
   
//    [self showLoadView];
//    WeakSelf;
//    [APIHelper requestWithUrl:@"/rest/v1/pyqquanzi/updateUserBaseInfo" pramas:@{@"pyq_user_sex" : @"女"} afCompletionBlock:^(BaseApiResult *result) {
//        [this closeLoadView];
//        [this showTipInfo:result.message];
//        if (result.rspResult == 1) {
//            //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            //                [this.navigationController popViewControllerAnimated:YES];
//            //            [AppData shareInstance].personCell.pyq_user_sex = @"女";
//            [[AppData shareInstance].personCell setPyqData:result.data];
//            [iv removeFromSuperview];
//            [girl addSubview:iv];
//            //            });
//        } else {
//            [this showTipInfo:result.message];
//        }
//    }];
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
