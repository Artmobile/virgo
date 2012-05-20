//
//  loginView.m
//  virgo
//
//  Created by Ilya Alberton on 5/2/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import "loginView.h"
#import "createUserViewController.h"
#import "forgotPasswordViewController.h"
#import "virgoAppDelegate.h"
#import "SecureJsonChannel.h"
#import "UserActivityManager.h"
#import "ErrorCodes.h"

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
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    NSError* error = nil;
    
    
    // Perform the login
    NSString* username = txtUsername.text;
    NSString* password = txtPassword.text;
    

    // Get admin_id from the Xodiac service
    NSString* admin_id = [UserActivityManager doLogin:mainDelegate.currentServer forUsername: username forPassword:password error:&error];
    
    UIAlertView *alert = nil;
    
    if(error){
        WITHIN_DOMAIN(error, DOMAIN_XODIAC)
                case X_CODE_LOGIN_FAILED:
                    NSLog(@"Could not login user %@", username);
                    // Provided invalid credentials
                    alert = [[UIAlertView alloc] initWithTitle:@"Could not login"
                                                       message:@"Wrong username and password were provided"
                                                      delegate:nil 
                                             cancelButtonTitle:@"OK" 
                                             otherButtonTitles: nil];
        
                    break;
                case X_CODE_NO_CONNECTION:
                    // Show the popup message that the server cannot be contacted and bail out
                    alert = [[UIAlertView alloc] initWithTitle:@"Communition error occurred"
                                                       message:[error localizedDescription]
                                                      delegate:nil 
                                             cancelButtonTitle:@"OK" 
                                             otherButtonTitles: nil];
                    NSLog(@"Could not login because the application failed to login to the server");
                    break;
                default:
                    break;
        END_WITHIN_DOMAIN
    }
    
    if(alert){
        // Show whaterver alert we've got along the way
        [alert show];
        [alert release];
    }
    else{
        // Here we can go ahead add our bookmark
        // Show the popup message that the server cannot be contacted and bail out
        
        // TODO: Add bookmark manager here
        
        
        alert = [[UIAlertView alloc] initWithTitle:@"Successful login"
                                           message:@"Your bookmark has been successfully added. Please open Safari and try it"
                                          delegate:nil 
                                 cancelButtonTitle:@"OK" 
                                 otherButtonTitles: nil];

        [alert show];
        [alert release];

        NSLog(@"Successfully logged into %@", admin_id);
    }
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
