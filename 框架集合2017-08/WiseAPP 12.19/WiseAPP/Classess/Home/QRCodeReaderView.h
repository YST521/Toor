//
//  QRCodeReaderView.h
//  MfpQRCode
//
//  Created by 浙江梦之想 on 16/3/30.
//  Copyright © 2016年 浙江梦之想. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QRCodeReaderViewDelegate <NSObject>
- (void)readerScanResult:(NSString *)result;
@end
@interface QRCodeReaderView : UIView


@property (nonatomic, weak) id<QRCodeReaderViewDelegate> delegate;
@property (nonatomic,copy)UIImageView * readLineView;
@property (nonatomic,assign)BOOL is_Anmotion;
@property (nonatomic,assign)BOOL is_AnmotionFinished;

//开启关闭扫描
- (void)start;
- (void)stop;

- (void)loopDrawLine;//初始化扫描线

@end
