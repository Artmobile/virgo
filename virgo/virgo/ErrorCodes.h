//
//  ErrorCodes.h
//  virgo
//
//  Created by Ilya Alberton on 5/8/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

// Small macros to help with handling of the NSError switch blocks
// See example below on how to use this helper macro
/*
 WITHIN_DOMAIN(error, DOMAIN_NSURLERRORDOMAIN)
     case -1004:    
     case -1003:
     case -1002:    
         STFail(@"There was no connection. Please check that the application is started at %@", currentServer);
         break;
     default:
         break;
 END_WITHIN_DOMAIN_ELSE
 WITHIN_DOMAIN(error, DOMAIN_XODIAC)
     case X_CODE_LOGIN_FAILED:
         // TODO: Currently SecureAjax returns code 7 for invalid login. Must change it
         NSLog(@"Failed to login user %@", @"wrong");
         break;
     case X_CODE_NO_CONNECTION:
         NSLog(@"Connection to the server %@ could not be made", currentServer);
         break;
     default:
         NSLog(@"Unknown error occurred!");
         break;
 END_WITHIN_DOMAIN

*/ 

#define WITHIN_DOMAIN(ERROR, DOMAIN) if ( [[ERROR domain] isEqualToString:DOMAIN] ) { switch (ERROR.code) {
#define END_WITHIN_DOMAIN }}
#define END_WITHIN_DOMAIN_ELSE }} else


extern NSString * const DOMAIN_XODIAC;
extern NSString * const DOMAIN_NSURLERRORDOMAIN;
extern NSString * const DOMAIN_AJAX_SECURELOGIN;

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


