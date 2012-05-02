//
//  NSStack.h
//  virgo
//
//  Created by Ilya Alberton on 5/2/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (NSStack)
- (void) push: (NSObject*) object;
- (NSObject*) pop;
@end
