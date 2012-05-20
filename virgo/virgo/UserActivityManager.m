//
//  UserActivityManager.m
//  virgo
//
//  Created by Ilya Alberton on 5/20/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import "UserActivityManager.h"
#import "JsonHelper.h"
#import "virgoAppDelegate.h"
#import "SecureJsonChannel.h"
#import "ErrorCodes.h"
#import "ErrorCodes.h"

@implementation UserActivityManager

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (NSDictionary*)connectAndLogin:(NSString*) server username:(NSString*)username password:(NSString*) password error:(NSError**) error{
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


+ (NSString*) doLogin: (NSString*) server forUsername:(NSString*) username forPassword:(NSString*)password error:(NSError**)error{
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    NSString* _currentKey = [mainDelegate currentKey];
    
    // Important! Reset error object before using it
    NSError* err = Nil;
    
    NSDictionary* result = [self connectAndLogin: server username:@"wrong" password:@"wrong" error:&err];
    
    if(error){
        if ( [[err domain] isEqualToString:@"SecureSocialAjax.login"] ) {
            switch (err.code) {
                case 7:
                    *error = [NSError errorWithDomain:DOMAIN_XODIAC 
                                                 code: X_CODE_LOGIN_FAILED
                                             userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: 
                                                       @"username", username, 
                                                       @"password", password,
                                                       NSLocalizedDescriptionKey, @"Failed to login",
                                                       nil]];
                    return @"";
                default:
                    // Unknown error occurred while trying to login
                    *error = [NSError errorWithDomain:DOMAIN_XODIAC 
                                                 code: X_CODE_UNKNOWN
                                             userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: 
                                                       @"username", username, 
                                                       @"password", password,
                                                       NSLocalizedDescriptionKey, @"Unknown error occurred while trying to login",
                                                       nil]];
                    return @"";
            }
        }
    }    
    NSString* data = [result objectForKey:@"data"];
    
    NSDictionary* dict = [SecureJsonChannel decryptDictionary:data password:_currentKey]; 
    
    return [dict objectForKey:@"admin_id"]; 
}


@end
