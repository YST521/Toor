//
//  AddressBookViewController.m
//  WiseAPP
//
//  Created by app on 16/10/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "AddressBookViewController.h"
 #import <AddressBook/AddressBook.h>
 #import <AddressBookUI/AddressBookUI.h>
#import "SYContactsPickerController.h"
#import "SYContactsHelper.h"
#import "ChineseString.h"

#define IS_iOS8 [[UIDevice currentDevice].systemVersion floatValue] >= 8.0f
#define IS_iOS6 [[UIDevice currentDevice].systemVersion floatValue] >= 6.0f
#define APP_WIDTH [[UIScreen mainScreen]applicationFrame].size.width
#define APP_HEIGHT [[UIScreen mainScreen]applicationFrame].size.height
@interface AddressBookViewController ()<ABPeoplePickerNavigationControllerDelegate,SYContactsPickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>{
    
         ABPeoplePickerNavigationController *_abPeoplePickerVc;
}
@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@property(nonatomic,strong)NSMutableArray* dataArray;

@property (nonatomic, strong) UILabel *sectionTitleView;
@property (nonatomic, strong) NSTimer *timer;
@property(nonatomic,strong)UITableView* adressBookTabView;

@end



@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 self.view.backgroundColor = [UIColor greenColor];
   self.navigationItem.title = @"通讯录";
 

//    self.sectionTitleView = ({
//        UILabel *sectionTitleView = [[UILabel alloc] initWithFrame:CGRectMake((APP_WIDTH-100)/2, (APP_HEIGHT-100)/2,100,100)];
//        sectionTitleView.textAlignment = NSTextAlignmentCenter;
//        sectionTitleView.font = [UIFont boldSystemFontOfSize:60];
//        sectionTitleView.textColor = [UIColor blueColor];
//        sectionTitleView.backgroundColor = [UIColor whiteColor];
//        sectionTitleView.layer.cornerRadius = 6;
//        sectionTitleView.layer.borderWidth = 1.f/[UIScreen mainScreen].scale;
//        _sectionTitleView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//        sectionTitleView;
//    });
//    [self.navigationController.view addSubview:self.sectionTitleView];
//    self.sectionTitleView.hidden = YES;
    self.adressBookTabView =[[UITableView alloc]init];
    self.adressBookTabView.frame = self.view.bounds;
    [self.view addSubview:self.adressBookTabView];
    self.adressBookTabView.dataSource =self;
    self.adressBookTabView.delegate =self;
    [self.adressBookTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.dataArray=[NSMutableArray array];
    
      NSArray *stringsToSort = [NSMutableArray arrayWithObjects:
                              @"￥hhh, .$",@" ￥Chin ese ",@"开源中国 ",@"www.oschina.net",
                              @"开源技术",@"社区",@"开发者",@"传播",
                              @"2014",@"a1",@"100",@"中国",@"暑假作业",
                              @"键盘", @"鼠标",@"hello",@"world",@"b1",
                              nil];
    self.indexArray = [ChineseString IndexArray:stringsToSort];
    self.letterResultArr = [ChineseString LetterSortArray:stringsToSort];
    
   self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"添加" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    

}
-(void)saveAction:(UIBarButtonItem*)sender{
    SYContactsPickerController *vcContacts = [[SYContactsPickerController alloc] init];
        vcContacts.delegate = self;
        [self presentViewController:vcContacts animated:YES completion:nil];

}
//-(void)addView{
//
//    //1.打开通讯录
//    UIButton *openAddressBook = [UIButton buttonWithType:UIButtonTypeCustom];
//    openAddressBook.frame = CGRectMake(100, 50, 100, 50);
//    [openAddressBook setTitle:@"打开通讯录" forState:UIControlStateNormal];
//    openAddressBook.backgroundColor = [UIColor greenColor];
//    [openAddressBook setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [openAddressBook addTarget:self action:@selector(gotoAddressBook) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:openAddressBook];
//    
//    //2.添加联系人
//    UIButton *addContacts = [UIButton buttonWithType:UIButtonTypeCustom];
//    addContacts.frame = CGRectMake(100, 150, 100, 50);
//    [addContacts setTitle:@"添加联系人" forState:UIControlStateNormal];
//    addContacts.backgroundColor = [UIColor greenColor];
//    [addContacts setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [addContacts addTarget:self action:@selector(gotoAddContacts:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:addContacts];
//
//}
//-(void)gotoAddContacts:(UIButton*)sender{
//    SYContactsPickerController *vcContacts = [[SYContactsPickerController alloc] init];
//    vcContacts.delegate = self;
//    [self presentViewController:vcContacts animated:YES completion:nil];
//
//}
//#pragma mark - SYContactsPickerControllerDelegate
//
//- (void)contactsPickerController:(SYContactsPickerController *)picker didFinishPickingContacts:(NSArray *)contacts {
//    NSLog(@"contacts==%@",contacts);
//}
//
//- (void)contactsPickerController:(SYContactsPickerController *)picker didSelectContacter:(SYContacter *)contacter {
//    NSLog(@"contacter==%@",contacter);
//}
//
//- (void)contactsPickerController:(SYContactsPickerController *)picker didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"indexPath==%@",indexPath);
//}
//
//- (void)contactsPickerControllerDidCancel:(SYContactsPickerController *)picker {
//    NSLog(@"contactsPickerControllerDidCancel");
//}
//
///**
//   打开通讯录
//   */
// - (void)gotoAddressBook{
//    
//        _abPeoplePickerVc = [[ABPeoplePickerNavigationController alloc] init];
//        _abPeoplePickerVc.peoplePickerDelegate = self;
//
//         //下面的判断是ios8之后才需要加的，不然会自动返回app内部
//         if(IS_iOS8){
//        
//                 //predicateForSelectionOfPerson默认是true （当你点击某个联系人查看详情的时候会返回app），如果你默认为true 但是实现-peoplePickerNavigationController:didSelectPerson:property:identifier:
//        　　　　　　  // 代理方法也是可以的，与此同时不能实现peoplePickerNavigationController: didSelectPerson:不然还是会返回app。
//                 //总之在ios8之后加上此句比较稳妥
//                 _abPeoplePickerVc.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
//        
//                 //predicateForSelectionOfProperty默认是true （当你点击某个联系人的某个属性的时候会返回app），此方法只要是默认值，无论你代理方法实现与否都会返回app。
//         //        _abPeoplePickerVc.predicateForSelectionOfProperty = [NSPredicate predicateWithValue:false];
//    
//                 //predicateForEnablingPerson默认是true，当设置为false时，所有的联系人都不能被点击。
//         //        _abPeoplePickerVc.predicateForEnablingPerson = [NSPredicate predicateWithValue:true];
//             }
//         [self presentViewController:_abPeoplePickerVc animated:YES completion:nil];
//     
//     }
//#pragma mark - ABPeoplePickerNavigationController的代理方法
//
// - (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
//    
//         ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
//    
//         long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
//    
//         NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
//         [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
//         if (phone && phoneNO.length == 11) {
//                 //TODO：获取电话号码要做的事情
//    
//                 [peoplePicker dismissViewControllerAnimated:YES completion:nil];
//                 return;
//             }else{
//                     if (IS_iOS8){
//                             UIAlertController *tipVc = [UIAlertController alertControllerWithTitle:nil message:@"请选择正确手机号" preferredStyle:UIAlertControllerStyleAlert];
//                             UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//                                     [self dismissViewControllerAnimated:YES completion:nil];
//                            }];
//                        [tipVc addAction:cancleAction];
//                            [self presentViewController:tipVc animated:YES completion:nil];
//            
//                         }else{
//                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请选择正确手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                                 [alertView show];
//                             }
//                     //非ARC模式需要释放对象
//             //        [alertView release];
//                 }
//    }
//
//
// - (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person NS_AVAILABLE_IOS(8_0)
// {
//         ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
//         personViewController.displayedPerson = person;
//    
//        [peoplePicker pushViewController:personViewController animated:YES];
//         //非ARC模式需要释放对象
//     //    [personViewController release];
//    }
//
///**
//    46  peoplePickerNavigationController点击取消按钮时调用
//    47  */
//- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
//{
//        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
//     }
//
// /**
//    54  iOS8被废弃了，iOS8前查看联系人必须实现（点击联系人可以继续操作）
//    55  */
//- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person NS_DEPRECATED_IOS(2_0, 8_0)
// {
//         return YES;
//     }
//
///**
//    62  iOS8被废弃了，iOS8前查看联系人属性必须实现（点击联系人属性可以继续操作）
//    63  */
// - (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier NS_DEPRECATED_IOS(2_0, 8_0)
// {
//         ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
//    
//         long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
//
//         NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
//         phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
//         NSLog(@"%@", phoneNO);
//         if (phone && phoneNO.length == 11) {
//                //TODO：获取电话号码要做的事情
//        
//                 [peoplePicker dismissViewControllerAnimated:YES completion:nil];
//                 return NO;
//             }else{
//                     if (IS_iOS8){
//                            UIAlertController *tipVc = [UIAlertController alertControllerWithTitle:nil message:@"请选择正确手机号" preferredStyle:UIAlertControllerStyleAlert];
//                             UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//                                    [self dismissViewControllerAnimated:YES completion:nil];
//                                }];
//                            [tipVc addAction:cancleAction];
//                             [self presentViewController:tipVc animated:YES completion:nil];
//                         
//                         }else{
//                                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请选择正确手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                                 [alertView show];
//                             }
//                 }
//         return YES;
//     }
//
//
#pragma mark -
#pragma mark - UITableViewDataSource

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.letterResultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.adressBookTabView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [self showSectionTitle:title];
    return index;
}


#pragma mark - private
- (void)timerHandler:(NSTimer *)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            self.sectionTitleView.alpha = 0;
        } completion:^(BOOL finished) {
            self.sectionTitleView.hidden = YES;
        }];
    });
}

-(void)showSectionTitle:(NSString*)title{
    [self.sectionTitleView setText:title];
    self.sectionTitleView.hidden = NO;
    self.sectionTitleView.alpha = 1;
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}



#pragma mark -
#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [UILabel new];
    lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lab.text = [self.indexArray objectAtIndex:section];
    lab.textColor = [UIColor whiteColor];
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---->%@",[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]
                                                   delegate:nil
                                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
    [alert show];
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
