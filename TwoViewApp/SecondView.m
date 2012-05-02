//
//  SecondView.m
//  TwoViewApp
//
//

#import "SecondView.h"
#import "TwoViewAppAppDelegate.h"


@implementation SecondView


- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	// Drawing code
}

- (IBAction)setRedColor:(id)sender {
	TwoViewAppAppDelegate *mainDelegate = (TwoViewAppAppDelegate *)[[UIApplication sharedApplication] delegate];
	mainDelegate.textColor = [UIColor redColor];
	
	//[[[mainDelegate viewController] theLabel] setTextColor:[UIColor redColor]];
	
	[mainDelegate flipToFront];
	
}

- (IBAction)setBlueColor:(id)sender {
	TwoViewAppAppDelegate *mainDelegate = (TwoViewAppAppDelegate *)[[UIApplication sharedApplication] delegate];
	mainDelegate.textColor = [UIColor blueColor];
	//[[[mainDelegate viewController] theLabel] setTextColor:[UIColor blueColor]];
	[mainDelegate flipToFront];
	
}

- (IBAction)setGreenColor:(id)sender {
	TwoViewAppAppDelegate *mainDelegate = (TwoViewAppAppDelegate *)[[UIApplication sharedApplication] delegate];
	mainDelegate.textColor = [UIColor greenColor];
	//[[[mainDelegate viewController] theLabel] setTextColor:[UIColor greenColor]];
	[mainDelegate flipToFront];
	
}


- (void)dealloc {
	[super dealloc];
}


@end
