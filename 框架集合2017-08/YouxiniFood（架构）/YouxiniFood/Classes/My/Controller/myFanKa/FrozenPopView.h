//
//  FrozenPopView.h
//  YouxiniFood
//
//  Created by youxin on 2017/8/3.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

////取消按钮点击事件
//typedef void(^cancelBlock)();
//
////确定按钮点击事件
//typedef void(^sureBlock)();

@interface FrozenPopView : UIView

@property(nonatomic,strong)UIButton  *closeBtn;
@property(nonatomic,strong)UIButton  *cancelBtn;
@property(nonatomic,strong)UIButton  *doneBtn;
@property (nonnull,strong) UILabel   *contentLa;

//@property(nonatomic,copy)cancelBlock cancel_block;
//@property(nonatomic,copy)sureBlock sure_block;
/**
 *  简书号：iOS_凯  http://www.jianshu.com/users/86b0ddc92021/latest_articles
 *
 *  @param title       标题
 *  @param content     内容
 *  @param cancel      取消按钮内容
 *  @param sure        确定按钮内容
 *  @param cancelBlock 取消按钮点击事件
 *  @param sureBlock   确定按钮点击事件
 *
 *  @return SZKAlterView
 */
//+(instancetype)alterViewWithTitle:(NSString *)title
//                          content:(NSString *)content
//                           cancel:(NSString *)cancel
//                             sure:(NSString *)sure
//                    cancelBtClcik:(cancelBlock)cancelBlock
//                      sureBtClcik:(sureBlock)sureBlock;
//
//@property(nonatomic,strong)UILabel    *titleLb;
//@property(nonatomic,strong)UILabel    *contentLb;
//@property(nonatomic,strong)UIButton  *cancelBt;
//@property(nonatomic,strong)UIButton  *sureBt;

@end
