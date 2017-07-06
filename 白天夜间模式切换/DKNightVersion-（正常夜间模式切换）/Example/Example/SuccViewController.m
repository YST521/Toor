//
//  SuccViewController.m
//  DKNightVersion
//
//  Created by Draveness on 4/28/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import "SuccViewController.h"
#import <DKNightVersion/DKNightVersion.h>


@interface SuccViewController (){
    UILabel*navigationLabel;
}
@property(nonatomic,strong)UIButton*button;
@property(nonatomic,strong)UISwitch *switchs;
@end

@implementation SuccViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.navigationController.navigationBar.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = self.view.frame;
    textField.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    [self.view addSubview:textField];
    
    
    
    
    
    self.button =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button.frame = CGRectMake(100, 100, 100, 40);
    self.button.backgroundColor =[UIColor redColor];
    [self.view addSubview:self.button];
    [self.button setTitle:@"切换颜色" forState:(UIControlStateNormal)];
    [self.button addTarget:self action:@selector(open:) forControlEvents:(UIControlEventTouchUpInside) ];
    
    self.switchs =[[UISwitch alloc]init];
    self.switchs.frame = CGRectMake(100, 200, 100, 40);
    [self.view addSubview:self.switchs];
    
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"left" style:(UIBarButtonItemStylePlain) target:self action:@selector(left:)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"RIGHT" style:(UIBarButtonItemStylePlain) target:self action:@selector(right:)];
    [self changeColor];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 修改颜色也可以通过设置修改，改成你自己喜换的颜色，在这我是使用了DKNightVersion封装好的
- (void)changeColor
{
    UILabel *navLabel = [[UILabel alloc] init];
    navLabel.text = @"夜间模式";
    [navLabel sizeToFit];
    self.navigationItem.titleView = navLabel;
    
    // view的背景颜色
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    // titleView颜色
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    // 按钮title颜色
    [self.button dk_setTitleColorPicker:DKColorPickerWithKey(TINT) forState:UIControlStateNormal];
    // 开关颜色
    self.switchs.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    // 左右item颜色
    self.navigationItem.leftBarButtonItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    self.navigationItem.rightBarButtonItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
}

// button点击事件
- (void)open:(id)sender
{
    // 判断当前是否为夜间模式
    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        // 切换为白天模式
        [self.dk_manager dawnComing];
    } else {
        // 切换为夜间模式
        [self.dk_manager nightFalling];
    }
}

// 监听switch开/关
- (void)change:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.switchs.isOn) {
        // 打开切换为白天模式
        self.dk_manager.themeVersion = DKThemeVersionNight;
    }else {
        // 关闭切换为夜间模式
        self.dk_manager.themeVersion = DKThemeVersionNormal;
    }
}

// 左边item点击事件
- (void)left:(id)sender
{
    self.dk_manager.themeVersion = @"RED";
}

// 右边边item点击事件
- (void)right:(id)sender
{
    self.dk_manager.themeVersion = DKThemeVersionNormal;
}

@end
