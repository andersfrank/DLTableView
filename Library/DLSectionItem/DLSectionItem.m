//
//
//  Created by Anders Frank on 2012-11-29.
//  Copyright (c) 2012 Anders Frank. All rights reserved.
//

#import "DLSectionItem.h"
#import "DLCellItem.h"


@implementation DLSectionItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerHeight = UITableViewAutomaticDimension;
        self.footerHeight = UITableViewAutomaticDimension;
    }
    return self;
}

+ (DLSectionItem*)itemWithCells:(NSArray*)cells; {
    DLSectionItem *section = [DLSectionItem new];
    section.cellItems = cells;
    return section;
}

- (void)addCellItem:(DLCellItem*)cellInfo {
    [self addCellItems:@[cellInfo]];
}

- (void)addCellItems:(NSArray*)cellInfos {
    if (!cellInfos || cellInfos.count == 0) return;
    if (self.cellItems) self.cellItems = [self.cellItems arrayByAddingObjectsFromArray:cellInfos];
    else self.cellItems = cellInfos;
}

- (void)insertCellItem:(DLCellItem *)cellInfo atRow:(NSUInteger)row {
    NSMutableArray *cellInfoArray = [NSMutableArray arrayWithArray:self.cellItems];
    [cellInfoArray insertObject:cellInfo atIndex:row];
    self.cellItems = cellInfoArray;
}

- (void)insertCellItems:(NSArray *)cellInfos atIndexes:(NSIndexSet *)indexes {
    NSMutableArray *cellInfoArray = [NSMutableArray arrayWithArray:self.cellItems];
    [cellInfoArray insertObjects:cellInfos atIndexes:indexes];
    self.cellItems = cellInfoArray;
}

- (void)removeCellItem:(DLCellItem *)cellInfo {
    NSMutableArray *cellInfoArray = [NSMutableArray arrayWithArray:self.cellItems];
    [cellInfoArray removeObject:cellInfo];
    self.cellItems = cellInfoArray;
}

- (void)removeCellItemAtRow:(NSUInteger)row {
    NSMutableArray *cellInfoArray = [NSMutableArray arrayWithArray:self.cellItems];
    [cellInfoArray removeObjectAtIndex:row];
    self.cellItems = cellInfoArray;
}

@end
