//
//  configurationView.m
//  virgo
//
//  Created by Ilya Alberton on 5/22/12.
//  Copyright 2012 artmobile@gmail.com. All rights reserved.
//

#import "configurationView.h"
#import "virgoAppDelegate.h"

@implementation configurationView

@synthesize fileToCheck = _fileToCheck;
@synthesize defaultPath = _defaultPath;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)check:(id)sender{
    NSString* _databasePath;
    
#if TARGET_IPHONE_SIMULATOR
    NSString* version = [[UIDevice currentDevice] systemVersion];
    _defaultPath.text=[NSString stringWithFormat: @"/Users/%@/Library/Application Support/iPhone Simulator/%@/Library/Safari/Bookmarks.db", NSUserName(),version];
#else
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES) lastObject];
    _defaultPath.text  = [libraryPath stringByAppendingPathComponent:@"Safari/Bookmarks.db"];
#endif
    
    NSString* message = @"";
    
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath: [_fileToCheck text]];
    
    if(!exists)
        message = [NSString stringWithFormat:@"File %@ does not exist", [_fileToCheck text]];
    else
        message = [NSString stringWithFormat:@"File %@ EXISTS!!!", [_fileToCheck text]];
    
    // Show the popup message that the server cannot be contacted and bail out
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Checking file"
                                       message: message
                                      delegate:nil 
                             cancelButtonTitle:@"OK" 
                             otherButtonTitles: nil];
    
    [alert show];
    [alert release];
}

- (IBAction)back:(id)sender{
    virgoAppDelegate* mainDelegate = (virgoAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [mainDelegate flipBack];
}

@end
