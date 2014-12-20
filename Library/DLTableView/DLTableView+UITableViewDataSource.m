

#import "DLTableView+UITableViewDataSource.h"
#import "DLSectionItem+UITableViewDataSource.h"

@implementation DLTableView (UITableViewDataSource) 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sections[section] tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.self.sections[section] tableView:tableView titleForHeaderInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [self.sections[section] tableView:tableView titleForFooterInSection:section];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView canEditRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView canMoveRowAtIndexPath:indexPath];
}

// TODO: Implement
/*
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {

}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
}
*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self sectionAtIndexPath:indexPath] tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    DLSectionItem *sourceSectionItem = [self sectionAtIndexPath:sourceIndexPath];
    DLSectionItem *destinationSectionItem = [self sectionAtIndexPath:destinationIndexPath];
    
    if ([sourceSectionItem.dataSource respondsToSelector:_cmd] && [destinationSectionItem.dataSource respondsToSelector:_cmd]) {
        [sourceSectionItem.dataSource tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
    else {
        DLCellItem *movedCellInfo = [self cellItem:sourceIndexPath];
        [sourceSectionItem removeCellItem:movedCellInfo];
        [destinationSectionItem insertCellItem:movedCellInfo atRow:destinationIndexPath.row];
        
        NSIndexPath *newIndexPath = [self indexPathForCellItem:movedCellInfo];
        if ([self.tableViewDelegate respondsToSelector:@selector(tableView:cellItemDidMove:fromRow:toRow:)]) {
            [self.tableViewDelegate tableView:self cellItemDidMove:movedCellInfo fromRow:sourceIndexPath.row toRow:newIndexPath.row];
        }
    }
}

@end
