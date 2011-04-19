//
//  MRGrowlyExampleAppDelegate_iPhone.m
//  MRGrowlyExample
//
//  Created by Benjamin de Jager on 4/19/11.
//  Copyright 2011 Munge. All rights reserved.
//

#import "MRGrowlyExampleAppDelegate_iPhone.h"

@implementation MRGrowlyExampleAppDelegate_iPhone

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    mrgrowlyExampleViewController = [[MRGrowlyExampleViewController alloc] init];
    [self.window addSubview:mrgrowlyExampleViewController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc {
    [mrgrowlyExampleViewController release];
	[super dealloc];
}

@end
