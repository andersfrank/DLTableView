//
//  DLSectionItem+DLTableViewDelegate.m
//  Example
//
//  Created by Anders Frank on 2014-12-20.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import "DLSectionItem+DLTableViewDelegate.h"
#import "DLCellItem.h"
#import "DLCellItem+Private.h"

@implementation DLSectionItem (DLTableViewDelegate)

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
    else {
        DLCellItem *cellItem = self.cellItems[indexPath.row];
        if (cellItem.willDisplayBlock) {
            cellItem.willDisplayBlock (cellItem, cell);
        }
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tableView:tableView willDisplayFooterView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:_cmd]) {
            return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
        }
        else {
            return UITableViewAutomaticDimension;
        }
    }
    else {
        DLCellItem *cellItem = self.cellItems[indexPath.row];
        return cellItem.height;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:_cmd]) {
            return [self.delegate tableView:tableView heightForHeaderInSection:section];
        }
        else {
            return UITableViewAutomaticDimension;
        }
    } else {
        return self.headerHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:_cmd]) {
            return [self.delegate tableView:tableView heightForFooterInSection:section];
        }
        else {
            return UITableViewAutomaticDimension;
        }
    } else {
        return self.footerHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tableView:tableView estimatedHeightForHeaderInSection:section];
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tableView:tableView estimatedHeightForFooterInSection:section];
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:_cmd]) {
            return [self.delegate tableView:tableView viewForHeaderInSection:section];
        }
        else {
            return nil;
        }
    }
    else {
        return self.headerView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:_cmd]) {
            return [self.delegate tableView:tableView viewForFooterInSection:section];
        }
        else {
            return nil;
        }
    }
    else {
        return self.footerView;
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
    } else {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tableView:tableView didHighlightRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    }
    else {
        return indexPath;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
    }
    else {
        return indexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else {
        DLCellItem *cellItem = self.cellItems[indexPath.row];
        [cellItem cellWasTapped];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    else {
        return UITableViewCellEditingStyleDelete;
    }
}

// TODO: Find a way to return default value.
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    else {
        DLCellItem *cellItem = self.cellItems[indexPath.row];
        return cellItem.deleteConfirmationButtonTitle;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:_cmd]) {
            return [self.delegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
        } else {
            return YES;
        }
    }
    else {
        DLCellItem *cellItem = self.cellItems[indexPath.row];
        return cellItem.shouldIndentWhileEditing;
    }
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
}

// TODO: Check if UITableViewAutomaticDimension is valid for integer returns.
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:_cmd]) {
            return [self.delegate tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
        }
        else {
            return UITableViewAutomaticDimension;
        }
    }
    else {
        DLCellItem *cellItem = self.cellItems[indexPath.row];
        return cellItem.indentationLevel;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    }
    else {
        return NO;
    }
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
}

@end
