With DLTableView table view code can be written in a declarative fashion. It also solves the following problems associated with table views.
- Conditionally hiding of cells and sections.
- The mental burden of keeping data source index paths in synch with the delegate.

It alse reduces the number of UITableViewCells needed to be created. Often a page can be rendered with a few base cell classes.


## Example of usage

```objective-c
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    DLCellItem *cell = [DLCellItem new];
    cell.reuseIdentifier = @"UITableViewCell";
    cell.height = 44;
    [cell setTarget:self action:@selector(cellTapped:)];
    cell.willDisplayBlock = ^(DLCellItem *cellItem, UITableViewCell *cell) {
         cell.textLabel.text = @"Title";
    };
    
    self.tableView.sections = @[[DLSectionItem itemWithCells:@[cell]]];
```

## License

DLTableView is available under the MIT license. See the LICENSE file for more info.
