//
//  PublicCell.m
//  MVVMTest
//
//  Created by 李泽鲁 on 15/1/8.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "PublicCell.h"
#import "Tools.h"

@interface PublicCell ()
//@property (strong, nonatomic) IBOutlet UILabel *userName;
//@property (strong, nonatomic) IBOutlet UILabel *date;
//@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
//@property (strong, nonatomic) IBOutlet UITextView *weiboText;
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong)UITextView *weiboText;
@end

@implementation PublicCell

- (void)setValueWithDic:(PublicModel *) publicModel {
//    _userName.text = publicModel.userName;
//    _date.text = publicModel.date;
//    _weiboText.text = publicModel.text;
//    self.contentView.backgroundColor =[UIColor greenColor];
    
    self.headImageView =[[UIImageView alloc]init];
    self.headImageView.frame = CGRectMake(10, 10, self.contentView.frame.size.width/3-20, self.contentView.frame.size.height-20);
    [self.contentView addSubview:self.headImageView];
    
    [_headImageView sd_setImageWithURL:publicModel.imageUrl];
    
    self.weiboText =[[UITextView alloc]init];
    self.weiboText.frame = CGRectMake(150, 10, 150, 80);
    [self.contentView addSubview:self.weiboText];
     _weiboText.text = publicModel.text;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
