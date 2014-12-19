//
//  NSArray+Map.h
//  Example
//
//  Created by Anders Frank on 2014-12-19.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^MapBlock)(id object);

@interface NSArray (Map)

- (NSArray *)arrayByMappingWithBlock:(MapBlock)block;

@end
