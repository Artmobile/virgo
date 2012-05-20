//
//  ErrorCodes.h
//  virgo
//
//  Created by Ilya Alberton on 5/8/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const DOMAIN_XODIAC;
extern NSString * const DOMAIN_NSURLERRORDOMAIN;

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

+ (NSString*) toString:(X_CODE)code;


@end


