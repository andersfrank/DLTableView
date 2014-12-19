
#import <UIKit/UIKit.h>

typedef void(^DrawBlock)(CGContextRef context, CGRect rect);

@interface DrawView : UIView

@property (nonatomic, copy) DrawBlock drawBlock;

@end
