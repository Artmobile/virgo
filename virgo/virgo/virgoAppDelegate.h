//
//  virgoAppDelegate.h
//  virgo
//
//  Created by Ilya Alberton on 5/2/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class virgoViewController, loginViewController;

@interface virgoAppDelegate : NSObject <UIApplicationDelegate>{
    IBOutlet UIWindow               *window;
    IBOutlet virgoViewController    *viewController;
    IBOutlet loginViewController    *loginViewController;
    UIColor                         *textColor;
    NSMutableArray                  *history;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet virgoViewController  *viewController;
@property (nonatomic, retain) IBOutlet loginViewController  *loginViewController;
@property (nonatomic, retain) NSMutableArray                *history;
@property (nonatomic, retain) IBOutlet UIColor              *textColor;
@property (nonatomic, retain) UIViewController              *currentViewController;


// The method that will flip between the views
- (void) flipForward: (UIViewController*) to;
- (void) flipBack;
@end