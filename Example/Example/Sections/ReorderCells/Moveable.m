//
//  Moveable.m
//  Example
//
//  Created by Anders Frank on 2014-12-20.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import "Moveable.h"

@implementation Moveable

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    if (self) {
        _text = text;
    }
    return self;
}

@end
