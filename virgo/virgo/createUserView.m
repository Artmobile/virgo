//
//  createUserView.m
//  virgo
//
//  Created by Ilya Alberton on 5/3/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import "createUserView.h"
#import "virgoAppDelegate.h"

@implementation createUserView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)cancel:(id)sender{
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [mainDelegate flipBack];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
