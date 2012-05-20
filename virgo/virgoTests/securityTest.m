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

- (NSDictionary*)connectAndLogin:(NSString*) server username:(NSString*)username password:(NSString*) password error:(NSError**) error{
    NSString* _currentKey;
    NSError* err;
    
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if([mainDelegate currentKey] == Nil || mainDelegate.currentKey.length <=0){
        _currentKey = [SecureJsonChannel negotiateKey:server error: &err];
    }
    else
        _currentKey = [mainDelegate currentKey];
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    
    [params setObject:username forKey:@"userName"];
    [params setObject:password forKey:@"password"];
    
    NSDictionary* result = [SecureJsonChannel get: [NSString stringWithFormat: @"%@/securesocialajax/login", server] params:params andPassword:_currentKey error:&err];

    *error = err;
    
    return result;
}

- (void) testSecureLogin {
    
    NSString* currentServer = @"http://localhost:9001";
    
    // Important! Reset error object before using it
    NSError* error = Nil;

    NSDictionary* result = [self connectAndLogin: currentServer username:@"test" password:@"test" error:&error];
    
    // There should be no error - everything runs as expected
    NSString* admin_id = [result objectForKey:@"admin_id"]; 
}

- (void)testWrongLogin{
    
    NSString* currentServer = @"http://localhost:9001";
    // Important! Reset error object before using it
    NSError* error = Nil;
    
//    NSString* admin_id =  [UserActivityManager doLogin:currentServer forUsername:@"wrong" forPassword:@"wrong" error:&error];   

    
    NSString* admin_id =  [UserActivityManager doLogin:currentServer forUsername:@"wrong" forPassword:@"wrong" error:&error];   
    

    if(!error){
        STFail("No error was return when wrong username and password were passed to the doLogin function");
        return;
    }
    
    if(error){
        if ( [[error domain] isEqualToString:DOMAIN_NSURLERRORDOMAIN] ) {
            switch (error.code) {
                case -1003:
                    STFail(@"There was no connection. Please check that the application is started at %@", currentServer);
                    break;
                default:
                    break;
            }
        }
        else if ( [[error domain] isEqualToString:DOMAIN_XODIAC] ) {
            switch (error.code) {
                case X_CODE_LOGIN_FAILED:
                    // TODO: Currently SecureAjax returns code 7 for invalid login. Must change it
                    NSLog(@"Failed to login user %@", @"wrong");
                    break;
                default:
                    break;
            }
        }
    }
    
    /*
    NSDictionary* result = [self connectAndLogin: currentServer username:@"wrong" password:@"wrong" error:&error];
    
    STAssertNotNil(error, @"Wrong user and password were specified but error returned was Nil");
    
    
    if(error){
        if ( [[error domain] isEqualToString:DOMAIN_NSURLERRORDOMAIN] ) {
            switch (error.code) {
                case -1003:
                    STFail(@"There was no connection. Please check that the application is started at %@", currentServer);
                    break;
                default:
                    break;
            }
        }
        else if ( [[error domain] isEqualToString:DOMAIN_XODIAC] ) {
            switch (error.code) {
                case 7:
                    // TODO: Currently SecureAjax returns code 7 for invalid login. Must change it
                    NSLog(@"Failed to login user %@", @"wrong");
                    break;
                default:
                    break;
            }
        }
    }
     */
}

- (void)testSecureLoginNoServer {
    NSString* currentServer = @"http://serverthatdoesnotexist:9001";
    
    // Important! Reset error object before using it
    NSError* error = Nil;
    
    NSDictionary* result = [self connectAndLogin: currentServer username:@"test" password:@"test" error:&error];
    
    STAssertEquals(error.code, -1003, @"Expected to recieve -1003 when there is no connection");
    
    // Check the error if not successfull
    if(error){
        switch(error.code){
            case -1003:
                NSLog(@"There was no connection");
                break;
        }
    }
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
