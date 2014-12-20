
#import "DLCellItem.h"

@interface DLCellItem ()

@property (nonatomic, assign) BOOL needsReload;
@property (nonatomic, copy) NSString *action;
@property (nonatomic, assign, readwrite) id target;

@end

@implementation DLCellItem

- (id)init
{
    self = [super init];
    if (self) {
        self.shouldIndentWhileEditing = YES;
        self.height = UITableViewAutomaticDimension;
        self.indentationLevel = UITableViewAutomaticDimension;
        self.editingStyle = UITableViewCellEditingStyleDelete;
    }
    return self;
}

+ (DLCellItem *)itemWithModel:(id)model height:(CGFloat)height reuseIdentifier:(NSString *)reuseIdentifier target:(id)target action:(SEL)action willDisplay:(WillDisplayBlock)willDisplayBlock {
    DLCellItem *item = [DLCellItem new];
    item.reuseIdentifier = reuseIdentifier;
    item.height = height;
    item.model = model;
    item.willDisplayBlock = willDisplayBlock;
    [item setTarget:target action:action];
    return item;
}

+ (NSArray *)itemsWithModels:(NSArray *)models height:(CGFloat)height reuseIdentifier:(NSString *)reuseIdentifier target:(id)target action:(SEL)action willDisplay:(WillDisplayBlock)willDisplayBlock {
    NSMutableArray *cells = [NSMutableArray arrayWithCapacity:models.count];
    for (id model in models) {
        [cells addObject:[DLCellItem itemWithModel:model height:height reuseIdentifier:reuseIdentifier target:target action:action willDisplay:willDisplayBlock]];
    }
    return [NSArray arrayWithArray:cells];
}

- (void)cellWasTapped {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (self.action) {
        if ([self.action hasSuffix:@":"]) {
            [self.target performSelector:NSSelectorFromString(self.action) withObject:self];
        } else {
            [self.target performSelector:NSSelectorFromString(self.action)];
        }
    
    }
    #pragma clang diagnostic pop
}

- (void)setTarget:(id)target action:(SEL)action {
    self.target = target;
    self.action = NSStringFromSelector(action);
}

- (void)setNeedsReload {
    self.needsReload = YES;
}

@end
