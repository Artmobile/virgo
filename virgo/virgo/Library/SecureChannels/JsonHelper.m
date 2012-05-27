//
//  JsonHelper.m
//  xoc
//
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//


#import "JsonHelper.h"
#import "ErrorCodes.h"
#import "JSONKit.h"

@implementation JsonHelper
 
+ (NSDictionary*) creaeErrorTransport: (NSString*) domain code: (NSInteger) code message:(NSString*) message{
    NSMutableDictionary* transport = [[NSMutableDictionary alloc] init];
    
    [transport setObject: domain forKey:@"domain"];
    [transport setObject:[NSString stringWithFormat:@"%d", code] forKey:@"code"];
    [transport setObject:message forKey:@"message"];
    
    return transport;
}

+ (NSDictionary*) createTransport: (NSDictionary*) data error: (NSDictionary*) error{
    NSMutableDictionary* transport = [[NSMutableDictionary alloc] init];
    
    if(!data)
        data = [[NSDictionary alloc] init];

    if(!error)
        error = [[NSDictionary alloc] init];

    
    [transport setObject:data forKey:@"data"];
    [transport setObject:error forKey:@"error"];
    
    return transport;
}

/*! 
 @method get:
 @abstract Retrieves JSON from provided URL.
 @discussion This function will return a Dictionary populated from JSON response.
 @param URL to fetch  JSON from and the timeInterval to wait for response.
 @result A newly-created and autoreleased NSURLRequest instance.
 */ 
+ (NSDictionary*) get: 
    (NSString*) url 
    params:(NSDictionary*)params 
    timeoutInterval:(NSTimeInterval) timeoutInterval 
    error:(NSError**) error
{
    NSMutableString* finalUrl = [[url mutableCopy] autorelease];
    
    // Check if we already have query inserted
    if(params != Nil){
        BOOL initialized = [url rangeOfString:@"?"].location != NSNotFound;
        
        for (NSString* key in params) {
            id value = [params objectForKey:key];
            
            if(!initialized){    
                [finalUrl appendFormat:@"?%@=%@", key, value];
                initialized = true;
            }
            else
                [finalUrl appendFormat:@"&%@=%@", key, value];
        }    
    }

    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:finalUrl]
                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                       timeoutInterval:timeoutInterval];  
    NSError* err = Nil;
    
    NSHTTPURLResponse* response; 
    
    NSData* jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];   
    
    
    if(err)
    {
        NSInteger code = [err code];
        NSString* domain = [err domain];
        NSString* message = [err localizedDescription]; 
        
        // Pass the error outside
        *error = err;
        
        // Prepare an error object and 
        return [JsonHelper createTransport:Nil error:[JsonHelper creaeErrorTransport:domain code:code message:message]];
    }
    
    if([response statusCode] == 200){
        
        JSONDecoder* decoder = [[JSONDecoder alloc] init];    
        NSDictionary *dict = [decoder objectWithData:jsonData];
        
        return dict;
    }
    else if(response == Nil){
        // We failed to connect so return no connection error
        err = [NSError errorWithDomain:DOMAIN_XODIAC 
                                  code: X_CODE_NO_CONNECTION  
                              userInfo:Nil];

        return [[NSDictionary alloc]init];    
    }
    else{    
        // Any other HTTP error
        err = [NSError errorWithDomain:DOMAIN_XODIAC 
                                  code: X_CODE_HTTP_ERROR
                              userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: @"HttpResponse", response, nil]];

        return [[NSDictionary alloc]init];
    }
}
@end
