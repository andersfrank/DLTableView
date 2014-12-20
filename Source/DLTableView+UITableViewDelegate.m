
#import "DLTableView+UITableViewDelegate.h"
#import "DLTableView+Private.h"
#import "DLCellItem+Private.h"

@implementation DLTableView (UITableViewDelegate)

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
            [self.externalDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
        }
    }
    else {
        DLCellItem *cellItem = sectionItem.cellItems[indexPath.row];
        if (cellItem.willDisplayBlock) {
            cellItem.willDisplayBlock (cellItem, cell);
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    DLSectionItem *sectionItem = self.sections[section];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
            [self.externalDelegate tableView:tableView willDisplayHeaderView:view forSection:section];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    DLSectionItem *sectionItem = self.sections[section];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
            [self.externalDelegate tableView:tableView willDisplayFooterView:view forSection:section];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
            [self.externalDelegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    DLSectionItem *sectionItem = self.sections[section];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
            [self.externalDelegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    DLSectionItem *sectionItem = self.sections[section];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
            [self.externalDelegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            return [self.externalDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
        }
    }
    else {
        DLCellItem *cellItem = sectionItem.cellItems[indexPath.row];
        return cellItem.height;
    }
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    DLSectionItem *sectionItem = self.sections[section];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
            return [self.externalDelegate tableView:tableView heightForHeaderInSection:section];
        }
    }
    
    return [sectionItem headerHeight];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    DLSectionItem *sectionItem = self.sections[section];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
            return [self.externalDelegate tableView:tableView heightForFooterInSection:section];
        }
    }
    return 0;
}

#ifdef DLTABLEVIEW_USE_AUTOLAYOUT

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
            return [self.externalDelegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
        }
    }
    else {
        DLCellItem *cellItem = sectionItem.cellItems[indexPath.row];
        return cellItem.height;
    }
    
    return 44;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    DLSectionItem *sectionItem = self.sections[section];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)]) {
            return [self.externalDelegate tableView:tableView estimatedHeightForHeaderInSection:section];
        }
    }
    
    return [sectionItem headerHeight];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    DLSectionItem *sectionItem = self.sections[section];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)]) {
            return [self.externalDelegate tableView:tableView estimatedHeightForFooterInSection:section];
        }
    }
    return 0;
}

#endif

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DLSectionItem *sectionItem = self.sections[section];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
            return [self.externalDelegate tableView:tableView viewForHeaderInSection:section];
        }
    }

    return sectionItem.headerView;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    DLSectionItem *sectionItem = self.sections[section];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
            return [self.externalDelegate tableView:tableView viewForFooterInSection:section];
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
            return [self.externalDelegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:shouldHighlightRowAtIndexPath:)]) {
            return [self.externalDelegate tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
        }
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)]) {
            [self.externalDelegate tableView:tableView didHighlightRowAtIndexPath:indexPath];
        }
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)]) {
            [self.externalDelegate tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
        }
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
            [self.externalDelegate tableView:tableView willSelectRowAtIndexPath:indexPath];
        }
    }
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
            [self.externalDelegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
        }
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [self.externalDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
        }
    }
    else {
        DLCellItem *cellItem = sectionItem.cellItems[indexPath.row];
        [cellItem cellWasTapped];
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
            [self.externalDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
            return [self.externalDelegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
        }
    }
    
    return UITableViewCellEditingStyleNone;

}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
            return [self.externalDelegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
        }
    } else {
        DLCellItem *cellItem = sectionItem.cellItems[indexPath.row];
        return cellItem.deleteConfirmationButtonTitle;
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
            return [self.externalDelegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
        }
    }
    else {
        DLCellItem *cellItem = sectionItem.cellItems[indexPath.row];
        return cellItem.shouldIndentWhileEditing;
    }
    return YES;
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
            return [self.externalDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
        }
    }
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
            return [self.externalDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
        }
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    DLSectionItem *sourceSectionItem = [self sectionAtIndexPath:sourceIndexPath];
    DLSectionItem *proposedSectionItem = [self sectionAtIndexPath:proposedDestinationIndexPath];
    if (sourceSectionItem.forwardDelegateAndDataSource && proposedSectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
            return [self.externalDelegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
        }
    }
    
    return proposedDestinationIndexPath;
    
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)]) {
            return [self.externalDelegate tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
        }
    }
    
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)]) {
            return [self.externalDelegate tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
        }
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)]) {
            return [self.externalDelegate tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
        }
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    if (sectionItem.forwardDelegateAndDataSource) {
        if ([self.externalDelegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)]) {
            [self.externalDelegate tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
        }
    }
}

@end
