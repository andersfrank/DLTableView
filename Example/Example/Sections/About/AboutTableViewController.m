
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
    self.view = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    DLTableView *tableView = (DLTableView *)self.tableView;
    
    
    NSMutableArray *cells = [NSMutableArray new];

    [cells addObject:[self headerItem:@"About"]];
    [cells addObject:[self textItem:@"The goal of TBLView is to make it easier and less of a mental burden to work with table views."]];
    [cells addObject:[self spacingItem:5]];
    
    [cells addObject:[self headerItem:@"Selling points"]];
    [cells addObject:[self textItem:@"It solves the complex problem of conditionally hide cells and sections."]];
    [cells addObject:[self spacingItem:5]];
    
    
    
    tableView.sections = @[[DLSectionItem itemWithCells:@[cells]]];
    
    
}

- (DLCellItem *)headerItem:(NSString *)text {
    return [self cellItem:text withFont:[UIFont boldSystemFontOfSize:18]];
}

- (DLCellItem *)textItem:(NSString *)text {
    return [self cellItem:text withFont:[UIFont systemFontOfSize:16]];
}

- (DLCellItem *)bulletItem:(NSString *)text {
 
//    [self cellItem:text withFont:[UIFont systemFontOfSize:16]];
//    TBLCellItem *item = [TBLCellItem new];
//    item.reuseIdentifier = @"BulletCell";
//    UIEdgeInsets margins = UIEdgeInsetsMake(0, 2 * kSideMargin, 0, kSideMargin);
//    item.height = [LabelCell cellHeightWithText:text tableViewWidth:CGRectGetWidth(self.view.bounds) margins:margins font:font];
//    item.willDisplayBlock = ^(TBLCellItem *cellItem, UITableViewCell *cell) {
//        LabelCell *c = (LabelCell *)cell;
//        c.label.text = text;
//        c.label.font = font;
//    };

    return nil;
}

- (DLCellItem *)spacingItem:(CGFloat)height {
    DLCellItem *item = [DLCellItem new];
    item.reuseIdentifier = @"SpacingCell";
    item.height = height;
    return item;
}

- (DLCellItem *)cellItem:(NSString *)text withFont:(UIFont *)font {
    
    DLCellItem *item = [DLCellItem new];
    item.reuseIdentifier = @"LabelCell";
    UIEdgeInsets margins = UIEdgeInsetsMake(0, kSideMargin, 0, kSideMargin);
    item.height = [LabelCell cellHeightWithText:text tableViewWidth:CGRectGetWidth(self.view.bounds) margins:margins font:font];
    item.willDisplayBlock = ^(DLCellItem *cellItem, UITableViewCell *cell) {
        LabelCell *c = (LabelCell *)cell;
        c.label.text = text;
        c.label.font = font;
    };
    
    return item;
}

@end
