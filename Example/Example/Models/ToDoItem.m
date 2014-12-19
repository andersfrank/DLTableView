//
//  ToDoItem.m
//  Example
//
//  Created by Anders Frank on 2014-12-19.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

- (instancetype)initWithTitle:(NSString *)title done:(BOOL)done {
    
    self = [super init];
    if (self) {

        self.title = title;
        self.done = done;
        
    }
    return self;
}

@end
