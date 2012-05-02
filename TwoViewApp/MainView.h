//
//  MainView.h
//  TwoViewApp
//

#import <UIKit/UIKit.h>


@interface MainView : UIView {
	IBOutlet UILabel *theLabel;
}

- (IBAction)sayHi:(id)sender;
- (IBAction)tellDelegateToFlipViews:(id)sender;

@property (nonatomic, retain) UILabel *theLabel;

@end
