
#import "DLTableView+UITableViewDelegate.h"
#import "DLSectionItem+DLTableViewDelegate.h"

@implementation DLTableView (UITableViewDelegate)

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self sectionAtIndexPath:indexPath] tableView:self willDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    [self.sections[section] tableView:tableView willDisplayHeaderView:view forSection:section];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    [self.sections[section] tableView:tableView willDisplayFooterView:view forSection:section];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    [[self sectionAtIndexPath:indexPath] tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    [self.sections[section] tableView:tableView didEndDisplayingHeaderView:view forSection:section];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    [self.sections[section] tableView:tableView didEndDisplayingFooterView:view forSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.sections[section] tableView:tableView heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.sections[section] tableView:tableView heightForFooterInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return [self.sections[section] tableView:tableView estimatedHeightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return [self.sections[section] tableView:tableView estimatedHeightForFooterInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.sections[section] tableView:tableView viewForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.sections[section] tableView:tableView viewForFooterInSection:section];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self sectionAtIndexPath:indexPath] tableView:tableView didHighlightRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self sectionAtIndexPath:indexPath] tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView willSelectRowAtIndexPath:indexPath];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView willDeselectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self sectionAtIndexPath:indexPath] tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self sectionAtIndexPath:indexPath] tableView:tableView didDeselectRowAtIndexPath:indexPath];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView editingStyleForRowAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSectionItem *sectionItem = [self sectionAtIndexPath:indexPath];
    return [sectionItem tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self sectionAtIndexPath:indexPath] tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self sectionAtIndexPath:indexPath] tableView:tableView didEndEditingRowAtIndexPath:indexPath];
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    DLSectionItem *sourceSectionItem = [self sectionAtIndexPath:sourceIndexPath];
    DLSectionItem *proposedSectionItem = [self sectionAtIndexPath:proposedDestinationIndexPath];
    if ([sourceSectionItem.delegate respondsToSelector:_cmd]) {
        return [sourceSectionItem.delegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    // Restrict movement to be within the source section
    else {
        if (sourceSectionItem == proposedSectionItem) {
            return proposedDestinationIndexPath;
        }
        else {
            if (proposedDestinationIndexPath.section < sourceIndexPath.section) {
                return [NSIndexPath indexPathForRow:0 inSection:sourceIndexPath.section];
            }
            else {
               return [NSIndexPath indexPathForRow:sourceSectionItem.cellItems.count - 1 inSection:sourceIndexPath.section];
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    return [[self sectionAtIndexPath:indexPath] tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    [[self sectionAtIndexPath:indexPath] tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
}

@end
