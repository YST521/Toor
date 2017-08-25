//
//  AllOrderCell.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/1.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "AllOrderCell.h"
#import "OriderFoodCell.h"
#import "FoodFootView.h"

@implementation AllOrderCell{
    UIView *line;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    
    }

    return self;
}

-(void)creatUI{
    
    self.cellHight = 500;
    self.foodTabviewH = 420;

    
    
    self.backgroundColor = BgColor;
    self.bgView = [[UIView alloc]init];
    self.bgView.frame = CGRectMake(10, 10, SceneWidth-20, self.cellHight-10);
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.backgroundColor =[UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    //头部
    self.addressBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.addressBtn.frame = CGRectMake(10, 10, 150, 20);
//    [self.addressBtn setTitle:@"优信食堂优信食堂优信食堂优信食堂" forState:(UIControlStateNormal)];
//    [self.addressBtn setTitleColor:[UIColor colorWithHexStringg:@"#333333"] forState:(UIControlStateNormal)];
//    self.addressBtn.titleLabel.font =[UIFont systemFontOfSize:14];
//    [self.addressBtn setImage:[UIImage imageNamed:@"icon_dizhiguangli"] forState:(UIControlStateNormal)];
//    [self.addressBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
//    self.addressBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 150-17);
    [self.bgView addSubview:self.addressBtn];
    
//    self.addressBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.addressBtn addTarget:self action:@selector(addressBtnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    UIImageView *adressImageV = [[UIImageView alloc]init];
    adressImageV.frame = CGRectMake(0, 0, 20, 20);
    adressImageV.image = [UIImage imageNamed:@"icon_dizhiguangli"];
    [self.addressBtn addSubview:adressImageV];
    
    self.adressBtnLa =[[UILabel alloc]init];
    self.adressBtnLa.frame = CGRectMake(CGRectGetMaxX(adressImageV.frame)+5, 0, self.addressBtn.width - adressImageV.width, 20);
    self.adressBtnLa.font = [UIFont systemFontOfSize:14];
    self.adressBtnLa.textColor =[UIColor colorWithHexStringg:@"#333333"];
    [self.addressBtn addSubview:self.adressBtnLa];
    
    self.orderStatusLa =[[UILabel alloc]init];
    self.orderStatusLa.frame = CGRectMake(self.bgView.width-100, 10, 80, 20);
    self.orderStatusLa.textColor =[UIColor colorWithHexStringg:@"#999999"];
    self.orderStatusLa.font =[UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.orderStatusLa];
    
    line = [[UIView alloc]init];
    line.frame = CGRectMake(10, CGRectGetMaxY(self.orderStatusLa.frame)+5, self.bgView.width - 20, 0.5);
    line.backgroundColor = LineColor;
    [self.bgView addSubview:line];
  
    
    [self creatFoodTabview];
   //
//    self.foodTabview.backgroundColor =[UIColor blueColor];
    
    //底部总计
    UIView *bottomLine =[[UIView alloc]init];
    bottomLine.frame = CGRectMake(10,self.bgView.height-29.5 , self.bgView.width-20, 0.5);
    bottomLine.backgroundColor = LineColor;
    [self.bgView addSubview:bottomLine];
    

    self.totalLa =[[UILabel alloc]init];
    self.totalLa.frame = CGRectMake(20, self.bgView.height-30, self.bgView.width-20-10, 20);
    self.totalLa.font =[UIFont systemFontOfSize:14];
    self.totalLa.textAlignment = NSTextAlignmentRight;
    self.totalLa.textColor =[UIColor colorWithHexStringg:@"#999999"];
    [self.bgView addSubview:self.totalLa];
    
    
    
//    self.addressBtn.backgroundColor=[UIColor redColor];
//    self.totalLa.backgroundColor =[UIColor redColor];
    
    self.adressBtnLa.text = @"优信食堂优信食堂";
    self.orderStatusLa.text = @"等待取餐";
    self.totalLa.text = @"共3件商品，实付 ¥40.00";
    
    
    
}

- (void)addressBtnClickAction:(UIButton*)sender{

    //如果myButtonWillTap被实现啦，此时我们就实现myButtonWillTapf方法
    if ([self.OrcalCellQrDelegate respondsToSelector:@selector(allAddressClickAction:)]) {
        [self.OrcalCellQrDelegate allAddressClickAction:self];
    }

    
}

- (void)creatFoodTabview{
    
    self.foodTabview =[[UITableView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(line.frame)+2, self.bgView.width -20, self.foodTabviewH) style:(UITableViewStylePlain)];
    [self.bgView addSubview:self.foodTabview];
    self.foodTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.foodTabview.scrollEnabled = NO;
    self.foodTabview.dataSource = self;
    self.foodTabview.delegate = self;
    
    FoodFootView *footView =[[FoodFootView alloc]init];
    //高度等于分去数*二维码高度
    footView.frame = CGRectMake(0, self.foodTabview.height - 20, self.foodTabview.width, 60*2);
    self.foodTabview.tableFooterView = footView;

    footView.backgroundColor =[UIColor purpleColor];
    
    [footView.qrBtn2 addTarget:self action:@selector(qrClickAction) forControlEvents:(UIControlEventTouchUpInside)];
    
     [footView.qrBtn addTarget:self action:@selector(qrClickAction) forControlEvents:(UIControlEventTouchUpInside)];
   
}

-(void)qrClickAction{
    
    
    //如果myButtonWillTap被实现啦，此时我们就实现myButtonWillTapf方法
    if ([self.OrcalCellQrDelegate respondsToSelector:@selector(qrBtnClickAction:)]) {
        [self.OrcalCellQrDelegate qrBtnClickAction:self];
    }
    NSLog(@"***6666 **qr*******");
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[[UIView alloc]init];
    view.frame = CGRectMake(0, 0, self.bgView.width, 30);
    view.backgroundColor =[UIColor whiteColor];
    self.squreView = [[UIView alloc] initWithFrame:CGRectMake(11, 10, 18, 13)];

    self.squreView.layer.cornerRadius = 3;
    self.squreView.clipsToBounds = YES;
    [view addSubview:self.squreView];
    
    self.dateLa =[[UILabel alloc]init];
    self.dateLa.frame = CGRectMake(CGRectGetMaxX(self.squreView.frame)+10, self.squreView.originY, 150, 13);
    self.dateLa.textColor =[UIColor colorWithHexStringg:@"#666666"];
    [view addSubview:self.dateLa];
    
    //
//      view.backgroundColor =[UIColor greenColor];
   
    if (section == 0) {
            self.dateLa.text = @"早餐";
         self.squreView.backgroundColor =SquareColorCyan;
    } else {
            self.dateLa.text = @"午餐";
         self.squreView.backgroundColor =SquareColorOrange;
    }

    
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   OriderFoodCell *cell =[self.foodTabview dequeueReusableCellWithIdentifier:@"foodCell"];
    if (!cell) {
        cell =[[OriderFoodCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"foodCell"];
    }
    //取消点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = @"3424536457";
    return cell;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
// self.bgView.frame = CGRectMake(10, 10, SceneWidth-20, self.cellHight-10);
// self.addressBtn.frame = CGRectMake(10, 10, self.bgView.width/2, 20);
  
    
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
