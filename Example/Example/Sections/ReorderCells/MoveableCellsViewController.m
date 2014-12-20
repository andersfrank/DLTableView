
#import "MoveableCellsViewController.h"
#import "DLTableView.h"
#import "LabelCell.h"
#import "NSArray+Map.h"

NSString * const kNumbersDefaultsKey = @"kNumbersDefaultsKey";

@interface MoveableCellsViewController () <DLTableViewDelegate>

@property (nonatomic) DLTableView *tableView;
@property (nonatomic) NSMutableArray *numbers;

@end

@implementation MoveableCellsViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.title = @"Moveable Cells";
       
        // Register default values
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{kNumbersDefaultsKey : @[@"One", @"Two", @"Three", @"Four", @"Five"]}];
        
        // Load from defaults
        self.numbers = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:kNumbersDefaultsKey]];

    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [DLTableView new];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = [UIColor colorWithWhite:230 / 255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.editing = YES;
    self.tableView.tableViewDelegate = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MoveableCell"];
    
    // Map to cells.
    NSArray *cells = [self.numbers arrayByMappingWithBlock:^id(NSString *title) {
        DLCellItem *cellItem = [DLCellItem new];
        cellItem.reuseIdentifier = @"MoveableCell";
        cellItem.editingStyle = UITableViewCellEditingStyleNone;
        cellItem.canMove = YES;
        cellItem.shouldIndentWhileEditing = NO;
        cellItem.model = title;
        cellItem.willDisplayBlock = ^(DLCellItem *cellItem, UITableViewCell *cell) {
            cell.textLabel.text = title;
        };
        return cellItem;
    }];
                      
    self.tableView.sections = @[[DLSectionItem itemWithCells:cells]];
    
}

#pragma mark - DLTableViewDelegate

- (void)tableView:(DLTableView *)tableView
  cellItemDidMove:(DLCellItem *)cellItem
          fromRow:(NSUInteger)oldRow
            toRow:(NSUInteger)newRow {

    // Update model layer.
    NSString *movedNumber = self.numbers[oldRow];
    [self.numbers removeObject:movedNumber];
    [self.numbers insertObject:movedNumber atIndex:newRow];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.numbers forKey:kNumbersDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
