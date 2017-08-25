//
//  UserMessageCell.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/2.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "UserMessageCell.h"

@implementation UserMessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
    self.titleLa = [[UILabel alloc]init];
    self.titleLa.frame = CGRectMake(20, 0, 100, 20);
    self.titleLa.centerY = self.contentView.centerY;
    self.titleLa.font =[UIFont systemFontOfSize:14];
    self.titleLa.textColor =[UIColor colorWithHexStringg:@"#666666"];
    [self.contentView addSubview:self.titleLa];
    
    self.contentLa = [[UILabel alloc]init];
     self.contentLa.frame = CGRectMake(105, 0, SceneWidth-120-25, 20);
     self.contentLa.centerY = self.contentView.centerY;
//    self.contentLa.numberOfLines = 0;
    if (SceneWidth>370) {
            self.contentLa.font =[UIFont systemFontOfSize:14];
    } else {
            self.contentLa.font =[UIFont systemFontOfSize:13];
    }
   self.contentLa.adjustsFontSizeToFitWidth = YES;
     self.contentLa.textColor =[UIColor colorWithHexStringg:@"#999999"];
    self.contentLa.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview: self.contentLa];
    
    self.rightImageV = [[UIImageView alloc]init];
    self.rightImageV.frame = CGRectMake( SceneWidth-25, 0, 8, 15);
     self.rightImageV.centerY = self.contentView.centerY;
    self.rightImageV.image =[UIImage imageNamed:@"icon_xianghou"];
    [self.contentView addSubview:self.rightImageV];
    
    
//    if ([self.titleLa.text isEqualToString:@"卡号(非必填)"]) {
//        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"卡号(非必填)"];
//        
//        [AttributedStr addAttribute:NSFontAttributeName
//         
//                              value:[UIFont systemFontOfSize:14.0]
//         
//                              range:NSMakeRange(3, 2)];
//        
//        [AttributedStr addAttribute:NSForegroundColorAttributeName
//         
//                              value:[UIColor redColor]
//         
//                              range:NSMakeRange(3, 2)];
//        
//         self.titleLa.attributedText = AttributedStr;
//        
//    }
    
    //
    self.titleLa.text = @"工厂名称";
    self.contentLa.text = @"广东优信无限网络股份有限公司";
//    self.rightImageV.backgroundColor =[UIColor greenColor];
    
    
    
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
