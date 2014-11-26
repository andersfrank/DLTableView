
#import "StartTableViewController.h"

#import "DLTableView.h"
#import <malloc/malloc.h>

@interface StartTableViewController ()

@property (nonatomic, readonly) DLTableView *tableView;
@property (nonatomic, strong) NSArray *cells;

@end


@implementation StartTableViewController

- (void)loadView {
    self.tableView = [DLTableView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    NSArray *cells = @[[self categoryCellItem:@"About page" action:@selector(aboutPageCellTapped)],
//                       [self categoryCellItem:@"Conditionally hiding example" action:@selector(conditionallyHidingExampleCellTapped)],
//                       [self categoryCellItem:@"Expandable cells" action:@selector(expandableExampleCellTapped)]];

    NSMutableArray *cells = [NSMutableArray new];
    for (int i = 0; i < 100000; i++) {
        [cells addObject:[self categoryCellItem:@"This is a a cell with a label" action:nil]];
    }
    
//    TBLCellItem *item1 = [self categoryCellItem:@"This is a a cell with a label" action:nil];
//    TBLCellItem *item2 = [self categoryCellItem:@"This is a a cell with a label" action:nil];
//    
//    
//    NSLog(@"size of item1: %zd", malloc_size((__bridge const void *)(item1)));
//    NSLog(@"size of item2: %zd", malloc_size((__bridge const void *)(item2)));
    
    // Setting the sections will also reload the tableview
    self.tableView.sections = @[[DLSectionItem itemWithCells:cells]];
    self.cells = cells;
}

- (DLCellItem *)categoryCellItem:(NSString *)title action:(SEL)action {
    return [DLCellItem itemWithModel:nil height:44 reuseIdentifier:@"UITableViewCell" target:self action:action willDisplay:^(DLCellItem *cellItem, UITableViewCell *cell) {
        cell.textLabel.text = title;
        cell.textLabel.textColor = [UIColor blackColor];
    }];
}

- (void)aboutPageCellTapped {
    
}

- (void)conditionallyHidingExampleCellTapped {
    
}

- (void)expandableExampleCellTapped {
    
}

@end
