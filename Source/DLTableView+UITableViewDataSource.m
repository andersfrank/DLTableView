

#import "DLTableView+UITableViewDataSource.h"
#import "DLTableView+Private.h"

@implementation DLTableView (UITableViewDataSource) 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DLSectionItem *sectionItem = self.sections[section];
    if (sectionItem.forwardDelegateAndDataSource) {
        return [self.externalDataSource tableView:tableView numberOfRowsInSection:section];
    }
    else {
        return sectionItem.cellItems.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
            return [self.externalDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else {
        DLCellItem *cellItem = sectionItem.cellItems[indexPath.row];
        UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellItem.reuseIdentifier];
        
        if (!cell) {
            NSLog(@"Error! Failed loading cell for identifier: %@",cellItem.reuseIdentifier);
        }
        
        if (!cellItem.target) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    DLSectionItem *sectionItem = self.sections[section];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
            return [self.externalDataSource tableView:tableView titleForHeaderInSection:section];
        }
    }
    else {
        return sectionItem.headerTitle;
    }
    
    return nil;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    DLSectionItem *sectionItem = self.sections[section];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
            return [self.externalDataSource tableView:tableView titleForFooterInSection:section];
        }
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
            return [self.externalDataSource tableView:tableView canEditRowAtIndexPath:indexPath];
        }
    }
   
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDataSource respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
            return [self.externalDataSource tableView:tableView canMoveRowAtIndexPath:indexPath];
        }
    }
    return NO;
}

// TODO: Implement

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//
//}
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
            return [self.externalDataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
        }
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    DLSectionItem *sourceSectionItem = [self sectionAtIndexPath:sourceIndexPath];
    DLSectionItem *destinationSectionItem = [self sectionAtIndexPath:destinationIndexPath];
    if (sourceSectionItem.forwardDelegateAndDataSource && destinationSectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDataSource respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
            [self.externalDataSource tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
        }
    }
}

@end
