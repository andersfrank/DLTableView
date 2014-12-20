//
//  Moveable.h
//  Example
//
//  Created by Anders Frank on 2014-12-20.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Moveable : NSObject

@property (nonatomic, readonly) NSString *text;

- (instancetype)initWithText:(NSString *)text;

@end
