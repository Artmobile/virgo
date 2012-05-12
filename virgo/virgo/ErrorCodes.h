//
//  ErrorCodes.h
//  virgo
//
//  Created by Ilya Alberton on 5/8/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    xOk             = 0,
    xNoConnection   = 1,
    xInvalidJson    = 2,
    xTimeout        = 4,
    xHttpError      = 8
};

@interface ErrorCodes : NSObject


@end


@implementation ErrorCodes



@end