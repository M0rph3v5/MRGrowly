//
//  MRGrowlyExampleViewController.m
//  MRGrowlyExample
//
//  Created by Benjamin de Jager on 4/19/11.
//  Copyright 2011 Munge. All rights reserved.
//

#import "MRGrowlyExampleViewController.h"

@implementation MRGrowlyExampleViewController

- (void)dealloc {
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Custom Button Actions

-(IBAction)notfLastTarget {
    [[MRGrowly instance] showNotificationWithMessage:@"Last target!" andDuration:2];
}

-(IBAction)notfTopLeft {
    [[MRGrowly instance] setTargetCorner:MRGrowlyCornerTopLeft];    
    [[MRGrowly instance] showNotificationWithMessage:@"Top left!" andDuration:2];
}

-(IBAction)notfTopRight {
    [[MRGrowly instance] setTargetCorner:MRGrowlyCornerTopRight];    
    [[MRGrowly instance] showNotificationWithMessage:@"Top right!" andDuration:2];    
}

-(IBAction)notfBottomLeft {
    [[MRGrowly instance] setTargetCorner:MRGrowlyCornerBottomLeft];    
    [[MRGrowly instance] showNotificationWithMessage:@"Bottom left!" andDuration:2];
}

-(IBAction)notfBottomRight {
    [[MRGrowly instance] setTargetCorner:MRGrowlyCornerBottomRight];    
    [[MRGrowly instance] showNotificationWithMessage:@"Bottom right!" andDuration:2];    
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [[self view] setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    // set on which view all the growly notifications will appear
    [[MRGrowly instance] setTargetView:self.view];
    
    // set in which corner the notifications will show, you can of course    
    // change this if you please but in general you always put it in the same corner
    [[MRGrowly instance] setTargetCorner:MRGrowlyCornerTopLeft];
    
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UIDeviceOrientationIsLandscape(interfaceOrientation)) {
        [[MRGrowly instance] setIsDeviceOrientationLandscape:YES];
    } else {
        [[MRGrowly instance] setIsDeviceOrientationLandscape:NO];
    }
    return YES;
}

@end
