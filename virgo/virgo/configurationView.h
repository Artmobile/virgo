//
//  configurationView.h
//  virgo
//
//  Created by Ilya Alberton on 5/22/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface configurationView : UIView{
    IBOutlet UITextField *fileToCheck;
    IBOutlet UITextView  *defaultPath;
    
    
}

- (IBAction)check:(id)sender;
- (IBAction)back:(id)sender;

@property (nonatomic, retain) UITextField* fileToCheck;
@property (nonatomic, retain) UITextView*  defaultPath;

@end
