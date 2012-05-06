//
//  LoginManager.m
//  virgo
//
//  Created by Ilya Alberton on 5/5/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import "LoginManager.h"
#import "JsonHelper.h"
#import "virgoAppDelegate.h"
#import "SecureJsonChannel.h"

@implementation LoginManager

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


+ (NSString*) doLogin:(NSString*) username andPassword:(NSString*) password{
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    NSString* _currentKey = [mainDelegate currentKey];
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    
    [params setObject:username forKey:@"userName"];
    [params setObject:password forKey:@"password"];
    
    NSDictionary* result = [JsonHelper get:@"http://localhost:9001/securesocialajax/login" params:params timeoutInterval:60.0];
    
    NSString* data = [result objectForKey:@"data"];
    
    NSDictionary* dict = [SecureJsonChannel decryptDictionary:data password:_currentKey]; 
    
    return [dict objectForKey:@"admin_id"]; 
}

@end
