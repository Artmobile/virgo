//
//  loginView.m
//  virgo
//
//  Created by Ilya Alberton on 5/2/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import "loginView.h"
#import "virgoAppDelegate.h"

@implementation loginView

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
    
    [mainDelegate flipBack];
}

- (IBAction)doRegister:(id)sender {
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    createUserViewController* user = [[createUserViewController alloc] initWithNibName:@"createUserViewController" bundle:nil];
    
    [mainDelegate flipForward:(UIViewController*)user];
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
