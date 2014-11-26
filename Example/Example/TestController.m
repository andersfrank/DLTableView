//
//  TestController.m
//  Example
//
//  Created by Anders Frank on 2014-11-19.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import "TestController.h"

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = @"En textlabel adfasdf sdafasdf adsfadfs";
    return cell;
}

@end
