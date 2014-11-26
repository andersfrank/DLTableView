//
//
//  Created by Anders Frank on 2013-02-14.
//  Copyright (c) 2013 Monterosa AB. All rights reserved.
//

#import "DLTableView.h"
#import "DLSectionItem.h"
#import "DLCellItem.h"


@interface DLTableView () 
@property (nonatomic, assign) id <UITableViewDelegate> externalDelegate;
@property (nonatomic, assign) id <UITableViewDataSource> externalDataSource;
@end

@implementation DLTableView

- (void)awakeFromNib {
    self.dataSource = self;
    self.delegate = self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;

    }
    return self;
}

- (void)setSections:(NSArray *)sections {

    _sections = sections;
    
    [self reloadData];
    
    if (self.higherIndexCellsOnTop) {
        [self updateCellZPosition];
    }
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

#pragma mark - UITableViewDelegate and dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self section:section] cellItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DLCellItem *cellInfo = [self cellItem:indexPath];
    
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellInfo.reuseIdentifier];
    
    if (!cell) {
        NSLog(@"Error! Failed loading cell for identifier: %@",cellInfo.reuseIdentifier);
    }
    
    if (!cellInfo.target) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self cellItem:indexPath] height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [[self section:section] headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[self section:section] headerView];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self section:section] headerTitle];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLCellItem *cell = [self cellItem:indexPath];
    [cell cellWasTapped];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] canMove];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self cellItem:indexPath] canEdit];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self cellItem:indexPath] editingStyle];
}

-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self cellItem:indexPath] shouldIndentWhileEditing];
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    DLSectionItem *sourceSection = [self sectionAtIndexPath:sourceIndexPath];
    DLSectionItem *destinationSection = [self sectionAtIndexPath:destinationIndexPath];
    DLCellItem *movedCellInfo = [self cellItem:sourceIndexPath];
    [sourceSection removeCellItem:movedCellInfo];
    [destinationSection insertCellItem:movedCellInfo atRow:destinationIndexPath.row];
   

    NSIndexPath *newIndexPath = [self indexPathForCellItem:movedCellInfo];
    if ([self.tblViewDelegate respondsToSelector:@selector(tableView:didMoveCellWithInfo:fromRow:toRow:)])
        [self.tblViewDelegate tableView:self didMoveCellWithInfo:movedCellInfo fromRow:sourceIndexPath.row toRow:newIndexPath.row];
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    DLSectionItem *sourceSectionInfo = [self sectionAtIndexPath:sourceIndexPath];
    DLSectionItem *proposedDestinationSectionInfo = [self sectionAtIndexPath:proposedDestinationIndexPath];
    if (sourceSectionInfo == proposedDestinationSectionInfo) return proposedDestinationIndexPath;
    else {
        if (proposedDestinationIndexPath.section < sourceIndexPath.section)
            return [NSIndexPath indexPathForRow:0 inSection:sourceIndexPath.section];
        else return [NSIndexPath indexPathForRow:sourceSectionInfo.cellItems.count - 1 inSection:sourceIndexPath.section];
        
    }
        
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    DLCellItem *cellInfo = [self cellItem:indexPath];
    
    if (cellInfo.willDisplayBlock)
        cellInfo.willDisplayBlock (cellInfo, cell);

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.contentOffset.y >= self.contentSize.height - self.frame.size.height)
    {
        if ([self.tblViewDelegate respondsToSelector:@selector(tableViewWasScrolledToBottom:)])
            [self.tblViewDelegate tableViewWasScrolledToBottom:self];
    }
    
    if (self.higherIndexCellsOnTop)
        [self updateCellZPosition];
    
    if (!self.forwardScrollViewDelegateMethods) return;
    
    if ([self.tblViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)])
        [self.tblViewDelegate scrollViewDidScroll:scrollView];
    


}

- (void)updateCellZPosition {
    NSArray *sortedIndexPaths = [self.indexPathsForVisibleRows sortedArrayUsingComparator: ^NSComparisonResult(NSIndexPath *ip1, NSIndexPath *ip2) {
        return [ip1 compare:ip2];
    }];
    for (NSIndexPath *indexPath in sortedIndexPaths) {
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        if (cell.superview) {
            [cell.superview bringSubviewToFront:cell];
        }
    }

}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!self.forwardScrollViewDelegateMethods) return;
    
    if ([self.tblViewDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) 
        [self.tblViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (!self.forwardScrollViewDelegateMethods) return;
    
    if ([self.tblViewDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)])
        [self.tblViewDelegate scrollViewWillBeginDragging:scrollView];
    
}

@end
