//
//  loginView.m
//  virgo
//
//  Created by Ilya Alberton on 5/2/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import "loginView.h"
#import "virgoAppDelegate.h"
#import "SecureJsonChannel.h"

@implementation loginView

@synthesize txtPassword;
@synthesize txtUsername;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)doLogin:(id)sender {

    // Perform the login
    NSString* username = txtUsername.text;
    NSString* password = txtPassword.text;
    
    
    
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    pillsViewController* user = [[pillsViewController alloc] initWithNibName:@"pillsViewController" bundle:nil];
    
    [mainDelegate flipForward:(UIViewController*)user];
    
}

- (IBAction)doRegister:(id)sender {
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    createUserViewController* user = [[createUserViewController alloc] initWithNibName:@"createUserViewController" bundle:nil];
    
    [mainDelegate flipForward:(UIViewController*)user];
}

- (IBAction)forgotPassword:(id)sender {
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    forgotPasswordViewController* forgot = [[forgotPasswordViewController alloc] initWithNibName:@"forgotPasswordViewController" bundle:nil];
    
    [mainDelegate flipForward:(UIViewController*)forgot];
}

/*

- (IBAction)onGoBack:(id)sender{
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [mainDelegate flipBack];
}
*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
