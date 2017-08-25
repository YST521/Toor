//
//  PaibanheadView.m
//  WiseAPP
//
//  Created by app on 16/12/14.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "PaibanheadView.h"
#import "PaibanheadeModel.h"

@interface PaibanheadView ()


//@property (nonatomic, strong) UILabel *titleLabel;
@property(nonatomic,strong)UILabel* gongshiLa;


@end

@implementation PaibanheadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        self.userInteractionEnabled=YES;
        
        self.arrowImageView = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.arrowImageView setImage:[UIImage imageNamed:@"home_paiban_btn"] forState:(UIControlStateNormal)];
        self.arrowImageView.frame = CGRectMake(SCREEN_WIDTH/3*2-PROPORTION_WIDTH(40),STANDRD_H_20_y, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
        [self.contentView addSubview:self.arrowImageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(onExpand:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        button.frame = CGRectMake(0, 0, w/3*2-PROPORTION_WIDTH(45), PROPORTION_HIGHT(45));
        //button.backgroundColor=[UIColor redColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, PROPORTION_HIGHT(10/2), PROPORTION_WIDTH(150), PROPORTION_HIGHT(20))];
        self.titleLabel.textColor =textCententColor;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
        self.contentView.backgroundColor = [UIColor whiteColor];
//        //gongshi label
//        self.gongshiLa=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame)+2, self.titleLabel.width, PROPORTION_HIGHT(13))];
//        self.gongshiLa.textColor =textCententColor;
//        self.gongshiLa.font =[UIFont systemFontOfSize:12];
//        [self.contentView addSubview:self.gongshiLa];
//        
//        //分割线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, PROPORTION_HIGHT(45) - 0.5, w, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
    }
    
    return self;
}

- (void)setModel:(PaibanheadeModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    
    if (model.isExpanded) {
        self.arrowImageView.transform = CGAffineTransformIdentity;
    } else {
        self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    
    self.gongshiLa.text =model.gongshititle;
    self.titleLabel.text = model.sectionTitle;
    if ([self.titleLabel.text isEqualToString:@"去申请工时"]) {
        self.titleLabel.textColor=[UIColor redColor];
        UIView*view=[[UIView alloc]init];
        view.frame=CGRectMake(self.titleLabel.x-10, self.titleLabel.height-1, PROPORTION_WIDTH(80), 1);
        view.backgroundColor=[UIColor redColor];
        [self.titleLabel addSubview:view];
    }
    
}

- (void)onExpand:(UIButton *)sender {
    self.model.isExpanded = !self.model.isExpanded;
    
    [UIView animateWithDuration:0.25 animations:^{
        if (self.model.isExpanded) {
            self.arrowImageView.transform = CGAffineTransformIdentity;
        } else {
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
    }];
    
    if (self.expandCallback) {
        self.expandCallback(self.model.isExpanded);
    }
}

@end
