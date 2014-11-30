
//
//  AboutTableView.m
//  Example
//
//  Created by Anders Frank on 2014-11-11.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import "DLTableView.h"
#import "LabelCell.h"
#import "AboutTableViewController.h"

static const CGFloat kSideMargin = 10;

@implementation AboutTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    DLTableView *tableView = [DLTableView new];
    [tableView registerClass:[LabelCell class] forCellReuseIdentifier:@"LabelCell"];
    [tableView registerClass:[LabelCell class] forCellReuseIdentifier:@"BulletCell"];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SpacingCell"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    DLTableView *tableView = (DLTableView *)self.tableView;
    
    NSMutableArray *cells = [NSMutableArray new];
    
    [cells addObject:[self spacingItem:5]];
    [cells addObject:[self headerItem:@"DLTableView"]];
    [cells addObject:[self spacingItem:5]];
    [cells addObject:[self textItem:@"The table view was designed to render items in a list on a device with were processing power was limited. The use case's for have expanded but the table view class looks more or less the same."]];
    [cells addObject:[self spacingItem:5]];
    [cells addObject:[self textItem:@"A lot of common use cases the table view handles poorly. For example rendering multi line text. Because DLTableView no longer forces you to book keep index paths, a view can be built up by combining smaller cell elements. And what was once difficult becomes trivially simple."]];
    [cells addObject:[self spacingItem:5]];

    tableView.sections = @[[DLSectionItem itemWithCells:cells]];
    
    
}

- (DLCellItem *)headerItem:(NSString *)text {
    return [self cellItem:text withFont:[UIFont boldSystemFontOfSize:18] textAlignment:NSTextAlignmentCenter];
}

- (DLCellItem *)textItem:(NSString *)text {
    return [self cellItem:text withFont:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft];
}

- (DLCellItem *)spacingItem:(CGFloat)height {
    DLCellItem *item = [DLCellItem new];
    item.reuseIdentifier = @"SpacingCell";
    item.height = height;
    return item;
}

- (DLCellItem *)cellItem:(NSString *)text withFont:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    
    DLCellItem *item = [DLCellItem new];
    item.reuseIdentifier = @"LabelCell";
    UIEdgeInsets margins = UIEdgeInsetsMake(0, kSideMargin, 0, kSideMargin);
    item.height = [LabelCell cellHeightWithText:text tableViewWidth:[UIScreen mainScreen].bounds.size.width margins:margins font:font];
    item.willDisplayBlock = ^(DLCellItem *cellItem, UITableViewCell *cell) {
        LabelCell *c = (LabelCell *)cell;
        c.label.text = text;
        c.label.font = font;
        c.label.textAlignment = textAlignment;
        c.margins = margins;
    };
    
    return item;
}

@end
