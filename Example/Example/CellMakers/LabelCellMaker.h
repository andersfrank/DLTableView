
#import <Foundation/Foundation.h>
#import "DLCellItem.h"
#import "LabelCell.h"

@interface LabelCellMaker : NSObject

- (instancetype)initWithFont:(UIFont *)font textColor:(UIColor *)textColor margins:(UIEdgeInsets)margins;

+ (void)registerCellClasses:(UITableView *)tableView;

- (DLCellItem *)cellItemWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor cellWidth:(CGFloat)cellWidth;

@end
