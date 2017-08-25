//
//  DiancanCell1.m
//  iFood
//
//  Created by 何青 on 2017/7/26.
//  Copyright © 2017年 何青. All rights reserved.
//

#import "DiancanCell1.h"

@implementation DiancanCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (_showGuige) {
        _guigeBtn.hidden = NO;
        _addBtn.hidden = YES;
        _yudingLable.hidden = YES;
    }
    if (_showAdd) {
        _guigeBtn.hidden = YES;
        _addBtn.hidden = NO;
        _yudingLable.hidden = YES;
    }
    if (_showYuding) {
        _guigeBtn.hidden = YES;
        _addBtn.hidden = YES;
        _yudingLable.hidden = NO;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

- (IBAction)guigeBtnAction:(UIButton *)sender {
    _ggblock(_section,_row);
//    if ([self.delegate respondsToSelector:@selector(clickGuigeButtonWithSelectSection:withRow:)]) {
//        [self.delegate clickGuigeButtonWithSelectSection:_section withRow:_row];
//    }
}

- (IBAction)addBtnAction:(UIButton *)sender {
    self.number +=1;
    _addblock(_section,_row,_number);
//    if ([self.delegate respondsToSelector:@selector(addFoodWithIndex:andSection:withButtomFrame:)]) {
//        [self.delegate addFoodWithIndex:_row andSection:_section withButtomFrame:sender.frame];
//    }
}
@end
