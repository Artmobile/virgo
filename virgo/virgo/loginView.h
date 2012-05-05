//
//  loginView.h
//  virgo
//
//  Created by Ilya Alberton on 5/2/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginView : UIView{
    IBOutlet UITextField* txtPassword;
    IBOutlet UITextField* txtUsername;
}

- (IBAction)doLogin:(id)sender;
- (IBAction)doRegister:(id)sender;
- (IBAction)forgotPassword:(id)sender;

@property (nonatomic, retain) UITextField* txtUsername;
@property (nonatomic, retain) UITextField* txtPassword;

@end
