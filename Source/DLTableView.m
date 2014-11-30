
#import "DLTableView.h"
#import "DLSectionItem.h"
#import "DLCellItem.h"
#import "DLCellItem+Private.h"
#import "DLTableView+Private.h"
#import "DLTableView+UIScrollViewDelegate.h"
#import "DLTableView+UITableViewDataSource.h"
#import "DLTableView+UITableViewDelegate.h"

@implementation DLTableView

- (void)awakeFromNib {
    super.dataSource = self;
    super.delegate = self;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    _externalDelegate = delegate;
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    _externalDataSource = dataSource;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        super.dataSource = self;
        super.delegate = self;

    }
    return self;
}

- (void)setSections:(NSArray *)sections {

    _sections = sections;
    
    [self reloadData];
}

#pragma mark - UITableView

- (void)reloadSectionItems:(NSArray *)sectionItems withRowAnimation:(UITableViewRowAnimation)animation{
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];
    [sectionItems enumerateObjectsUsingBlock:^(DLSectionItem *section, NSUInteger idx, BOOL *stop) {
        if ([self.sections containsObject:section]) {
            [indexSet addIndex:[self.sections indexOfObject:section]];
        }
    }];
    [self reloadSections:indexSet withRowAnimation:animation];
}


- (void)insertSectionItem:(DLSectionItem *)section atIndex:(NSUInteger)index withRowAnimation:(UITableViewRowAnimation)animation {
    
    NSMutableArray *sections = [NSMutableArray arrayWithArray:self.sections];
    [sections insertObject:section atIndex:index];
    self.sections = sections;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[self.sections indexOfObject:section]];
    [self insertSections:indexSet withRowAnimation:animation];
    
}

- (void)deleteSectionItems:(NSArray *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];
    [sections enumerateObjectsUsingBlock:^(DLSectionItem *section, NSUInteger idx, BOOL *stop) {
        if ([self.sections containsObject:section]) {
            [indexSet addIndex:[self.sections indexOfObject:section]];
        }
    }];
    
    NSMutableArray *s = [NSMutableArray arrayWithArray:self.sections];
    [s removeObjectsInArray:sections];
    self.sections = s;
    
    [self deleteSections:indexSet withRowAnimation:animation];
}

- (void)moveSectionItem:(DLSectionItem *)section toSectionWithIndex:(NSInteger)index {
    
    if (![self.sections containsObject:section]) {
        NSLog(@"TableView does not contain section");
        return;
    }
    
    NSInteger currentIndex = [self.sections indexOfObject:section];
    NSMutableArray *sections = [NSMutableArray arrayWithArray:self.sections];
    [sections removeObject:section];
    [sections insertObject:section atIndex:index];
    self.sections = sections;
    [self moveSection:currentIndex toSection:index];
}

- (void)replaceSectionItem:(DLSectionItem *)section withSectionItem:(DLSectionItem *)newSection withRowAnimation:(UITableViewRowAnimation)animation {
  
    if (![self.sections containsObject:section]) {
        NSLog(@"TableView does not contain section");
        return;
    }
    
    NSMutableArray *sections = [NSMutableArray arrayWithArray:self.sections];
    NSUInteger index = [sections indexOfObject:section];
    [sections removeObject:section];
    [sections insertObject:newSection atIndex:index];
    self.sections = sections;
    [self reloadSectionItems:@[newSection] withRowAnimation:animation];
}


- (void)replaceCellItemsWith:(NSArray *)cells inSection:(DLSectionItem*)section withRowAnimation:(UITableViewRowAnimation)animation {
    [self deleteCellItems:section.cellItems withRowAnimation:animation];
    [self insertCellItems:cells inSection:section atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, cells.count)] withRowAnimation:animation];
}

- (void)insertCellItems:(NSArray *)cells inSection:(DLSectionItem*)section atIndexes:(NSIndexSet *)indexes withRowAnimation:(UITableViewRowAnimation)animation {
    
    if (!section) {
        return;
    }
    
    if (![self.sections containsObject:section]) {
        NSLog(@"TableView does not contain section");
        return;
    }
    
    [section insertCellItems:cells atIndexes:indexes];
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:cells.count];
    [cells enumerateObjectsUsingBlock:^(DLCellItem *cell, NSUInteger idx, BOOL *stop) {
        [indexPaths addObject:[self indexPathForCellItem:cell]];
    }];
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)deleteCellItems:(NSArray *)cellInfos withRowAnimation:(UITableViewRowAnimation)animation {
    if (cellInfos.count == 0) {
        return;
    }
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:cellInfos.count];
    [cellInfos enumerateObjectsUsingBlock:^(DLCellItem *cellInfo, NSUInteger idx, BOOL *stop) {
        NSIndexPath *ip = [self indexPathForCellItem:cellInfo];
        if (ip) {
            [indexPaths addObject:ip];
        }
    }];
    
    [cellInfos enumerateObjectsUsingBlock:^(DLCellItem *cellInfo, NSUInteger idx, BOOL *stop) {
        NSIndexPath *ip = [self indexPathForCellItem:cellInfo];
        if (ip) {
            DLSectionItem *section = self.sections[ip.section];
            [section removeCellItem:cellInfo];
        }
    }];
    
    [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    
}

- (void)reloadCellItems:(NSArray *)cells withRowAnimation:(UITableViewRowAnimation)animation {
    NSMutableArray *indexPaths = [NSMutableArray new];
    [cells enumerateObjectsUsingBlock:^(DLCellItem *cellInfo, NSUInteger idx, BOOL *stop) {
        NSIndexPath *ip = [self indexPathForCellItem:cellInfo];
        if (ip) {
            [indexPaths addObject:ip];
        }
    }];
    [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)moveCellItem:(DLCellItem *)cell inSection:(DLSectionItem *)section toIndex:(NSUInteger )index {

    if (![section.cellItems containsObject:cell] || ![self.sections containsObject:section]) {
        return;
    }
    
    NSIndexPath *fromIndexPath = [self indexPathForCellItem:cell];
    
    NSMutableArray *cells = [NSMutableArray arrayWithArray:section.cellItems];
    [cells removeObject:cell];
    [cells insertObject:cell atIndex:index];
    section.cellItems = cells;
    NSIndexPath *toIndexPath = [self indexPathForCellItem:cell];
    [self moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
}

- (DLSectionItem*)sectionAtIndexPath:(NSIndexPath*)indexPath {
    return self.sections[indexPath.section];
}

- (DLSectionItem*)section:(NSInteger)section {
    return self.sections[section];
}

- (DLCellItem*)cellItem:(NSIndexPath*)indexPath {
    return [[self section:indexPath.section] cellItems][indexPath.row];
}

- (DLCellItem*)cellItemForModel:(id)dataModel {
    
    for (DLSectionItem *sectionInfo in self.sections) {
        for (DLCellItem *cellInfo in sectionInfo.cellItems) {
            if ([cellInfo.model isEqual:dataModel]) return cellInfo;
        }
    }
    return nil;
}

- (UITableViewCell *)tableViewCellForCellItem:(DLCellItem *)cellInfo {
    NSIndexPath *indexPath = [self indexPathForCellItem:cellInfo];
    return [self cellForRowAtIndexPath:indexPath];
    
}

- (NSIndexPath *)indexPathForCellItem:(DLCellItem *)cellInfo {
    for (DLSectionItem *sectionInfo in self.sections) {
        for (DLCellItem *cInfo in sectionInfo.cellItems) {
            if ([cellInfo isEqual:cInfo]) {
                return [NSIndexPath indexPathForRow:[sectionInfo.cellItems indexOfObject:cInfo] inSection:[self.sections indexOfObject:sectionInfo]];
            }
        }
    }
    return nil;
}

- (NSArray*)indexPathsWithCellIdentifier:(NSString*)cellIdentifier {
    
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (DLSectionItem *sectionInfo in self.sections) {
        for (DLCellItem *cellInfo in sectionInfo.cellItems) {
            if ([cellInfo.reuseIdentifier isEqual:cellIdentifier]) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:[sectionInfo.cellItems indexOfObject:cellInfo] inSection:[self.sections indexOfObject:sectionInfo]]];
            }
        }
    }
    
    return indexPaths.count > 0 ? indexPaths : nil;
}

- (DLCellPosition)cellPosition:(DLCellItem *)cellInfo {
  
    NSIndexPath *ip = [self indexPathForCellItem:cellInfo];
    DLSectionItem *si = [self sectionAtIndexPath:ip];
    
    if (si.cellItems.count == 1)
        return  DLCellPositionSingle;
    else if (si.cellItems.count > 0 && si.cellItems[0] == cellInfo)
        return DLCellPositionTop;
    else if ([si.cellItems lastObject] == cellInfo)
        return DLCellPositionBottom;
   
    return DLCellPositionMiddle;
}

@end
