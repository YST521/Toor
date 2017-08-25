//
//  KaoqintongjiController.m
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "KaoqintongjiController.h"
#import "MyLayout.h"
#import "NSDate+Calendar.h"
#import "DateChooseView.h"
#import "MyCollectionViewCell.h"
#import "DateModel.h"
#import "CalendarTitleView.h"

CGFloat titleHeight = 70;
CGFloat underViewHeight = 40;

@interface KaoqintongjiController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** 集合视图的底层视图 */
@property (nonatomic,strong) UIView *bottomView;
/** 点击顶部日期，弹出DatePicker */
@property (nonatomic,strong) DateChooseView *dateChooseView;
/** 最底层的滚动视图 */
@property (nonatomic,strong) UIScrollView *myScrollView;
/** 显示日期的集合视图 */
@property (nonatomic,strong) UICollectionView *myCollectionView;
/** 存储当前视图所有的日期模型 */
@property (nonatomic,strong) NSMutableArray *daysMutArray;
/** 记录顶部的日期 */
@property (nonatomic,strong) NSDate *titleDate;
/** 记录选中的日期cell */
@property (nonatomic,strong) MyCollectionViewCell *selectCell;
/** 记录选中的日期模型对象 */
@property (nonatomic,strong) DateModel *selectDateModel;
/** 顶部视图（包括日期和周几标签） */
@property (nonatomic,strong) CalendarTitleView *titleView;
/** 月份和日期切换的方式，点击顶部视图还是左右手势 */
@property (nonatomic,strong) NSString *titleDateChangeType;
@end

@implementation KaoqintongjiController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    
    self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20-underViewHeight)];
    [self.view addSubview:self.myScrollView];
    self.myScrollView.backgroundColor = [UIColor whiteColor];
    // 获取北京时间，初始化数据
    _daysMutArray = [self getAllDaysWithDate:[NSDate date]];
    _selectCell = nil;
    _selectDateModel = nil;
    self.titleDateChangeType = @"swipe";
    
    [self setUpBottomView];
    [self setUpUnderView];
    
    [self addObserver:self forKeyPath:@"titleDate" options:NSKeyValueObservingOptionNew context:nil];
    self.titleDate = [NSDate date];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectionReloadData) name:@"reloadCollectionView" object:nil];
}
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"titleDate"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - 界面设置
- (void)setUpBottomView {
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH-6)/7*_daysMutArray.count/7+titleHeight+8)];
    bottomView.backgroundColor = [UIColor redColor];
    self.bottomView = bottomView;
    
    // 底层顶部的 日期和星期标示 视图配置
    _titleView = [[NSBundle mainBundle] loadNibNamed:@"CalendarTitleView" owner:self options:nil].firstObject;
    _titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, titleHeight);
    _titleView.backgroundColor = [UIColor redColor];
    [bottomView addSubview:_titleView];
    [_titleView.dateChooseButton addTarget:self action:@selector(dateChooseButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_titleView.todayButton addTarget:self action:@selector(todayButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    // 日历集合视图的配置
    MyLayout *layout = [[MyLayout alloc]init];
    self.myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, titleHeight,SCREEN_WIDTH,(SCREEN_WIDTH-6)/7*_daysMutArray.count/7+5) collectionViewLayout:layout];
    
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    // 集合视图关闭滚动，并添加左右滑动手势
    self.myCollectionView.scrollEnabled = NO;
    self.myCollectionView.backgroundColor = [UIColor lightGrayColor];
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeftGestureMethod:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.myCollectionView addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRightGestureMethod:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.myCollectionView addGestureRecognizer:rightSwipe];
    
    [bottomView addSubview:self.myCollectionView];
    [self.myScrollView addSubview:bottomView];
}

/** 设置底部左右切换日历按钮 */
- (void)setUpUnderView {
    UIView *underView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-underViewHeight, SCREEN_WIDTH, underViewHeight)];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 5, 30, 30)];
    [leftButton setImage:[UIImage imageNamed:@"bt_back_left"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 5, 30, 30)];
    [rightButton setImage:[UIImage imageNamed:@"bt_back_right"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    
    [underView addSubview:leftButton];
    [underView addSubview:rightButton];
    underView.backgroundColor =[UIColor redColor];
    [self.view addSubview:underView];
}
- (void)clickLeftButton {
    [self swipeRightGestureMethod:nil];
}
- (void)clickRightButton {
    [self swipeLeftGestureMethod:nil];
}
/** 左划手势触发的方法 */
- (void)swipeLeftGestureMethod:(UISwipeGestureRecognizer *)ges {
    // 左滑动 下一个月
    [self swipeAnimationWith:@"左"];
    NSDate *lastDayInMonth = [self.titleDate getLastDayInMonth];
    NSDate *newMonthDate = [NSDate dateWithTimeInterval:24*3600 sinceDate:lastDayInMonth];
    [self.daysMutArray removeAllObjects];
    self.daysMutArray = [self getAllDaysWithDate:newMonthDate];
    self.titleDate = newMonthDate;
}
/** 右划手势触发的方法 */
- (void)swipeRightGestureMethod:(UISwipeGestureRecognizer *)ges {
    // 右滑动 上一个月
    [self swipeAnimationWith:@"右"];
    NSDate *firstDayInMonth = [self.titleDate getFirstDayInMonth];
    NSDate *newMonthDate = [NSDate dateWithTimeInterval:-24*3600 sinceDate:firstDayInMonth];
    [self.daysMutArray removeAllObjects];
    self.daysMutArray = [self getAllDaysWithDate:newMonthDate];
    self.titleDate = newMonthDate;
}
/** 左右滑动手势动画效果 */
- (void)swipeAnimationWith:(NSString *)str {
    self.titleDateChangeType = @"swipe";
    CATransition *anim = [[CATransition alloc]init];
    anim.type = @"cube";  //  还有其他动画，如：推出@"push" 翻页@"pageCurl" 翻转@"oglFlip" 等等
    if ([str isEqualToString:@"左"]) {
        anim.subtype = kCATransitionFromRight;
    }else{
        anim.subtype = kCATransitionFromLeft;
    }
    anim.duration = 0.2;
    [self.myCollectionView.layer addAnimation:anim forKey:@"Animation"];
}

#pragma mark - 顶部点击日期弹出Date Piker 相关
/** 懒加载Date piker 所在视图 */
- (DateChooseView *)dateChooseView {
    if (!_dateChooseView) {
        _dateChooseView = [[NSBundle mainBundle] loadNibNamed:@"DateChooseView" owner:self options:nil].firstObject;
        _dateChooseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        [_dateChooseView.sureButton addTarget:self action:@selector(dateChooseViewSureButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_dateChooseView.cancelButton addTarget:self action:@selector(dateChooseViewCancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_dateChooseView aboveSubview:self.myCollectionView];
    }
    _dateChooseView.datePicker.date = self.titleDate;
    return _dateChooseView;
}
/// 点击今天按钮
- (void)todayButtonClicked{
    self.titleDateChangeType = @"swipe";
    [self animation];
    self.daysMutArray = [self getAllDaysWithDate:[NSDate date]];
    self.titleDate = [NSDate date];
}
- (void)animation {
    CATransition *animation = [[CATransition alloc]init];
    animation.subtype = kCATransitionFromTop;
    animation.type = @"rippleEffect"; // @"rippleEffect"波纹效果， @"cameraIrisHollowOpen"镜头打开效果
    animation.duration = 0.2;
    [self.myCollectionView.layer addAnimation:animation forKey:nil];
}
/** 顶部日期点击弹出底部Date piker视图 */
- (void)dateChooseButtonClicked {
    [UIView animateWithDuration:0.2 animations:^{
        self.dateChooseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}
/** Date Piker所在视图中的确认按钮点击 */
- (void)dateChooseViewSureButtonClicked {
    self.titleDateChangeType = @"datePicker";
    [self dateChooseViewCancelButtonClicked];
    [self.daysMutArray removeAllObjects];
    self.daysMutArray = [self getAllDaysWithDate:_dateChooseView.datePicker.date];
    self.titleDate = _dateChooseView.datePicker.date;
}
/** Date Piker所在视图中的取消按钮点击事件 */
- (void)dateChooseViewCancelButtonClicked {
    [UIView animateWithDuration:0.2 animations:^{
        _dateChooseView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}
#pragma mark - 获取每次页面需要显示的日期模型数组
/** 通过当前日期，获取该月所需要显示的所有日期 */
- (NSMutableArray *)getAllDaysWithDate:(NSDate *)currentDate {
    NSMutableArray *tempArr = [NSMutableArray array];
    NSInteger count = [currentDate getDayCountInMonth];
    NSDate *firstDay = [currentDate getFirstDayInMonth];
    NSDate *lastDay = [currentDate getLastDayInMonth];
    // 添加当月所有的日期模型对象
    for (int i=0; i<count; i++) {
        NSDate *date = [NSDate dateWithTimeInterval:i*24*3600 sinceDate:firstDay];
        [tempArr addObject:[self getDateModelWithDate:date]];
    }
    // 根据当月第一天周几，补充上月日期模型对象
    int firstWeekDay = [firstDay weekdayInCurrentWeek];
    for (int i=1; i<=firstWeekDay-1; i++) {
        NSDate *date = [NSDate dateWithTimeInterval:-i*24*3600 sinceDate:firstDay];
        [tempArr insertObject:[self getDateModelWithDate:date] atIndex:0];
    }
    // 根据当月最后一天周几，补充下月日期模型对象
    int lastWeekDay = [lastDay weekdayInCurrentWeek];
    for (int i=1; i<=7-lastWeekDay; i++) {
        NSDate *date = [NSDate dateWithTimeInterval:i*24*3600 sinceDate:lastDay];
        [tempArr addObject:[self getDateModelWithDate:date]];
    }
    return tempArr;
}
- (DateModel *)getDateModelWithDate:(NSDate *)date {
    DateModel *model = [[DateModel alloc]init];
    model.date = date;
    model.year = [date getYear];
    model.month = [date getMonth];
    model.day = [date getDay];
    model.weedly = [date weekdayInCurrentWeek];
    model.lunarMonth = [date getLunarMonth];
    model.lunarDay = [date getLunarDay];
    return model;
}

#pragma mark - 监听事件
/// 切换月份请求数据，更新日历集合视图
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"titleDate"]) {
        self.titleView.dateLabel.text = [NSString stringWithFormat:@"%d年%d月",[self.titleDate getYear],[self.titleDate getMonth]];
        // 判断切换日期的方式，是否进行红色边框的显示
        if ([self.titleDateChangeType isEqualToString:@"datePicker"]) {
            self.selectDateModel = [self getDateModelWithDate:self.titleDate];
        }
        if ([self.titleDateChangeType isEqualToString:@"swipe"]) {
            self.selectDateModel = nil;
            NSDate *currentDate = [NSDate date];
            if ([self.titleDate getYear] == [currentDate getYear] && [self.titleDate getMonth] == [currentDate getMonth]) {
                self.selectDateModel = [self getDateModelWithDate:currentDate];
            }
        }
        [self collectionReloadData];
        
        [NSDate changeDateModelState:self.titleDate inDateArray:_daysMutArray];
    }
}


#pragma mark - 集合视图的代理方法
/** 重写集合视图的reload方法 */
- (void)collectionReloadData {
    self.bottomView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH-6)/7*_daysMutArray.count/7+titleHeight+8);
    self.titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, titleHeight);
    self.myCollectionView.frame = CGRectMake(0, titleHeight, SCREEN_WIDTH,(SCREEN_WIDTH-6)/7*_daysMutArray.count/7+5);
    
    CGFloat currentHeight = self.bottomView.frame.origin.y + self.bottomView.frame.size.height;
    self.myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, currentHeight+5);
    [self.myCollectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _daysMutArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDate *currentDate = [NSDate date];
    int currentMonth = [self.titleDate getMonth];
    DateModel *model = self.daysMutArray[indexPath.item];
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.tag = indexPath.item;
    
    cell.lunarLabel.text = model.lunarDay;
    cell.lunarLabel.textColor = [UIColor darkGrayColor];
    
    cell.label.text = [NSString stringWithFormat:@"%d",model.day];
    cell.label.textColor = [UIColor blackColor];
    cell.label.font = [UIFont systemFontOfSize:17];
    // 如果日期不在当月范围，则显示成灰色
    if (model.month != currentMonth) {
        cell.label.textColor = [UIColor darkGrayColor];
        cell.backgroundColor = [UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];
    }
    // 如果是周末，则显示成蓝色字体
    if (model.weedly == 1||model.weedly == 7) {
        cell.label.textColor = [UIColor greenColor];
        cell.lunarLabel.textColor =[UIColor greenColor];
    }
    // 如果是当天，则将cell的背景色改成蓝色
    if (model.year == [currentDate getYear] && model.month == [currentDate getMonth] && model.day == [currentDate getDay]) {
        cell.backgroundColor = [UIColor greenColor];
        cell.label.textColor = [UIColor whiteColor];
        cell.lunarLabel.textColor = [UIColor whiteColor];
    }
    // 如果是法定节假日，则显示为绿色字体，如果是法定调休日，则显示红色字体
    if ([model.status isEqualToString:@"1"]) {
        cell.label.textColor = [UIColor colorWithRed:50.0/255 green:205.0/255 blue:50.0/255 alpha:1];
        cell.lunarLabel.textColor = [UIColor colorWithRed:50.0/255 green:205.0/255 blue:50.0/255 alpha:1];
    }
    if ([model.status isEqualToString:@"2"]) {
        cell.label.textColor = [UIColor redColor];
        cell.lunarLabel.textColor = [UIColor redColor];
    }
    // cell的边框设置
    cell.layer.borderColor = cell.backgroundColor.CGColor;
    // 在当前显示的月份点击非本月日期时，进行跳转，记录所点击的日期进行对比
    if (_selectDateModel.year == model.year &&_selectDateModel.month == model.month && _selectDateModel.day == model.day) {
        cell.layer.borderColor = [UIColor redColor].CGColor;
        cell.layer.borderWidth = 1.5;
        _selectCell = cell;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    DateModel *model = self.daysMutArray[indexPath.item];
    _selectDateModel = model;
    // 点击不是当月的日期，跳转到点击日期所在的月份
    if (model.month != [self.titleDate getMonth]) {
        [self.daysMutArray removeAllObjects];
        self.daysMutArray = [self getAllDaysWithDate:model.date];
        self.titleDateChangeType = nil;
        self.titleDate = model.date;
        [self collectionReloadData];
    }
    if (_selectCell) {
        UIColor *col = _selectCell.backgroundColor;
        _selectCell.layer.borderColor = col.CGColor;
    }
    _selectCell = cell;
    _selectCell.layer.borderWidth = 1.5;
    _selectCell.layer.borderColor = [UIColor redColor].CGColor;
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
