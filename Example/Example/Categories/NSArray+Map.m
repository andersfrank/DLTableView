//
//  NSArray+Map.m
//  Example
//
//  Created by Anders Frank on 2014-12-19.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import "NSArray+Map.h"

@implementation NSArray (Map)

- (NSArray *)arrayByMappingWithBlock:(MapBlock)block {
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity: [self count]];
    
    for (id value in self) {
        id o = block(value);
        if (o)
            [ret addObject:o];
    }
    
    return [NSArray arrayWithArray: ret];
}

@end
