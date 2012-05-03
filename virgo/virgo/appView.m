//
//  appView.m
//  virgo
//
//  Created by Ilya Alberton on 5/2/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import "appView.h"
#import "virgoAppDelegate.h"

@implementation appView

@synthesize theLabel;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
        theLabel.textColor = mainDelegate.textColor;
    }
    return self;
}

- (IBAction)sayHi:(id)sender{
    [theLabel setText:@"Hello, World"];
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    theLabel.textColor = mainDelegate.textColor;
}

- (IBAction)tellDelegateToFlipViews:(id)sender{
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    loginViewController* login = [[loginViewController alloc] initWithNibName:@"LoginView" bundle:nil];
    
    [mainDelegate flipForward:(UIViewController*)login];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
