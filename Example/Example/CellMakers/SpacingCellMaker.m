
#import "SpacingCellMaker.h"

NSString * const kReuseIdentifier = @"SpacingCellMakerCellReuseIdentifier";

@implementation SpacingCellMaker

+ (void)registerCellClasses:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifier];
}

+ (DLCellItem *)cellWithHeight:(CGFloat)height backgroundColor:(UIColor *)backgroundColor {
    DLCellItem *cellItem = [DLCellItem new];
    cellItem.reuseIdentifier = kReuseIdentifier;
    cellItem.height = height;
    cellItem.willDisplayBlock = ^(DLCellItem *cellItem, UITableViewCell *cell) {
        cell.backgroundColor = backgroundColor;
    };
    return cellItem;
}

@end
