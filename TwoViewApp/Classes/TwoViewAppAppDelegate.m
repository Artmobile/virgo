//
//  TwoViewAppAppDelegate.m
//  TwoViewApp
//
//  Created by Billy Myers on 8/1/08.
//  Copyright Home 2008. All rights reserved.
//

#import "TwoViewAppAppDelegate.h"
#import "TwoViewAppViewController.h"
#import "SecondViewController.h"

@implementation TwoViewAppAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize secondViewController;
@synthesize textColor;


- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	
	// Override point for customization after app launch
	textColor = [UIColor blackColor];
	
    [window addSubview:viewController.view];
	[window makeKeyAndVisible];
}

- (void)flipToBack {
	SecondViewController *aSecondView = [[SecondViewController alloc] initWithNibName:@"SecondView" bundle:nil];
	[self setSecondViewController:aSecondView];
	[aSecondView release];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:2.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:window cache:YES];
	[viewController.view removeFromSuperview];
	[self.window addSubview:[secondViewController view]];
	[UIView commitAnimations];
}

- (void)flipToFront {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:2.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:window cache:NO];
	[secondViewController.view removeFromSuperview];
	[self.window addSubview:[viewController view]];
	[UIView commitAnimations];
	[secondViewController release];
	secondViewController = nil;
}


- (void)dealloc {
    [viewController release];
	[secondViewController release];
	[textColor release];
	[window release];
	[super dealloc];
}


@end
