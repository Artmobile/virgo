//
//  UserActivityManager.h
//  virgo
//
//  Created by Ilya Alberton on 5/20/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserActivityManager : NSObject
+ (NSString*) doLogin: (NSString*)server forUsername:(NSString*) username forPassword:(NSString*)password error:(NSError**)error;
@end
