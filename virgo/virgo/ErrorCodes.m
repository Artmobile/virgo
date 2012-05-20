#import "ErrorCodes.h"


NSString * const DOMAIN_XODIAC = @"org.xodiac";
NSString * const DOMAIN_NSURLERRORDOMAIN = @"NSURLErrorDomain";


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