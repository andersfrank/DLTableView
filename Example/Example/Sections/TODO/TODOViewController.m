
#import "ToDoViewController.h"
#import "DLTableView.h"
#import "LabelCell.h"
#import "ToDoItem.h"
#import "NSArray+Map.h"


NSString * const kLabelCellResuseIdentifier = @"kLabelCellResuseIdentifier";


@interface ToDoViewController ()

@property (nonatomic, readonly) DLTableView *tableView;
@property (nonatomic) ToDoViewModel *viewModel;

@end


@implementation ToDoViewController

- (instancetype)initWitViewModel:(ToDoViewModel *)viewModel; {

    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.title = @"TODO";
    }
    return self;
    
}

- (void)loadView {
    self.tableView = [DLTableView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithWhite:230 / 255.0 alpha:1];
    [self.tableView registerClass:[LabelCell class] forCellReuseIdentifier:kLabelCellResuseIdentifier];
    [self reloadTableView];
}


- (void)reloadTableView {
    
    // Map model objects to DLCellItems
    NSArray *cells = [self.viewModel.toDoItems arrayByMappingWithBlock:^id(ToDoItem *todoItem) {
        return [self todoCellItem:todoItem];
    }];
    
    // Setting the sections will also reload the tableview
    self.tableView.sections = @[[DLSectionItem itemWithCells:cells]];
    
}

- (DLCellItem *)todoCellItem:(ToDoItem *)toDoItem {
    
    UIColor *normalBackgroundColor = [UIColor colorWithWhite:252 / 255.0 alpha:1];
    UIColor *doneBackgroundColor = [UIColor clearColor];
    UIColor *normalTextColor = [UIColor blackColor];
    UIColor *doneTextColor = [UIColor colorWithWhite:118 / 255.0 alpha:1];
    
    UIEdgeInsets margins = UIEdgeInsetsMake(14, 14, 14, 14);
    UIFont *font = [UIFont systemFontOfSize:16];
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat cellHeight = [LabelCell cellHeightWithText:toDoItem.title tableViewWidth:cellWidth margins:margins font:font];
    
    return [DLCellItem itemWithModel:toDoItem height:cellHeight + 1 reuseIdentifier:kLabelCellResuseIdentifier target:self action:@selector(toDoCellTapped:) willDisplay:^(DLCellItem *cellItem, UITableViewCell *cell) {
        LabelCell *c = (LabelCell *)cell;
        c.backgroundColor = toDoItem.done ? doneBackgroundColor : normalBackgroundColor;
        c.label.font = font;
        c.label.textColor = toDoItem.done ? doneTextColor : normalTextColor;
        c.margins = margins;
        c.label.text = toDoItem.title;
    }];
    
}

- (void)toDoCellTapped:(DLCellItem *)cellItem {
    
    // A cell can have a model object. In this case a to do item.
    ToDoItem *toDoItem = cellItem.model;
    toDoItem.done = !toDoItem.done;
    [self reloadTableView];
    
}

@end
