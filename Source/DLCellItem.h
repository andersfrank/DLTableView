//
//  SKCellInfo.h
//
//  Created by Anders Frank on 2012-11-29.
//  Copyright (c) 2012 Anders Frank. All rights reserved.
//

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
 *  Whether the cell can be edited or not.
 */
@property (nonatomic, assign) BOOL canEdit;

/**
 *  Called when the cell will be displayed.
 */
@property (nonatomic, copy) WillDisplayBlock willDisplayBlock;

/**
 * The editing style. Default is ´UITableViewCellEditingStyleDelete´
 */
@property (nonatomic, assign) UITableViewCellEditingStyle editingStyle;

/**
 *  Whether the cell should be indented while editing or not. By default ´YES´.
 */
@property (nonatomic, assign) BOOL shouldIndentWhileEditing;

/**
 *  The target of an action called when the cell is tapped.
 */
@property (nonatomic, assign, readonly) id target;

/**
 *  Action called when the cell is tapped.
 *
 *  @param target The target of the action
 *  @param action Action called when cell is tapped
 */
- (void)setTarget:(id)target action:(SEL)action;

/**
 *  For internal usage.
 */
- (void)cellWasTapped;

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
