//
//  FrozenPopView.m
//  YouxiniFood
//
//  Created by youxin on 2017/8/3.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "FrozenPopView.h"

@implementation FrozenPopView{

    UIView *popView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    self.backgroundColor =[UIColor colorWithWhite:0.0 alpha:0.3];
    
    popView  = [[UIView alloc]init];
    if (SceneHeight>600) {
    popView.frame = CGRectMake(40, SceneHeight*0.25, SceneWidth-80, SceneHeight*0.3);
    }else{
        popView.frame = CGRectMake(20, SceneHeight*0.25, SceneWidth-40, SceneHeight*0.32);
    }
    popView.backgroundColor = [UIColor whiteColor];
    popView.layer.cornerRadius = 8 ;
    popView.clipsToBounds = YES;
    [self addSubview:popView];
   
    UILabel *titleLa =[[UILabel alloc]init];
    titleLa.frame = CGRectMake(20, 30, popView.width - 40, 20);
    titleLa.text = @"温馨提示";
    titleLa.textAlignment = NSTextAlignmentCenter;
    [popView addSubview:titleLa];
    
    self.closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.closeBtn.frame = CGRectMake(popView.width-30, 10, 15, 15);
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"icon_guanbi"] forState:(UIControlStateNormal)];
    [popView addSubview:self.closeBtn];
    
   self.contentLa =[[UILabel alloc]init];
      if (SceneHeight>600) {
    self.contentLa.frame = CGRectMake(20, CGRectGetMaxY(self.closeBtn.frame)+30, popView.width -40, 60);
      }else{
       self.contentLa.frame = CGRectMake(20, CGRectGetMaxY(self.closeBtn.frame)+30, popView.width -40, 40);
      }
    self.contentLa.text = @"是否确定冻结饭卡？";
    self.contentLa.textColor =[UIColor colorWithHexStringg:@"#666666"];
    self.contentLa.textAlignment = NSTextAlignmentCenter;
    [popView addSubview:self.contentLa];
    
    
    self.cancelBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    if (SceneHeight>600) {
         self.cancelBtn.frame = CGRectMake(20, CGRectGetMaxY(self.contentLa.frame)+40, (popView.width-40 -20)/2-10, 45);
    } else {
         self.cancelBtn.frame = CGRectMake(20, CGRectGetMaxY(self.contentLa.frame)+20, (popView.width-40 -20)/2-5, 40);
    }
        
   
    self.cancelBtn.layer.cornerRadius = 8;
    self.cancelBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.borderWidth = 0.5;
    self.cancelBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [self.cancelBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
    [popView addSubview:self.cancelBtn];
    
    self.doneBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    if (SceneHeight>600) {
   self.doneBtn.frame = CGRectMake((popView.width-40 -20)/2+30, CGRectGetMaxY(self.contentLa.frame)+40, (popView.width-40 -20)/2-5, 45);
    }else{
     self.doneBtn.frame = CGRectMake((popView.width-40 -20)/2+25, CGRectGetMaxY(self.contentLa.frame)+20, (popView.width-40 -20)/2-5, 40);
    }
   self.doneBtn.layer.cornerRadius = 8;
    self.doneBtn.layer.masksToBounds = YES;
    self.doneBtn.layer.borderWidth = 0.5;
    self.doneBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.doneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
      [self.doneBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
    [popView addSubview:self.doneBtn];

}




//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self=[super initWithFrame:frame];
//    if (self) {
//        //标题
//        _titleLb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
//        _titleLb.textAlignment=NSTextAlignmentCenter;
//        _titleLb.textColor=[UIColor blackColor];
//        [self addSubview:_titleLb];
//        //内容
//        _contentLb=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLb.frame), self.bounds.size.width, 50)];
//        _contentLb.textAlignment=NSTextAlignmentCenter;
//        _contentLb.textColor=[UIColor redColor];
//        [self addSubview:_contentLb];
//        //取消按钮
//        _cancelBt=[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_contentLb.frame), self.bounds.size.width/2, 50)];
//        _cancelBt.layer.borderColor=[UIColor grayColor].CGColor;
//        _cancelBt.layer.borderWidth=0.5;
//        [_cancelBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_cancelBt addTarget:self action:@selector(cancelBtClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_cancelBt];
//        //确定按钮
//        _sureBt=[[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, CGRectGetMaxY(_contentLb.frame), self.bounds.size.width/2, 50)];
//        _sureBt.layer.borderColor=[UIColor grayColor].CGColor;
//        _sureBt.layer.borderWidth=0.5;
//        [_sureBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_sureBt addTarget:self action:@selector(sureBtClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_sureBt];
//    }
//    return self;
//}
//#pragma mark----实现类方法
//+(instancetype)alterViewWithTitle:(NSString *)title
//                          content:(NSString *)content
//                           cancel:(NSString *)cancel
//                             sure:(NSString *)sure
//                    cancelBtClcik:(cancelBlock)cancelBlock
//                      sureBtClcik:(sureBlock)sureBlock;
//{
//   FrozenPopView *alterView=[[FrozenPopView alloc]initWithFrame:CGRectMake(0, 0, 250, 150)];
//    alterView.backgroundColor=[UIColor whiteColor];
//
//    alterView.center=CGPointMake(SceneWidth/2, SceneHeight/2);
//    alterView.layer.cornerRadius=5;
//    alterView.layer.masksToBounds=YES;
//    alterView.title=title;
//    alterView.content=content;
//    alterView.cancel=cancel;
//    alterView.sure=sure;
//    alterView.cancel_block=cancelBlock;
//    alterView.sure_block=sureBlock;
//    return alterView;
//}
//#pragma mark--给属性重新赋值
//-(void)setTitle:(NSString *)title
//{
//    _titleLb.text=title;
//}
//-(void)setContent:(NSString *)content
//{
//    _contentLb.text=content;
//}
//-(void)setSure:(NSString *)sure
//{
//    [_sureBt setTitle:sure forState:UIControlStateNormal];
//}
//-(void)setCancel:(NSString *)cancel
//{
//    [_cancelBt setTitle:cancel forState:UIControlStateNormal];
//}
//#pragma mark----取消按钮点击事件
//-(void)cancelBtClick
//{
//    [self removeFromSuperview];
//    self.cancel_block();
//}
//#pragma mark----确定按钮点击事件
//-(void)sureBtClick
//{
//    [self removeFromSuperview];
//    self.sure_block();
//}
//
//

@end
