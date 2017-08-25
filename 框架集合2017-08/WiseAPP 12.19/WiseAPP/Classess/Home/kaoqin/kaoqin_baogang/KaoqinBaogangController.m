//
//  KaoqinBaogangController.m
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "KaoqinBaogangController.h"
#import "BaogangHeadView.h"
#import "BaogangTableViewCell.h"
#import "BaogangDetailController.h"

@interface KaoqinBaogangController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UITableView* kaoqinBaoGangtabView;
@property(nonatomic,strong)BaogangHeadView*headView;
@property(nonatomic,strong)UIImagePickerController* pickController;

@end
static NSString* kaoqinBaogangcellID=@"kaoqinBaogangcellID";
@implementation KaoqinBaogangController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addData];
    [self addView];
    
    
}
-(void)addData{


}

-(void)addView{
    self.headView =[[BaogangHeadView alloc]init];
    self.headView.frame =CGRectMake(0, 0, SCREEN_WIDTH, PROPORTION_HIGHT(230));
    [self.view addSubview:self.headView];
      self.headView.cuttreeTimeLa.text =[self curreTime];
    self.headView.banciLa.text =@"班次:日班";
    self.headView.shijibaogangLa .text = @"实际报岗次数：2";
    self.headView.yingbaogangLa.text =@"应报岗次数：6";
    self.headView.weibaogangLa.text =@"未报岗次数：4";
    self.headView.leftTitleLa.text = @"应报岗时间";
    self.headView.rightTitleLa.text = @"实际报岗时间";
    
    self.kaoqinBaoGangtabView=[[UITableView alloc]initWithFrame:CGRectMake(0,PROPORTION_HIGHT(230), SCREEN_WIDTH, SCREEN_HEIGHT-PROPORTION_HIGHT(230)) style:UITableViewStylePlain ];
    [self.view addSubview:self.kaoqinBaoGangtabView];
    self.kaoqinBaoGangtabView.dataSource =self;
    self.kaoqinBaoGangtabView.delegate=self;
    [self.kaoqinBaoGangtabView registerClass:[BaogangTableViewCell class] forCellReuseIdentifier:kaoqinBaogangcellID];

}
-(NSString*)curreTime{
  
    
    NSString*curretime=nil;
    //if (0<(NSInteger)self.hours&& (NSInteger)self.hours< 12) {
    if (self.minutes<10) {
        curretime=[NSString stringWithFormat:@"%ld:0%ld",(NSInteger)self.hours,(long)self.minutes];
    } else {
        curretime=[NSString stringWithFormat:@"%ld:%ld",(NSInteger)self.hours,(long)self.minutes];
    }
    
    //    } else {
    //        if (self.minutes<10) {
    //            curretime=[NSString stringWithFormat:@"%ld:0%ld",(NSInteger)self.hours,(long)self.minutes];
    //        } else {
    //            curretime=[NSString stringWithFormat:@"%ld:%ld",(NSInteger)self.hours,(long)self.minutes];
    //        }
    //
    //    }
    return curretime;
    
}

#pragma mark =====delegate===========
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PROPORTION_HIGHT(80);
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaogangTableViewCell*cell=[self.kaoqinBaoGangtabView dequeueReusableCellWithIdentifier:kaoqinBaogangcellID];
    cell.middleNumLa.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    cell.leftGangweiLa.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    //取消分割线
    self.kaoqinBaoGangtabView.separatorStyle = UITableViewCellAccessoryNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //action
    [cell.lefDetailBtn addTarget:self action:@selector(detailBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [cell.rightCamareBtn addTarget:self action:@selector(cameraBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}

//detail Btn Action
-(void)detailBtnAction:(UIButton*)sender{
    NSLog(@"岗位详情");
    BaogangDetailController* detailVC=[[BaogangDetailController alloc]init];
    detailVC.navigationItem.title = @"岗位详情";
    [self.navigationController pushViewController:detailVC animated:YES];

}
//camera action
-(void)cameraBtnAction:(UIButton*)sender{
    NSLog(@"拍照");
    [self camare];
}
-(void)camare{
    self.pickController =[[UIImagePickerController alloc]init];
    self.pickController.delegate=self;
    self.pickController.allowsEditing=YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
    self.pickController.sourceType=UIImagePickerControllerSourceTypeCamera;
    
    if ([[[UIDevice currentDevice] systemVersion]floatValue] >= 8.0) {
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
      
    }
        
[self presentViewController:self.pickController animated:YES completion:nil];
    }else {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"当前设备不支持拍照" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
        style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) { }]];

        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
        
    }
    
    

}
//git camera image
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage*image=info[UIImagePickerControllerEditedImage];
    if (!image) {
        image =info[UIImagePickerControllerOriginalImage];
    }
    NSLog(@"HHHH%@",image);
    //测试
    BaogangDetailController* detailVC=[[BaogangDetailController alloc]init];
    detailVC.navigationItem.title = @"岗位详情";
    detailVC.image =image;
    [self.navigationController pushViewController:detailVC animated:YES];
    //leave camare
    [self dismissViewControllerAnimated:YES completion:NULL];

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
