//
//  StartViewController.m
//  Example
//
//  Created by Anders Frank on 2014-12-19.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import "StartViewController.h"
#import "DLTableView.h"
#import "CategoryCell.h"
#import "ToDoViewController.h"
#import "MoveableCellsViewController.h"

@interface StartViewController ()
@property (nonatomic, readonly) DLTableView *tableView;
@end

@implementation StartViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.title = @"Examples";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *cells = @[
                       [self cateoryCellItem:@"To-Do List" tapAction:@selector(toDoCellTapped)],
                       [self cateoryCellItem:@"Moveable cells" tapAction:@selector(moveableExampleCellTapped)]
                       ];
    
    self.tableView.sections = @[[DLSectionItem itemWithCells:cells]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    navBar.tintColor = [UIColor whiteColor];
    navBar.barTintColor = [UIColor colorWithRed:0.000 green:0.753 blue:0.616 alpha:1];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    navBar.translucent = NO;
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
}

- (DLCellItem *)cateoryCellItem:(NSString *)text tapAction:(SEL)action {
    return [DLCellItem itemWithModel:nil height:64 reuseIdentifier:@"CategoryCell" target:self action:action willDisplay:^(DLCellItem *cellItem, UITableViewCell *cell) {
        CategoryCell *c = (CategoryCell *)cell;
        c.label.text = text;
    }];
}

- (void)toDoCellTapped {
    ToDoViewController *vc = [[ToDoViewController alloc] initWitViewModel:[ToDoViewModel new]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)moveableExampleCellTapped {
    MoveableCellsViewController *vc = [MoveableCellsViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
                                

@end
