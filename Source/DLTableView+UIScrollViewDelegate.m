
#import "DLTableView+UIScrollViewDelegate.h"
#import "DLCellItem+Private.h"
#import "DLTableView+Private.h"

@implementation DLTableView (UIScrollViewDelegate)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.externalDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.externalDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if ([self.externalDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.externalDelegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.externalDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.externalDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.externalDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.externalDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.externalDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.externalDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.externalDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.externalDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.externalDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.externalDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.externalDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.externalDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if ([self.externalDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.externalDelegate viewForZoomingInScrollView:scrollView];
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    if ([self.externalDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.externalDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if ([self.externalDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.externalDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}


- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if ([self.externalDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.externalDelegate scrollViewShouldScrollToTop:scrollView];
    }
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.externalDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.externalDelegate scrollViewDidScrollToTop:scrollView];
    }
}

@end
