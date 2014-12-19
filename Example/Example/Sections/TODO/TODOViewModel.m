//
//  ToDoViewModel.m
//  Example
//
//  Created by Anders Frank on 2014-12-19.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import "ToDoViewModel.h"
#import "ToDoItem.h"
#import "NSArray+Map.h"

@interface ToDoViewModel ()

@property (nonatomic) NSArray *toDoItems;

@end

@implementation ToDoViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.toDoItems =
        @[
          [[ToDoItem alloc] initWithTitle:@"Buy milk" done:NO],
          [[ToDoItem alloc] initWithTitle:@"Email Caroline, John, Erica, Robert, Nick, Steve, Robert and Dave about dinner" done:NO],
          [[ToDoItem alloc] initWithTitle:@"Order books" done:NO],
          [[ToDoItem alloc] initWithTitle:@"Borrow Laura´s Car" done:YES],
          [[ToDoItem alloc] initWithTitle:@"Return movies" done:YES]
          ];
        
        
    }
    return self;
}

@end
