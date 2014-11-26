DLTableView makes working with table views easier and less messy. 

- It solves the complex problem of conditionally hide cells and sections.
- It reduces the number of UITableViewCells needed to be created. Often a page can be rendered with a few base cell classes.


## Example of usage

```objective-c
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    DLCellItem *cell = [DLCellItem new];
    cell.height = 44;
    [cell setTarget:self action:@selector(cellTapped:)];
    cell.willDisplayBlock = ^(DLCellItem *cellItem, UITableViewCell *cell) {
         cell.textLabel.text = @"Title";
    };
    
    self.tableView.sections = @[[DLSectionItem itemWithCells:@[cell]]];
```

## License

DLTableView is available under the MIT license. See the LICENSE file for more info.
