//
//  AddAddressController.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/7.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "AddAddressController.h"
#import "CitySelectController.h"
#import "ProvinceSelectController.h"


@interface AddAddressController ()
{
    UITextField *tfName, *tfPhone, *tfAddress;
    UILabel *labDiqu;
    NSString *diqu,*switchStatus;
    UISwitch *switchView;
     UIView *topBarView;
    UIImageView *imageV;
}
@end

@implementation AddAddressController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self setupViewsContents];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotificiation:) name:@"addressNotification" object:@"addressName"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"新增收货地址"];
    
    [self creatUI];
    [self creatNabar];
    [self editData];
}
- (void)creatNabar{
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveBarAction:)];

}

-(void)editData{
   // tfName.text,tfPhone.text,tfAddress.text,switchStatus);
    if (self.isEdit == YES) {
        
    
       tfName.text = self.adressArray[0];
        tfPhone.text = self.adressArray[1];
        tfAddress.text = self.adressArray[2];
        
    }
    
}

- (void)saveBarAction:(UIBarButtonItem*)sender{

    NSLog(@"---%@--%@--%@--%@",tfName.text,tfPhone.text,tfAddress.text,switchStatus);
   }
- (void)receiveNotificiation:(NSNotification*)sender{

    NSString *cityName = sender.userInfo[@"cityName"];
    labDiqu.text = cityName;
    labDiqu.textColor = [UIColor blackColor];
   
}

-(void)creatUI{
    UIButton* btnGroup = [[UIButton alloc] initWithFrame:CGRectMake(SceneWidth - 65, 22, 60, 40)];
    [btnGroup setTitle:@"保存" forState:UIControlStateNormal];
    [btnGroup setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnGroup addTarget:self action:@selector(publishClick:) forControlEvents:UIControlEventTouchUpInside];
    [topBarView addSubview:btnGroup];
    
    float top = 64;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, top, SceneWidth, 253)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [self createLeftLabel:top text:@"收货人"];
    tfName = [[UITextField alloc] init];
    [self createTf:tfName top:top text:@"请输入收货人姓名"];
    top += 50;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, top, SceneWidth, 0.5)];
    line.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    [self.view addSubview:line];
    top = line.bottom;
    
    [self createLeftLabel:top text:@"手机号码"];
    tfPhone = [[UITextField alloc] init];
    [self createTf:tfPhone top:top text:@"请输入手机号码"];
    top += 50;
    line = [[UIView alloc] initWithFrame:CGRectMake(0, top, SceneWidth, 0.5)];
    line.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    [self.view addSubview:line];
    top = line.bottom;
    
    [self createLeftLabel:top text:@"所在区域"];
    labDiqu = [self createLabel:CGRectMake(95, top, SceneWidth-120, 50) title:@"请选择收件城市" fontSize:17 textColor:[UIColor colorWithWhite:0.8 alpha:1]];
    [self.view addSubview:labDiqu];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_xianghou"]];
    iv.top = labDiqu.top + 20 - iv.height/2;
    iv.right = SceneWidth - 20;
    [self.view addSubview:iv];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:labDiqu.frame];
    [btn addTarget:self action:@selector(cityAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    top += 50;
    line = [[UIView alloc] initWithFrame:CGRectMake(0, top, SceneWidth, 0.5)];
    line.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    [self.view addSubview:line];
    top = line.bottom;
    
    [self createLeftLabel:top text:@"详细地址"];
    tfAddress = [[UITextField alloc] init];
    [self createTf:tfAddress top:top text:@"请填写街道门牌号"];
    top = tfAddress.bottom;
    
    line = [[UIView alloc] initWithFrame:CGRectMake(0, top,SceneWidth, 0.5)];
    line.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    [self.view addSubview:line];
    top = line.bottom;
    
    if (_isNewAdd) {
        [self setTitle:@"收货地址"];
        [btnGroup setTitle:@"新增" forState:UIControlStateNormal];
    } else {
        if (_isEdit) {
            [self setTitle:@"修改收货地址"];
        }
        
        
        UILabel *morenLable = [[UILabel alloc] initWithFrame:CGRectMake(20, top, 120, 50)];
        morenLable.text = @"设为默认地址";
        morenLable.textColor = [UIColor colorWithHexStringg:@"#666666"];
        morenLable.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:morenLable];
        
        switchView = [[UISwitch alloc] initWithFrame:CGRectMake(SceneWidth-70, top+10, 50, 30)];
        switchView.on = NO;
        switchView.onTintColor = SquareColorBlick;
        [self.view addSubview: switchView];
        
        }
     [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
    
    [self setupViewsContents];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectDiqu:) name:Notification_SelectDiqu object:nil];
}



-(void)switchAction:(UISwitch*)sender{
    
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
        switchStatus = @"开";
       self.view.backgroundColor = RandomColor;
    }else {
        NSLog(@"关");
         switchStatus = @"关";
        self.view.backgroundColor = RandomColor;
    }
    
    

}

- (void)setupViewsContents
{
//    if (tfName.text.length == 0) {
//        if ([_address.receiveuser isKindOfClass:[NSString class]] && _address.receiveuser.length) {
//            tfName.text = _address.receiveuser;
//        }
//    }
//    
//    if (tfPhone.text.length == 0) {
//        if ([_address.receivephone isKindOfClass:[NSString class]] && _address.receivephone.length) {
//            tfPhone.text = _address.receivephone;
//        }
//    }
//    
//    if ([_address.receivelocality isKindOfClass:[NSString class]] && _address.receivelocality.length) {
//        labDiqu.text = _address.receivelocality;
//        labDiqu.textColor = [UIColor blackColor];
//    }
//    
//    if (tfAddress.text.length == 0) {
//        if ([_address.receiveaddress isKindOfClass:[NSString class]] && _address.receiveaddress.length) {
//            tfAddress.text = _address.receiveaddress;
//        }
//    }
//    if(_address.isdefault){
//        switchView.on = [_address.isdefault boolValue];
//    }
    
    
}

- (void)createLeftLabel:(float)top text:(NSString*)text
{
    UILabel *lab = [self createLabel:CGRectMake(20, top, 100, 50) title:text fontSize:16 textColor:[UIColor colorWithHexStringg:@"#666666"]];
    [self.view addSubview:lab];
}

- (void)createTf:(UITextField*)tf top:(float)top text:(NSString*)text
{
    tf.frame = CGRectMake(95, top, SceneWidth-100, 50);
    tf.placeholder = text;
    [self.view addSubview:tf];
}

#pragma mark - Actions

- (void)defaultAction:(UIButton*)btn
{
    btn.selected = !btn.selected;
}

- (BOOL)validateNumber:(NSString *)textString
{
    NSString* number=@"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}

- (void)publishClick:(UIButton*)btn
{
    [self.view endEditing:YES];
    if (! [tfName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length) {
        [self showTipInfo:@"请输入收件人姓名"];
        return;
    }
    
    if (! [tfPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length) {
        [self showTipInfo:@"请输入收件人手机号码"];
        return;
    } else if ( ! [self validateNumber:tfPhone.text] || tfPhone.text.length != 11) {
        [self showTipInfo:@"请输入11位的手机号码"];
        return;
    }
    
    if (! [labDiqu.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length || [labDiqu.text isEqualToString:@"请选择收件城市"]) {
        [self showTipInfo:@"请选择地区"];
        return;
    }
    
    if (! [tfAddress.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length) {
        [self showTipInfo:@"请输入地址"];
        return;
    }
    
    WeakSelf;
    [self showLoadView];
    NSDictionary *dic =  @{@"receiveuser" : tfName.text, @"receivephone":tfPhone.text, @"receivelocality":labDiqu.text, @"receiveaddress":tfAddress.text, @"isdefault":@(switchView.on)};
    
    
    dispatch_group_t g = dispatch_group_create();
    
    if (_isEdit) {
        // 编辑的话就先删除再修改
        dispatch_group_enter(g);
    
//        [APIHelper requestWithUrl:@"/rest/v1/receiveaddress/delete" pramas:@{@"id":_address.id} afCompletionBlock:^(BaseApiResult *result) {
//            dispatch_group_leave(g);
//            if (result.rspResult != 1) {
//                [this showTipInfo:result.message];
//            }
//        }];
    }
    
    
    if (_isEdit) {
        dispatch_group_enter(g);
    }
//    [APIHelper requestWithUrl:@"/rest/v1/receiveaddress/add" pramas:dic afCompletionBlock:^(BaseApiResult *result) {
//        [this closeLoadView];
//        [this showTipInfo:result.message];
//        if (result.rspResult == 1) {
//            [this.navigationController popViewControllerAnimated:YES];
//            if ([this.delegate respondsToSelector:@selector(editShouHuoViewControllerSaveAddress:)]) {
//                ReceiveAddress *address = [[ReceiveAddress alloc] initWithDictionary:result.data error:nil];
//                address.receivephone = tfName.text;
//                address.receiveuser = tfName.text;
//                address.receivelocality = labDiqu.text;
//                address.receiveaddress = tfAddress.text;
//                [this.delegate editShouHuoViewControllerSaveAddress:address];
//            }
//        } else {
//            
//        }
    
//        if (_isEdit) {
//            dispatch_group_leave(g);
//        }
//    }];
    
//    dispatch_group_notify(g, dispatch_get_main_queue(), ^{
//        if (this.isEdit) {
//            if ([this.delegate respondsToSelector:@selector(editShouHuoViewControllerSaveAddress:)]) {
//                [this.delegate editShouHuoViewControllerSaveAddress:this.address];
//            }
//        }
//    });
    
    return;
    
    //    NSDictionary *dic =  @{@"pyq_user_receiveuser" : tfName.text, @"pyq_user_receivephone":tfPhone.text, @"pyq_user_receivediqu":labDiqu.text, @"pyq_user_receiveaddress":tfAddress.text};
    //    [APIHelper requestWithUrl:@"/rest/v1/pyqquanzi/updateUserBaseInfo" pramas:dic afCompletionBlock:^(BaseApiResult *result) {
    //        [this closeLoadView];
    //
    //        if (result.rspResult == 1) {
    //            [_address setPyqData:result.data];
    //            [this.navigationController popViewControllerAnimated:YES];
    //        }
    //    }];
}

- (void)cityAction:(UIButton*)btn
{
    ProvinceSelectController *vc = [[ProvinceSelectController alloc] init];
//    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Notifications

- (void)dealloc{


    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addressNotification" object:@"addressName"];
    
}

- (void)selectDiqu:(NSNotification*)notice
{
    NSString *str = notice.object;
    if ([str isKindOfClass:[NSString class]]) {
        diqu = str;
    }
    
    labDiqu.text = str;
    labDiqu.textColor = [UIColor blackColor];
}

//- (void)createLeftLabel:(float)top text:(NSString*)text
//{
//    UILabel *lab = [self createLabel:CGRectMake(20, top, 100, 50) title:text fontSize:16 textColor:[UIColor blackColor]];
//    [self.view addSubview:lab];
//}
//
//- (void)createTf:(UITextField*)tf top:(float)top text:(NSString*)text
//{
//    tf.frame = CGRectMake(95, top, SceneWidth-100, 50);
//    tf.placeholder = text;
//    [self.view addSubview:tf];
//}

-(UILabel *)createLabel:(CGRect)frame title:(NSString *)title fontSize:(int)fontSize textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = title;
    if(textColor != nil)
        label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}
//@interface AddAddressController ()<UITableViewDelegate,UITableViewDataSource>
//@property(nonatomic,strong)UITableView *tabview;
//
//
//
//@end
//
//@implementation AddAddressController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    [self setTitle:@"地址管理"];
//    [self creatUI];
//}
//
//
//- (void)creatUI{
//    
//    self.tabview = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
//    [self.view addSubview:self.tabview];
//
//    self.tabview.dataSource = self;
//    self.tabview.delegate = self;
//}
//#pragma mark -uitabviewDelegate
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return  5;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//  
//    UITableViewCell *cell =[self.tabview dequeueReusableCellWithIdentifier:@"addressCellID"];
//    if (!cell) {
//        cell =[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"addressCellID"];
//    }
//    
//    
//    
//    return  cell;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    
//    
//    ProvinceSelectController *citySelectVC = [[ProvinceSelectController alloc]init];
//
//    [self.navigationController pushViewController:citySelectVC animated:YES];
//}


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
