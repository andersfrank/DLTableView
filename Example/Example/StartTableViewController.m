
#import "StartTableViewController.h"
#import "AboutTableViewController.h"
#import "DLTableView.h"
#import "LabelCell.h"

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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LabelCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSArray *cells = @[[self categoryCellItem:@"About page" action:@selector(aboutPageCellTapped)],
                       [self categoryCellItem:@"Conditionally hiding cells" action:@selector(conditionallyHidingExampleCellTapped)],
                       [self categoryCellItem:@"Expandable cells" action:@selector(expandableExampleCellTapped)],
                       [self categoryCellItem:@"Opt out example" action:@selector(optOutExampleCellTapped)]];

    
    // Setting the sections will also reload the tableview
    self.tableView.sections = @[[DLSectionItem itemWithCells:cells]];
    self.cells = cells;
}

- (DLCellItem *)categoryCellItem:(NSString *)title action:(SEL)action {
    return [DLCellItem itemWithModel:nil height:44 reuseIdentifier:@"LabelCell" target:self action:action willDisplay:^(DLCellItem *cellItem, UITableViewCell *cell) {
        cell.textLabel.text = title;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }];
}

- (void)aboutPageCellTapped {
    [self.navigationController pushViewController:[AboutTableViewController new] animated:YES];
}

- (void)conditionallyHidingExampleCellTapped {
    
}

- (void)expandableExampleCellTapped {
    
}

- (void)optOutExampleCellTapped {
    
}

@end
