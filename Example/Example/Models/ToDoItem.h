//
//  ToDoItem.h
//  Example
//
//  Created by Anders Frank on 2014-12-19.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property (nonatomic, assign) BOOL done;
@property (nonatomic, strong) NSString *title;

- (instancetype)initWithTitle:(NSString *)title done:(BOOL)done;

@end
