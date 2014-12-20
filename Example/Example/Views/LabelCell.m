
#import "LabelCell.h"

@interface LabelCell ()

@property (nonatomic, strong, readwrite) UILabel *label;

@end

@implementation LabelCell

CGRect TBLRectEdgeInset(CGRect rect, UIEdgeInsets insets);

CGRect TBLRectEdgeInset(CGRect rect, UIEdgeInsets insets) {
    return CGRectMake(CGRectGetMinX(rect) + insets.left, CGRectGetMinY(rect) + insets.top, CGRectGetWidth(rect) - insets.left - insets.right, CGRectGetHeight(rect) - insets.top -insets.bottom);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [UILabel new];
        _label.numberOfLines = 0;
        _label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_label];
    }
    return self;
}

- (UILabel *)textLabel {
    NSLog(@"Warning! Dont use textLabel. Use label.");
    return [super textLabel];
}

- (void)setMargins:(UIEdgeInsets)margins {
    _margins = margins;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = TBLRectEdgeInset(self.contentView.bounds, self.margins);
}

+ (CGFloat)cellHeightWithText:(NSString *)text
               tableViewWidth:(CGFloat)tableViewWidth
                      margins:(UIEdgeInsets)margins
                         font:(UIFont *)font
{
    
    CGSize maximumLabelSize = CGSizeMake(tableViewWidth - margins.left - margins.right, CGFLOAT_MAX);
    
    
    CGRect labelRect = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    CGSize labelSize = labelRect.size;
    
    return 1 + ceilf(labelSize.height + margins.top + margins.bottom);
}


+ (CGFloat)cellHeightWithAttributedText:(NSAttributedString *)attributedText
                         tableViewWidth:(CGFloat)tableViewWidth
                                margins:(UIEdgeInsets)margins {
    
    CGSize maximumLabelSize = CGSizeMake(tableViewWidth - margins.left - margins.right, CGFLOAT_MAX);
    CGRect paragraphRect = [attributedText boundingRectWithSize:maximumLabelSize
                                                        options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                        context:nil];
    
    return ceilf(paragraphRect.size.height);
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.backgroundView = nil;
    self.label.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = nil;
}

@end
