//
//
//  Created by Anders Frank on 2013-02-14.
//  Copyright (c) 2013 Monterosa AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLCellItem.h"
#import "DLSectionItem.h"

typedef enum {
    DLCellPositionMiddle,
    DLCellPositionTop,
    DLCellPositionBottom,
    DLCellPositionSingle,
}DLCellPosition;

@protocol DLTableViewDelegate;

@class DLSectionItem, DLCellItem;

@interface DLTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

/**
 *   The TBLSection objects of the table view. Setting the sections will reload the table view.
 */
@property (nonatomic, strong) NSArray *sections;

/**
 *  The delegate of the tableview. The default delegate and dataSource of the UITableView are implemented by TLBView and should not be changed.
 */
@property (nonatomic, assign) id <DLTableViewDelegate> tblViewDelegate;

/**
 *  The delegate methods:
 *  scrollViewDidScroll:
 *  scrollViewDidEndDragging:willDecelerate 
 *  scrollViewWillBeginDragging: 
 *
 *  of the UIScrollView will be forwarded.
 */
@property (nonatomic, assign) BOOL forwardScrollViewDelegateMethods;

/**
 *  Forces cells with higher index to placed above lower index cells.
 */
@property (nonatomic, assign) BOOL higherIndexCellsOnTop;

/**
 *  The section at a certain index path.
 *
 *  @param indexPath The index path
 *
 *  @return A TBLSection object.
 */
- (DLSectionItem*)sectionAtIndexPath:(NSIndexPath*)indexPath;

/**
 *  The section at a certain section value.
 *
 *  @param section The section value.
 *
 *  @return A TBLSection object.
 */
- (DLSectionItem*)section:(NSInteger)section;

/**
 *  The cell item at a certain index path.
 *
 *  @param indexPath The index path
 *
 *  @return A TBLCellItem object.
 */
- (DLCellItem*)cellItem:(NSIndexPath*)indexPath;

/**
 *  The cell item for a certain model object. Relies on isEqual for the model object for identification.
 *
 *  @param model The model
 *
 *  @return A TBLCellItem object.
 */
- (DLCellItem*)cellItemForModel:(id)model;

/**
 *  The table view cell for a certain cell item. Returns nil if cell is not visible or index path is out of range 
 *
 *  @param cellItem The cell item
 *
 *  @return UITableViewCell
 */
- (UITableViewCell *)tableViewCellForCellItem:(DLCellItem *)cellItem;

/**
 *
 *  @param cellIdentifier Cell identifier strings.
 *
 *  @return An array with NSIndexPaths objects.
 */
- (NSArray *)indexPathsWithCellIdentifier:(NSString *)cellIdentifier;

/**
 *  Returns an indexPath for a certain CellItem
 *
 *  @param cellItem The cell item
 *
 *  @return NSIndexPath
 */
- (NSIndexPath *)indexPathForCellItem:(DLCellItem *)cellInfo;

/**
 *  Returns a cell position for a cetina CellItem
 *
 *  @param cellItem The cell item
 *
 *  @return The cell position
 */
- (DLCellPosition)cellPosition:(DLCellItem *)cellItem;

/**
 *  Replaces cells in a specific section with row animation
 *
 *  @param cellItems    The cell items
 *  @param section      The section
 *  @param animation    The row animation type
 */
- (void)replaceCellItemsWith:(NSArray *)cellItems inSection:(DLSectionItem*)section withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  Inserts cell items with animation
 *
 *  @param cellItems    The cell items
 *  @param section      The section
 *  @param indexes      The indexes where the cells should be inserted
 *  @param animation    The row animation type
 */
- (void)insertCellItems:(NSArray *)cellItems inSection:(DLSectionItem*)section atIndexes:(NSIndexSet *)indexes withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  Delete cell items with animation
 *
 *  @param cellItems    The cell items
 *  @param animation    The row animation type
 */
- (void)deleteCellItems:(NSArray *)cellItems withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  Move cell item with animation
 *
 *  @param section      The section
 *  @param index        The new index if the cell item
 *  @param cellItems    The cell items
 */
- (void)moveCellItem:(DLCellItem *)cellItem inSection:(DLSectionItem *)section toIndex:(NSUInteger)index;

/**
 *  Reload cells in section with animation
 *
 *  @param sectionItems The section items to reload
 *  @param animation    The row animation type
 */
- (void)reloadSectionItems:(NSArray *)sectionItems withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  Move section
 *
 *  @param section      The section to move
 *  @param index        The new index
 *  @param animation    The row animation type
 */
- (void)moveSectionItem:(DLSectionItem *)section toSectionWithIndex:(NSInteger)index;

/**
 *  Delete sections with animation
 *
 *  @param sectionItems     The sections items to delete
 *  @param animation        The row animation type
 */
- (void)deleteSectionItems:(NSArray *)sectionItems withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  Insert section with animation
 *
 *  @param section      The sections to insert
 *  @param index        The index where the section should be inserted
 *  @param animation    The row animation type
 */
- (void)insertSectionItem:(DLSectionItem *)section atIndex:(NSUInteger)index withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  Replace section with animation
 *
 *  @param section      The old section
 *  @param newSection   The new section which will replace the old section
 *  @param animation    The row animation type
 */
- (void)replaceSectionItem:(DLSectionItem *)section withSectionItem:(DLSectionItem *)newSection withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  Reload cells
 *
 *  @param cellItems     The cell items to be reloaded
 *  @param animation     The row animation type
 */
- (void)reloadCellItems:(NSArray *)cellItems withRowAnimation:(UITableViewRowAnimation)animation;

@end

@protocol DLTableViewDelegate <NSObject>

@optional

- (void)tableView:(DLTableView *)tableView didMoveCellWithInfo:(DLCellItem *)cellInfo fromRow:(NSUInteger)sourceRow toRow:(NSUInteger)destinationRow;
- (void)tableViewWasScrolledToBottom:(DLTableView *)tableView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;

@end