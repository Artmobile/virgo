    //
//  securityTest.m
//  virgo
//
//  Created by Ilya Alberton on 5/7/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import "securityTest.h"
#import "JsonHelper.h"
#import "Cipher.h"
#import "Base64Encoder.h"
#import "SecureJsonChannel.h"
#import "virgoAppDelegate.h"
#import "ErrorCodes.h"
#import "UserActivityManager.h"

@implementation securityTest

#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void)testAppDelegate {
    
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
    
}

- (void) testSecureLogin {
    
    NSString* currentServer = @"http://localhost:9001";
    
    // Important! Reset error object before using it
    NSError* error = Nil;

    NSString* admin_id =  [UserActivityManager doLogin:currentServer forUsername:@"test" forPassword:@"test" error:&error];   
    
    WITHIN_DOMAIN(error, DOMAIN_XODIAC)
        case X_CODE_LOGIN_FAILED:
            STFail(@"Username %@ was supposed to be able log in. Please check your test configuration", @"test");
            break;
        case X_CODE_NO_CONNECTION:
            STFail(@"The test was failed because there is no connection to the server");
            break;
        default:
            STFail(@"Unknown error occurred!");
            break;
    END_WITHIN_DOMAIN
    
    
    STAssertNotNil(admin_id, @"Admin id was empty");
    
    NSLog(@"Admin_id was %@", admin_id);
}

- (void)testWrongLogin{
    
    NSString* currentServer = @"http://localhost:9001";
    // Important! Reset error object before using it
    NSError* error = Nil;
    
    NSString* admin_id =  [UserActivityManager doLogin:currentServer forUsername:@"wrong" forPassword:@"wrong" error:&error];   

    STAssertNotNil(admin_id, @"Admin id was returned not empty when using wrong credentials during login");
    
    WITHIN_DOMAIN(error, DOMAIN_XODIAC)
        case X_CODE_LOGIN_FAILED:
            // Falling through here is perfectly fine.
            // Just print the message
            NSLog(@"Failed to login user %@", @"wrong");
            break;
        case X_CODE_NO_CONNECTION:
            STFail(@"The test was failed because there is no connection to the server");
            break;
        default:
            STFail(@"Unknown error occurred!");
            break;
    END_WITHIN_DOMAIN
}

- (void)testSecureLoginNoServer {
    NSString* server = @"http://serverthatdoesnotexist:9001";
    
    // Important! Reset error object before using it
    NSError* error = Nil;
    
    // Don't bother to return anything as we do not intend to actually hit the server
    [UserActivityManager doLogin:server forUsername:@"test" forPassword:@"test" error:&error];   
    
    WITHIN_DOMAIN(error, DOMAIN_XODIAC)
        case X_CODE_LOGIN_FAILED:
            STFail(@"Connection to server was done but shouldn't have. Please check the test configuration");
            break;
        case X_CODE_NO_CONNECTION:
            NSLog(@"Connection to the server %@ could not be made as expected", server);
    
            // Now let's have an inner error and try to figure what was the 
            // reason for not being able to connect
            NSError* inner = [[error userInfo] objectForKey:@"innerError"];
            switch(inner.code){
                case -1004:
                    NSLog(@"The server was down but it was a valid server");
                    break;
                case -1003:
                    NSLog(@"The server doesn't exist");
                    break;
                case -1002:
                    NSLog(@"An invalid URL has been provided");
                    break;
            }            
            break;
        default:
            STFail(@"Unknown error occurred!");
            break;
    END_WITHIN_DOMAIN
}

-(void)testBase64 {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSString* source = @"Quick brown fox"; 
    
    NSString* enc = [source toBase64];
    
    NSString* destination;
    @try {
        destination = [enc fromBase64];
        
        // Verify result
        STAssertEquals(source, destination, @"Base64 converion test failed. Expected %@, got %@", source, destination);
        
    }
    @catch(NSException* exception)
    {
        NSArray *backtrace = [exception callStackSymbols];
        NSString *message = [NSString stringWithFormat:@"Backtrace:\n%@",
                             backtrace];
        
        NSLog(@"Exception occurred while performing base64 decoding. Message: %@", message);    
    }
    @finally {
        [pool drain];
        
    }
}

- (void)testCipherChannel{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSString* key = [SecureJsonChannel negotiateKey:@"http://localhost:9001"];
    
    NSString* message = @"One%20way";
    
    NSDictionary* result = [SecureJsonChannel get:
                            [NSString stringWithFormat: @"http://localhost:9001/securesocialajax/testNested?message=%@", message] 
                                      andPassword:key];
    
    NSLog(@"%@", [result objectForKey:@"content"]);
    
    [pool drain];
}

- (void)testCipher{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSDictionary* result = [JsonHelper get:@"http://localhost:9001/securesocialajax/test?message=One%20way&password=ticktick" timeoutInterval:60.0];
    
    // Get a string from JSON. The string must be Base64 encoded by sender
    NSString* str = [result objectForKey:@"data"];
    
    // Convert string into NSData
    NSData* dat= [NSData dataWithBase64EncodedString:str];
    
    // Execute Cipher
    Cipher* cipher = [[Cipher alloc] initWithKey:@"ticktick"];
    NSData* decrypted = [cipher decrypt:dat];
    
    // Convert the decrypted result into text
    NSString* plainText = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    // Print it
    NSLog(@"%@",plainText);
    
    [pool drain];
}


#else                           // all code under test must be linked into the Unit Test bundle


#endif

@end
