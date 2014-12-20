

#import "DrawView.h"

@implementation DrawView

- (void)setDrawBlock:(DrawBlock)drawBlock {
    _drawBlock = drawBlock;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    if (self.drawBlock) {
        self.drawBlock(UIGraphicsGetCurrentContext(), rect);
    }
    
}


@end
