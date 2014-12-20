
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DLCellItem, DLSectionItem;

typedef void(^WillDisplayBlock)(DLCellItem *cellItem, UITableViewCell *cell);

@interface DLCellItem : NSObject


/**
 *  The identifier of the cell. Needs to be registered in the tableview.
 */
@property (nonatomic, copy) NSString *reuseIdentifier;

/**
 *  The model object asocciated with the cell item.
 */
@property (nonatomic, strong) id model;

/**
 *  The height of the cell.
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  Called when the cell will be displayed.
 */
@property (nonatomic, copy) WillDisplayBlock willDisplayBlock;

/**
 *  Whether the cell should be indented while editing or not. By default ´YES´.
 */
@property (nonatomic, assign) BOOL shouldIndentWhileEditing;

/**
 *  The title of the delete confirmation button. Must be set in order to display title at all.
 */
@property (nonatomic, copy) NSString *deleteConfirmationButtonTitle;

/**
 *  The target of an action called when the cell is tapped.
 */
@property (nonatomic, assign, readonly) id target;

/**
 *  The indentation level.
 */
@property (nonatomic, assign) NSInteger indentationLevel;

/**
 *  Whether or not the cell is moveable. Movement is resctricted to be within one section.
 */
@property (nonatomic, assign) BOOL canMove;

/**
 *  The editing style of the cell.
 */
@property (nonatomic, assign) UITableViewCellEditingStyle editingStyle;

/**
 *  Action called when the cell is tapped.
 *
 *  @param target The target of the action
 *  @param action Action called when cell is tapped
 */
- (void)setTarget:(id)target action:(SEL)action;

/**
 *  Convenience method for creating a CellItem
 *
 *  @param model            The model object asocciated with the cell item.
 *  @param height           The height of the cell
 *  @param reuseIdentifier  The identifier of the cell. Needs to be registered in the tableview.
 *  @param target           The target of the action
 *  @param action           Action called when cell is tapped
 *  @param willDisplayBlock Called when the cell will be displayed
 *
 *  @return A TBLCellItem
 */
+ (DLCellItem *)itemWithModel:(id)model height:(CGFloat)cellHeight reuseIdentifier:(NSString*)reuseIdentifier target:(id)target action:(SEL)action willDisplay:(WillDisplayBlock)willDisplayBlock;

/**
 *  Convenience method for creating a multiple cell items. One for each model object passed in. Each item will be associated with its respective model object.
 *
 *  @param model            The model object asocciated with the cell item.
 *  @param height           The height of the cell
 *  @param reuseIdentifier  The identifier of the cell. Needs to be registered in the tableview.
 *  @param target           The target of the action
 *  @param action           Action called when cell is tapped
 *  @param willDisplayBlock Called when the cell will be displayed
 *
 *  @return A TBLCellItem
 */
+ (NSArray *)itemsWithModels:(NSArray*)models height:(CGFloat)cellHeight reuseIdentifier:(NSString*)reuseIdentifier target:(id)target action:(SEL)action willDisplay:(WillDisplayBlock)willDisplayBlock;

@end
