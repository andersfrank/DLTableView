
#import "ToDoViewController.h"
#import "DLTableView.h"
#import "LabelCell.h"
#import "ToDoItem.h"
#import "DrawViewCell.h"
#import "NSArray+Map.h"
#import "CheckBoxView.h"

NSString * const kLabelCellResuseIdentifier = @"kLabelCellResuseIdentifier";
NSString * const kThinLineCellResuseIdentifier = @"kThinLineCellResuseIdentifier";

#define kNormalTodoItemCellBackgroundColor  [UIColor colorWithWhite:252 / 255.0 alpha:1]
#define kDoneTodoItemCellBackgroundColor    [UIColor clearColor]


@interface ToDoViewController ()

@property (nonatomic, readonly) DLTableView *tableView;
@property (nonatomic) ToDoViewModel *viewModel;

@end


@implementation ToDoViewController

- (instancetype)initWitViewModel:(ToDoViewModel *)viewModel; {

    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.title = @"To-Do List";
    }
    return self;
    
}

- (void)loadView {
    self.tableView = [DLTableView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:230 / 255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[LabelCell class] forCellReuseIdentifier:kLabelCellResuseIdentifier];
    [self.tableView registerClass:[DrawViewCell class] forCellReuseIdentifier:kThinLineCellResuseIdentifier];
    
    [self reloadTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    navBar.tintColor = [UIColor whiteColor];
    navBar.barTintColor = [UIColor colorWithRed:0.396 green:0.529 blue:0.714 alpha:1];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    navBar.translucent = NO;

}

- (void)reloadTableView {
    
    // Map model objects to DLCellItems
    NSMutableArray *cells = [NSMutableArray new];
    
    [self.viewModel.toDoItems enumerateObjectsUsingBlock:^(ToDoItem *toDoItem, NSUInteger idx, BOOL *stop) {
       
        // To do item cell
        [cells addObject:[self todoCellItem:toDoItem]];

        // Separator cell
        UIColor *separatorColor = [UIColor colorWithWhite:180 / 255.0 alpha:0.9];
        UIColor *backgroundColor = toDoItem.done ? kDoneTodoItemCellBackgroundColor : kNormalTodoItemCellBackgroundColor;
        DLCellItem *separatorCellItem = [self thinLineCell:separatorColor cellBackgroundColor:backgroundColor];
        [cells addObject:separatorCellItem];
        
    }];
    
    // Setting the sections will reload the tableview
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
    
    return [DLCellItem itemWithModel:toDoItem height:cellHeight reuseIdentifier:kLabelCellResuseIdentifier target:self action:@selector(toDoCellTapped:) willDisplay:^(DLCellItem *cellItem, UITableViewCell *cell) {
        LabelCell *c = (LabelCell *)cell;
        CheckBoxView *checkboxView = [[CheckBoxView alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
        checkboxView.checked = toDoItem.done;
        c.accessoryView = checkboxView;
        c.backgroundColor = toDoItem.done ? doneBackgroundColor : normalBackgroundColor;
        c.label.font = font;
        c.label.textColor = toDoItem.done ? doneTextColor : normalTextColor;
        c.margins = margins;
        c.label.text = toDoItem.title;
    }];
    
}

- (DLCellItem *)thinLineCell:(UIColor *)lineColor cellBackgroundColor:(UIColor *)cellBackgroundColor {
    return [DLCellItem itemWithModel:nil height:1  reuseIdentifier:kThinLineCellResuseIdentifier target:nil action:nil willDisplay:^(DLCellItem *cellItem, UITableViewCell *cell) {
        DrawViewCell *c = (DrawViewCell *)cell;
        c.backgroundColor = cellBackgroundColor;
        c.drawView.drawBlock = ^(CGContextRef context, CGRect frame) {
            CGContextSetFillColorWithColor(context, lineColor.CGColor);
            CGRect slice, remainder;
            CGRectDivide(frame, &slice, &remainder, 0.5, CGRectMaxYEdge);
            CGContextFillRect(context,slice);
        };
    }];
}

- (void)toDoCellTapped:(DLCellItem *)cellItem {
    
    // A cell can have a model object. In this case a to do item.
    ToDoItem *toDoItem = cellItem.model;
    toDoItem.done = !toDoItem.done;
    [self reloadTableView];
    
}

@end
