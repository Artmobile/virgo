//
//  ErrorCodes.h
//  virgo
//
//  Created by Ilya Alberton on 5/8/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    X_CODE_UNKNOWN           = 0,
    X_CODE_OK                = 1,
    X_CODE_NO_CONNECTION     = 2,
    X_CODE_INVALID_JSON      = 4,
    X_CODE_TIMEOUT           = 8,
    X_CODE_HTTP_ERROR        = 16,
    X_CODE_LOGIN_FAILED      = 32
};

typedef NSInteger X_CODE;

@interface ErrorCodes : NSObject


@end


@implementation ErrorCodes

+ (NSString*) toString:(X_CODE)code{
    switch(code){
        case X_OK:
            return @"OK";
        case X_CODE_LOGIN_FAILED:
            return @"Login Failed";
        case X_CODE_NO_CONNECTION:
            return @"No connection";
        case X_CODE_TIMEOUT:
            return @"Timeout occurred";
        case X_CODE_INVALID_JSON:
            return @"Invalid JSON format";
        case X_CODE_HTTP_ERROR:
            return @"Http error was returned to the caller";
        default:
            return X_CODE_UNKNOWN;
    }
}

@end