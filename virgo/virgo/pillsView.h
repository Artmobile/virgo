//
//  pillsView.h
//  virgo
//
//  Created by Ilya Alberton on 5/3/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomButton;

@interface pillsView : UIView 

@property (nonatomic, retain) IBOutlet UIButton* blueButton;
@property (nonatomic, retain) IBOutlet UIButton* redButton;

- (IBAction)blue:(id)sender;
- (IBAction)red:(id)sender;


@end
