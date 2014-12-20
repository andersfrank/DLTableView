//
//  DLSectionItem+UITableViewDataSource.m
//  Example
//
//  Created by Anders Frank on 2014-12-20.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import "DLSectionItem+UITableViewDataSource.h"
#import "DLCellItem.h"

@implementation DLSectionItem (UITableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource) {
        return [self.dataSource tableView:tableView numberOfRowsInSection:section];
    }
    else {
        return self.cellItems.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource) {
        return [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else {
        DLCellItem *cellItem = self.cellItems[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellItem.reuseIdentifier];
        
        if (!cell) {
            NSLog(@"Error! Failed loading cell for identifier: %@",cellItem.reuseIdentifier);
        }
        
        if (!cellItem.target) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.dataSource) {
        if ([self.dataSource respondsToSelector:_cmd]) {
            return [self.dataSource tableView:tableView titleForHeaderInSection:section];
        }
        else {
            return nil;
        }
    }
    else {
        return self.headerTitle;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (self.dataSource) {
        if ([self.dataSource respondsToSelector:_cmd]) {
            return [self.dataSource tableView:tableView titleForFooterInSection:section];
        }
        else {
            return nil;
        }
    }
    else {
        return self.footerTitle;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:_cmd]) {
        return [self.dataSource tableView:tableView canEditRowAtIndexPath:indexPath];
    } else {
        return YES;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource) {
        if ([self.dataSource respondsToSelector:_cmd]) {
            return [self.dataSource tableView:tableView canMoveRowAtIndexPath:indexPath];
        } else {
            return [self.dataSource respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)];
        }
    }
    else {
        DLCellItem *cellItem = self.cellItems[indexPath.row];
        return cellItem.canMove;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:_cmd]) {
        [self.dataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

@end
