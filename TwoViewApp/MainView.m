//
//  MainView.m
//  TwoViewApp
//

#import "MainView.h"
#import "TwoViewAppAppDelegate.h"

@implementation MainView

@synthesize theLabel;


- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
		TwoViewAppAppDelegate *mainDelegate = (TwoViewAppAppDelegate *)[[UIApplication sharedApplication] delegate];
		theLabel.textColor = mainDelegate.textColor;
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	// Drawing code
}

- (IBAction)sayHi:(id)sender {
	[theLabel setText:@"Hello, World"];
	
	TwoViewAppAppDelegate *mainDelegate = (TwoViewAppAppDelegate *)[[UIApplication sharedApplication] delegate];
	theLabel.textColor = mainDelegate.textColor;
	
}

- (IBAction)tellDelegateToFlipViews:(id)sender {
	TwoViewAppAppDelegate *mainDelegate = (TwoViewAppAppDelegate *)[[UIApplication sharedApplication] delegate];
	[mainDelegate flipToBack];
}


- (void)dealloc {
	[theLabel release];
	[super dealloc];
}


@end
