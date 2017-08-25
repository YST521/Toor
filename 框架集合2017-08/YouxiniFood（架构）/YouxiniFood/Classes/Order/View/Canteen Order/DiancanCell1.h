//
//  DiancanCell1.h
//  iFood
//
//  Created by 何青 on 2017/7/26.
//  Copyright © 2017年 何青. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^addFoodBlock)(NSInteger row,NSInteger section,NSInteger number);
typedef void (^guigeBlock)(NSInteger row,NSInteger section);
//@protocol DiancanCell1Delegate <NSObject>
//
//- (void)addFoodWithIndex:(NSInteger)row andSection:(NSInteger)section withButtomFrame:(CGRect)frame;
//- (void)clickGuigeButtonWithSelectSection:(NSInteger)section withRow:(NSInteger)row;
//@end

@interface DiancanCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *residueLable;
@property (weak, nonatomic) IBOutlet UILabel *watchLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *discountLable;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *guigeBtn;
@property (weak, nonatomic) IBOutlet UILabel *yudingLable;
@property (nonatomic,assign) BOOL showYuding;
@property (nonatomic,assign) BOOL showAdd;
@property (nonatomic,assign) BOOL showGuige;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,assign) NSInteger section;
//@property (nonatomic,assign) id <DiancanCell1Delegate>delegate;
@property (nonatomic,copy) addFoodBlock addblock;
@property (nonatomic,copy) guigeBlock ggblock;
- (IBAction)guigeBtnAction:(UIButton *)sender;
- (IBAction)addBtnAction:(UIButton *)sender;
@property (assign, nonatomic) NSUInteger number;

@end
