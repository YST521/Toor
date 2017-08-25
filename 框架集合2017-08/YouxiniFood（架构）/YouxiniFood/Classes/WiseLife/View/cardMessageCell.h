//
//  cardMessageCell.h
//  YouxiniFood
//
//  Created by 何青 on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol cardMessageCellDeleagte <NSObject>

- (void)typeBtnDidSelectWithtype:(BOOL)type;

@end

@interface cardMessageCell : UICollectionViewCell<UITextFieldDelegate>

@property (nonatomic,strong)UILabel *accountLable;
@property (nonatomic,strong)UILabel *numLable;
@property (nonatomic,strong)UILabel *messageLable;

@property (nonatomic,strong)UITextField *accountTf;
@property (nonatomic,strong)UITextField *numTf;
@property (nonatomic,strong)UITextField *messageTf;

@property (nonatomic,strong)UIButton *typeBtn;

@property (nonatomic,assign)id <cardMessageCellDeleagte>delegate;

- (void)refreshUIWithArr:(NSArray *)titleArr withMessageArr:(NSArray*)messageArr withTSArr:(NSArray *)tsArr btnSelect:(BOOL)select;

@end
