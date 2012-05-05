//
//  LoginManager.m
//  virgo
//
//  Created by Ilya Alberton on 5/5/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import "LoginManager.h"
#import "JsonHelper.h"

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
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    
    [params setObject:@"artmobile" forKey:@"userName"];
    [params setObject:@"sixpens" forKey:@"password"];
    
    NSDictionary* result = [JsonHelper get:@"http://localhost:9001/securesocialajax/loginByUserPassword" params:params timeoutInterval:60.0];
    
    return [result objectForKey:@"admin_id"];
}

@end
