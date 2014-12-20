
#import "MoveableCellsViewController.h"
#import "DLTableView.h"
#import "SpacingCellMaker.h"
#import "LabelCellMaker.h"
#import "LabelCell.h"

@interface MoveableCellsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) DLTableView *tableView;
@property (nonatomic) LabelCellMaker *paragraphCellMaker;
@property (nonatomic) DLSectionItem *moveableSection;
@property (nonatomic) NSArray *moveableTitles;

@end

@implementation MoveableCellsViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.title = @"Moveable Cells";
        
        UIEdgeInsets margins = UIEdgeInsetsMake(0, 10, 0, 10);
        
        // A convience class for making cell items. Not part of the library.
        self.paragraphCellMaker = [[LabelCellMaker alloc]
                                   initWithFont:[UIFont systemFontOfSize:16]
                                   textColor:[UIColor blackColor] margins:margins];
        
        self.moveableTitles = @[@"One", @"Two", @"Three", @"Four", @"Five"];

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
    
    // Becase we wan't to implement the data source and delegate for one section
    // we need to set the delegate and data source.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    // Register cell reuse identifiers
    [LabelCellMaker registerCellClasses:self.tableView];
    [SpacingCellMaker registerCellClasses:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MoveableCell"];
    
    DLSectionItem *headerSection = [DLSectionItem new];
    headerSection.cellItems = @[];
    
    self.moveableSection = [DLSectionItem new];
    // For this section we handle the delegate and data source methods in the traditional way.
    self.moveableSection.forwardDelegateAndDataSource = YES;
    
    self.tableView.sections = @[headerSection, self.moveableSection];
    
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self.tableView indexPathSection:self.moveableSection]) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MoveableCell"];
        cell.textLabel.text = self.moveableTitles[indexPath.row];
        cell.showsReorderControl = YES;
        return cell;
    }
    else {
        return nil;
    }

}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self.tableView indexPathSection:self.moveableSection]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSInteger moveableSection = [self.tableView indexPathSection:self.moveableSection];
    if (sourceIndexPath.section == moveableSection && destinationIndexPath.section == moveableSection) {
        
        NSMutableArray *titles = [NSMutableArray arrayWithArray:self.moveableTitles];
        NSString *movingTitle = titles[sourceIndexPath.row];
        
        [titles removeObject:movingTitle];
        [titles insertObject:movingTitle atIndex:destinationIndexPath.row];
        
        self.moveableTitles = [NSArray arrayWithArray:titles];
        
        [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == [self.tableView indexPathSection:self.moveableSection]) {
        return self.moveableTitles.count;
    } else {
        return 0;
    }
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
