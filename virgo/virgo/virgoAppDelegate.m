//
//  virgoAppDelegate.m
//  virgo
//
//  Created by Ilya Alberton on 5/2/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import "virgoAppDelegate.h"

#import "virgoViewController.h"
#import "loginViewController.h"
#import "NSStack.h"
#import "SecureJsonChannel.h"

@implementation virgoAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize loginViewController = _loginController;
@synthesize forgotPasswordViewController = forgotPasswordController;
@synthesize createUserViewController = _createUserController;
@synthesize pillsViewController = _pillsController;
@synthesize textColor = _textColor;
@synthesize history = _history;
@synthesize currentViewController = _current;
@synthesize currentKey = _currentKey;


NSString* currentServer = @"http://localhost:9001";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
     
    _textColor = [UIColor blackColor];

    // Make sure that _viewController is always at the bottom of the history stack so we
    // can always get back to it
    _history = [[NSMutableArray alloc]init];
    [_history push:_viewController];
    _current = _viewController;
    
    NSError* err = Nil;
    // Try to negotiate the current key from the dispatcher server
    _currentKey = [SecureJsonChannel negotiateKey:currentServer error:&err];
    if(err){
        // Show the popup message that the server cannot be contacted and bail out
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Communition error occurred" 
														message:[err localizedDescription]
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles: nil];        
        [alert show];
        [alert release];
    }
    
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) flipForward: (UIViewController*) to {
    if(to == _viewController)
        [NSException  raise:@"Can't flip to origin" format:@"The destination object was the same as _viewController. Can only flipBack to this controller"];
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
    
    // Since the from object was passed to us, we'll remember and cache it
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:window cache:YES];
    
    // We'll cache the object which we come from. We do not cache the object that we are going to until next flip   
    if(_current != _viewController)
        [_history push: _current];

    [_current.view removeFromSuperview];
    _current = to;
    
	[self.window addSubview:[to view]];
	[UIView commitAnimations];    
    
}

- (void) flipBack {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:window cache:NO];
    
    UIViewController* cache;
    
    if([_history count] == 1)
        cache = [_history objectAtIndex:0];
    else
        cache = (UIViewController*)[_history pop];
    
    
	[_current.view removeFromSuperview];
    
	[self.window addSubview:[cache view]];
	[UIView commitAnimations];
    
    _current = cache;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [_loginController release];
    [textColor release];
    [super dealloc];
}

@end
