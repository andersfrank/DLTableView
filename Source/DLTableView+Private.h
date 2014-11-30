
@interface DLTableView ()

@property (nonatomic, assign) id <UITableViewDelegate> externalDelegate;
@property (nonatomic, assign) id <UITableViewDataSource> externalDataSource;

@end
