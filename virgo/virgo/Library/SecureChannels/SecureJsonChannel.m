#import "SecureJsonChannel.h"
#import "JSONKit.h"
#import "JsonHelper.h"
#import "Base64Encoder.h"
#import "Cipher.h"
#import "ErrorCodes.h"


@implementation SecureJsonChannel

+ (NSString*) permanent {
    return @"A34vB1007688";
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
 
+ (NSDictionary*) get:(NSString*)url params:(NSDictionary*)params andPassword:(NSString*) password error:(NSError**)error {
    NSError* err = Nil;
    
    NSTimeInterval timeout = 60.0;
    
    NSDictionary* result = [JsonHelper get:url params:params timeoutInterval:timeout error:&err];
    
    if(err){
        *error = err;
        return Nil;
    }
    
    
    // Check if there is a transport error
    NSDictionary* errorTransport =  [result objectForKey:@"error"];
    if(errorTransport){
        
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:[errorTransport objectForKey:@"message"] forKey:NSLocalizedDescriptionKey];
        
        err = [NSError errorWithDomain:[errorTransport objectForKey:@"domain"] 
                                 code: [[errorTransport objectForKey:@"code"] intValue]  
                                 userInfo:errorDetail];
        
        *error = err;
        
        return Nil;
    }
    
    // Get a string from JSON. The string must be Base64 encoded by sender
    NSString* str = [result objectForKey:@"data"];
    
    // Convert string into NSData
    NSData* dat= [NSData dataWithBase64EncodedString:str];
    
    // Execute Cipher
    Cipher* cipher = [[Cipher alloc] initWithKey:password];
    NSData* decrypted = [cipher decrypt:dat];
    
    JSONDecoder* decoder = [[JSONDecoder alloc] init];    
    NSDictionary *dict = [decoder objectWithData:decrypted];

    return dict;
}

+ (NSString*) negotiateKey:(NSString*) server error:(NSError**)error{
    NSString* url = [NSString stringWithFormat: @"%@/SecureSocialAjax/negotiate?password=%@", server, [self permanent]];    
    
    // Convert string into NSData
    NSMutableDictionary* result = [[SecureJsonChannel get:url params:Nil andPassword:[self permanent] error:error] mutableCopy];
    
    if(result.count <= 0)
        return Nil;

    return [result objectForKey:@"key"];
}

+ (NSDictionary*) decryptDictionary: (NSString*) encryptedDictionary password:(NSString*) password {
    // Convert string into NSData
    NSData* dat= [NSData dataWithBase64EncodedString:encryptedDictionary];
    
    // Execute Cipher
    Cipher* cipher = [[Cipher alloc] initWithKey:password];
    NSData* decrypted = [cipher decrypt:dat];
    
    JSONDecoder* decoder = [[JSONDecoder alloc] init];    
    return [decoder objectWithData:decrypted];
}

@end
