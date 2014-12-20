
#import "LabelCellMaker.h"

NSString * const kLabelCellMakerCellReuseIdentifier = @"LabelCellMakerCellReuseIdentifier";

@interface LabelCellMaker ()

@property (nonatomic) UIFont *font;
@property (nonatomic) UIColor *textColor;
@property (nonatomic, assign) UIEdgeInsets margins;

@end

@implementation LabelCellMaker

- (instancetype)initWithFont:(UIFont *)font textColor:(UIColor *)textColor margins:(UIEdgeInsets)margins
{
    self = [super init];
    if (self) {
        self.font = font;
        self.textColor = textColor;
        self.margins = margins;
    }
    return self;
}

+ (void)registerCellClasses:(UITableView *)tableView {
    [tableView registerClass:[LabelCell class] forCellReuseIdentifier:kLabelCellMakerCellReuseIdentifier];
}

- (DLCellItem *)cellItemWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor cellWidth :(CGFloat)cellWidth {
    DLCellItem *cellItem = [DLCellItem new];
    cellItem.reuseIdentifier = kLabelCellMakerCellReuseIdentifier;
    cellItem.height = [LabelCell cellHeightWithText:text tableViewWidth:cellWidth margins:self.margins font:self.font];
    cellItem.willDisplayBlock = ^(DLCellItem *cellItem, UITableViewCell *cell) {
        LabelCell *c = (LabelCell *)cell;
        cell.backgroundColor = backgroundColor;
        c.label.font = [self.font copy];
        c.label.text = text;
        c.label.textAlignment = textAlignment;
        c.label.textColor = [self.textColor copy];
        c.margins = self.margins;
    };
    return cellItem;
}

@end
