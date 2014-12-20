//

#import <UIKit/UIKit.h>

@interface LabelCell : UITableViewCell

@property (nonatomic, strong, readonly) UILabel *label;

/**
 *  The margins of the label relative to the content view
 */
@property (nonatomic, assign) UIEdgeInsets margins;

/**
 *  Calculates the height of the cell
 *
 *  @param text           The text meant to be displayed in the label
 *  @param tableViewWidth The width of the tableview where the cell will be displayed
 *  @param margins        The margins surrounding the label
 *  @param font           The font of the label
 *
 *  @return The cell height
 */
+ (CGFloat)cellHeightWithText:(NSString *)text
               tableViewWidth:(CGFloat)tableViewWidth
                      margins:(UIEdgeInsets)margins font:(UIFont *)font;

/**
 *  Calculates the height of the cell
 *
 *  @param attributedText The attributed text
 *  @param tableViewWidth The width of the tableview where the cell will be displayed
 *  @param margins        The margins surrounding the label
 *
 *  @return The cell height
 */
+ (CGFloat)cellHeightWithAttributedText:(NSAttributedString *)attributedText
                         tableViewWidth:(CGFloat)tableViewWidth
                                margins:(UIEdgeInsets)margins;

@end
