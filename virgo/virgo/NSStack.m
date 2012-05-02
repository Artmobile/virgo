//
//  NSStack.m
//  virgo
//
//  Created by Ilya Alberton on 5/2/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import "NSStack.h"

@implementation NSMutableArray (NSStack)



- (void) push: (NSObject*) object{
    if(object == Nil)
        [NSException  raise:@"Can't push an object to the stack" format:@"Object was Nil"];

    [self addObject:object];
}
- (NSObject*) pop {
    if([self count] <= 0)
        return Nil;
    
    NSObject* object = [self objectAtIndex: [self count] -1];  // take out the last one
    [self removeObjectAtIndex:  [self count] -1];
    return object;
}


@end
