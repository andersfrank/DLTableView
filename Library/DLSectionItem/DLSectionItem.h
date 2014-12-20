
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DLCellItem;

@interface DLSectionItem : NSObject

@property (nonatomic, assign) id <UITableViewDelegate> delegate;
@property (nonatomic, assign) id <UITableViewDataSource> dataSource;

/**
 *  The section will opt out of handling table view delegate and datasource.
 *  Instead the delegate and data source methods will be called in the standard fashion.
 *  NO by default. Note that `numberOfSectionsInTableView:` always will be intercepted by the
 *  DLTableView.
 */
@property (nonatomic, assign) BOOL forwardDelegateAndDataSource;

/**
 *  The cell items of the section
 */
@property (nonatomic, strong) NSArray *cellItems;

/**
 *  The header view of the section
 */
@property (nonatomic, strong) UIView *headerView;

/**
 *  The header title of the section
 */
@property (nonatomic, copy) NSString *headerTitle;

/**
 *  The height of the header
 */
@property (nonatomic, assign) CGFloat headerHeight;

/**
 *  The height of the footer
 */
@property (nonatomic, assign) CGFloat footerHeight;

/**
 *  The footer view of the section
 */
@property (nonatomic, strong) UIView *footerView;

/**
 *  The footer title of the section
 */
@property (nonatomic, copy) NSString *footerTitle;

/**
 * All cells in section are made movable. Cells can only be moved within section.
 */
@property (nonatomic, assign) BOOL canMove;

/**
 *  Add cell item to the section. The table view will need to be reloaded in order for the change to take effect.
 *
 *  @param cellItem The cell item to add.
 */
- (void)addCellItem:(DLCellItem *)cellItem;

/**
 *  Add cell items to the section. The table view will need to be reloaded in order for the change to take effect.
 *
 *  @param cellItems The cell items to add.
 */
- (void)addCellItems:(NSArray *)cellItems;

/**
 *  Insert cell item at row. The table view will need to be reloaded in order for the change to take effect.
 *
 *  @param cellItem The cell item to insert
 *  @param row      The row where the cell should be inserted
 */
- (void)insertCellItem:(DLCellItem *)cellItem atRow:(NSUInteger)row;

/**
 *  Insert cell items at row. The table view will need to be reloaded in order for the change to take effect.
 *
 *  @param cellItems The cell items to insert
 *  @param row      The row where the cells should be inserted
 */
- (void)insertCellItems:(NSArray *)cellItem atIndexes:(NSIndexSet *)indexes;

/**
 *  Remove cell item from the section. The table view will need to be reloaded in order for the change to take effect.
 *
 *  @param cellItem The cell item to remove.
 */
- (void)removeCellItem:(DLCellItem *)cellItem;

/**
 *  Remove cell item from the section. The table view will need to be reloaded in order for the change to take effect.
 *
 *  @row Row of the cell item to remove.
 */
- (void)removeCellItemAtRow:(NSUInteger)row;

/**
 *  Convenice method for creating section
 *
 *  @param cells The cells of the section
 *
 *  @return The TBLSection
 */
+ (DLSectionItem*)itemWithCells:(NSArray*)cells;

@end
