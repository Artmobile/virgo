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
    NSError* err = nil;
    
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if([mainDelegate currentKey] == Nil || mainDelegate.currentKey.length <=0){
        _currentKey = [SecureJsonChannel negotiateKey:server error: &err];
    }
    else
        _currentKey = [mainDelegate currentKey];
    
    if(err){
        // Probably we could not reach the server
        *error = err;
        return [[NSDictionary alloc] init];
    }
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    
    [params setObject:username forKey:@"userName"];
    [params setObject:password forKey:@"password"];
    
    NSDictionary* result = [SecureJsonChannel get: [NSString stringWithFormat: @"%@/securesocialajax/login", server] params:params andPassword:_currentKey error:&err];
    
    if(err)
        *error = err;
    
    return result;
}


+ (NSString*) doLogin: (NSString*) server forUsername:(NSString*) username forPassword:(NSString*)password error:(NSError**)error{
    
    // Important! Reset error object before using it
    NSError* err = Nil;
    
    NSDictionary* result = [self connectAndLogin: server username:username password:password error:&err];
    
    if(err){
        WITHIN_DOMAIN(err,DOMAIN_AJAX_SECURELOGIN)            
                case 7:
                    *error = [NSError errorWithDomain:DOMAIN_XODIAC 
                                                 code: X_CODE_LOGIN_FAILED
                                             userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: 
                                                       username, @"username", 
                                                       password, @"password",
                                                       err,@"innerError",
                                                       @"Failed to login", NSLocalizedDescriptionKey, 
                                                       nil]];
                    return @"";
                default:
                    // Unknown error occurred while trying to login
                    *error = [NSError errorWithDomain:DOMAIN_XODIAC 
                                                 code: X_CODE_UNKNOWN
                                             userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: 
                                                       username, @"username", 
                                                       password, @"password",
                                                       err, @"innerError",
                                                       @"Unknown error occurred while trying to login" ,NSLocalizedDescriptionKey,
                                                       nil]];
                    return @"";
        END_WITHIN_DOMAIN_ELSE    
        WITHIN_DOMAIN(err, DOMAIN_NSURLERRORDOMAIN)
                case -1002:    
                case -1003:
                case -1004:    
                    *error = [NSError errorWithDomain:DOMAIN_XODIAC 
                                                 code: X_CODE_NO_CONNECTION
                                             userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: 
                                                       username, @"username", 
                                                       password, @"password",
                                                       err, @"innerError", 
                                                       @"Could not establish connection during login", NSLocalizedDescriptionKey, 
                                                       nil]];
                    return @"";
                default:
                    // Unknown error occurred while trying to login
                    *error = [NSError errorWithDomain:DOMAIN_XODIAC 
                                                 code: X_CODE_UNKNOWN
                                             userInfo:[[NSDictionary alloc] initWithObjectsAndKeys: 
                                                       username, @"username",  
                                                       password, @"password", 
                                                       err, @"innerError", 
                                                       @"Unknown connection error occurred while trying to login", NSLocalizedDescriptionKey, 
                                                       nil]];
                    return @"";
        END_WITHIN_DOMAIN
    }    
    
    return [result objectForKey:@"admin_id"];
}


@end
