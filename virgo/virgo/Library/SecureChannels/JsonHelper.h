//
//  JsonHelper.h
//  xoc
//
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonCryptor.h>

@interface JsonHelper : NSObject

+ (NSDictionary*)       get: 
    (NSString*) url 
    params:(NSDictionary*) params  
    timeoutInterval:(NSTimeInterval) timeoutInterval
    error:(NSError**) error;

+ (NSDictionary*) creaeErrorTransport: (NSString*) domain code: (NSInteger) code message:(NSString*) message;
+ (NSDictionary*) createTransport: (NSDictionary*) data error: (NSDictionary*) error;
@end
