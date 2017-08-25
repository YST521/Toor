


#import <UIKit/UIKit.h>

@interface QFDatePickerView : UIView

- (instancetype)initDatePackerWithResponse:(void(^)(NSString*))block;

- (void)show;

@end
