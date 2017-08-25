//
//  BanciTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/10/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BanciTableViewCell.h"

@implementation BanciTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}
-(void)addView{
    
    self.titleLabel=[[UILabel alloc]init ];
                     self.titleLabel.frame= CGRectMake(0, 0, self.contentView.width/3,  self.contentView.height);
    //self.titleLabel.backgroundColor=[UIColor redColor];
    [ self.contentView addSubview:self.titleLabel];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.starTime=[[UILabel alloc]init];
        self.starTime.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame),0, 100, self.contentView.height);
    //self.starTime.backgroundColor=[UIColor greenColor];
    [ self.contentView addSubview:self.starTime];
    self.starTime.textAlignment =NSTextAlignmentCenter;
//
    self.endTimeLabel=[[UILabel alloc]init];
                     self.endTimeLabel.frame = CGRectMake( CGRectGetMaxX(self.starTime.frame)+5, CGRectGetMaxY(self.starTime.frame),  self.contentView.width/2, 120);
    //self.endTimeLabel.backgroundColor=[UIColor yellowColor];
    [ self.contentView addSubview:self.endTimeLabel];
    
    self.editorImage=[UIImage imageNamed:@"home_editor"];
    self.editorBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
      self.editorBtn.frame =CGRectMake(self.contentView.width-30, STANDRD_H_20_y, 20, self.editorImage.size.width);
    //self.editorBtn.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.editorBtn];
    //[self.editorBtn addTarget:self action:@selector(editorBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.editorBtn setImage:self.editorImage forState:(UIControlStateNormal)];
    

}
-(void)layoutSubviews{
    [super layoutSubviews];
    
   self.titleLabel.frame= CGRectMake(0, 0, self.contentView.width/3,  self.contentView.height);
    
    self.starTime.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame),0,80, self.contentView.height);
    self.endTimeLabel.frame = CGRectMake( CGRectGetMaxX(self.starTime.frame)+5, 0,  120, self.contentView.height);
    
//    self.starTime.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+2, self.contentView.width/2, 30);
//    self.endTimeLabel.frame = CGRectMake( self.contentView.width/2, self.starTime.y,  self.contentView.width/2, 30);
    self.editorImage=[UIImage imageNamed:@"home_editor"];
    self.editorBtn.frame =CGRectMake(self.contentView.width-30, STANDRD_H_20_y, 20, self.editorImage.size.width);

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
