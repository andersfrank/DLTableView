
#import "DrawViewCell.h"
#import "DrawView.h"

@interface DrawViewCell ()

@property (nonatomic, strong, readwrite) DrawView *drawView;

@end

@implementation DrawViewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self postInit];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self postInit];
    }
    return self;
}

- (void)postInit {
    
    self.drawView = [DrawView new];
    self.drawView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.drawView];
    
}



- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.drawView.frame = self.bounds;
    
}

@end
