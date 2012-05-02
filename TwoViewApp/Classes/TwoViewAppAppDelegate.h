//
//  TwoViewAppAppDelegate.h
//  TwoViewApp
//
//  Created by Billy Myers on 8/1/08.
//  Copyright Home 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwoViewAppViewController, SecondViewController;

@interface TwoViewAppAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet TwoViewAppViewController *viewController;
	IBOutlet SecondViewController *secondViewController;
	UIColor *textColor;
}

- (void)flipToBack;
- (void)flipToFront;

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) TwoViewAppViewController *viewController;
@property (nonatomic, retain) SecondViewController *secondViewController;
@property (nonatomic, retain) UIColor *textColor;

@end

