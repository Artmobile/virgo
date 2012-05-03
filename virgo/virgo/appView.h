//
//  appView.h
//  virgo
//
//  Created by Ilya Alberton on 5/2/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface appView : UIView{
    IBOutlet UILabel *theLabel;
    
}

- (IBAction)sayHi:(id)sender;
- (IBAction)tellDelegateToFlipViews:(id)sender;

@property (nonatomic, retain) UILabel* theLabel;

@end
