//
//  LoginManager.h
//  virgo
//
//  Created by Ilya Alberton on 5/5/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginManager : NSObject
+ (NSString*) doLogin:(NSString*) username andPassword:(NSString*) password;
@end
