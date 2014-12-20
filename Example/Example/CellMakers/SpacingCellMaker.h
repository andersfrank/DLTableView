
#import <Foundation/Foundation.h>
#import "DLCellItem.h"

@interface SpacingCellMaker : NSObject

+ (void)registerCellClasses:(UITableView *)tableView;
+ (DLCellItem *)cellWithHeight:(CGFloat)height backgroundColor:(UIColor *)backgroundColor;

@end
