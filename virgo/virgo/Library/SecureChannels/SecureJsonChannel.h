

#import <Foundation/Foundation.h>

@interface SecureJsonChannel : NSObject
+ (NSString*) negotiateKey:(NSString*) server error:(NSError**)error;
+ (NSDictionary*) get:(NSString*)url params:(NSDictionary*) params andPassword:(NSString*) password error:(NSError**)error;
+ (NSDictionary*) decryptDictionary: (NSString*) encryptedDictionary password:(NSString*) password;
@end
