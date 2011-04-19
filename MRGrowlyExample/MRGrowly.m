//
//  MRGrowly.h
//
//  Created by Benjamin de Jager on 4/18/11.
//  Copyright 2011 M0rph3v5. All rights reserved.
//

#import "MRGrowly.h"
#import <QuartzCore/QuartzCore.h>

static MRGrowly *instance = nil;

@implementation MRGrowly

@synthesize targetView, 
            targetCorner,
            isDeviceOrientationLandscape;

+(id)instance {
    if(instance == nil) {
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

+(id)allocWithZone:(NSZone*)zone {
    return [[self instance] retain];
}

-(id)init {
    if ((self = [super init])) {
        growlies = [[NSMutableArray alloc] init];
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if (UIDeviceOrientationIsLandscape(orientation)) {
            isDeviceOrientationLandscape = YES;
        } else if (UIDeviceOrientationIsPortrait(orientation)) {
            isDeviceOrientationLandscape = NO;
        }
    }
    return self;
}

-(void)showNotificationWithMessage:(NSString*)message andDuration:(CGFloat)seconds {
    CGFloat lastHeight;
    
    if (targetCorner == MRGrowlyCornerBottomLeft || targetCorner == MRGrowlyCornerBottomRight) {
        if (isDeviceOrientationLandscape) {
            lastHeight = targetView.frame.size.width;
        } else {
            lastHeight = targetView.frame.size.height;
        }

    } else if (targetCorner == MRGrowlyCornerTopLeft || targetCorner == MRGrowlyCornerTopRight) {
        lastHeight = -25;        
    }
   
    CGFloat marginLeft;
    CGFloat marginTop;
    
    if (!targetView) {
        [NSException raise:@"MRGrowlyTargetViewIssueNil" 
                    format:@"A valid target view has not been set."];
    }
    
    switch (targetCorner) {
        case MRGrowlyCornerTopLeft:
            marginLeft  = 20;
            marginTop   = 20; 
            break;
        case MRGrowlyCornerTopRight:
            if (isDeviceOrientationLandscape) {
                marginLeft  = targetView.frame.size.height  -   220;                
            } else {
                marginLeft  = targetView.frame.size.width  -   220;
            }

            marginTop   = 20;
            break;
        case MRGrowlyCornerBottomLeft:
            marginLeft  = 20;
            
            if (isDeviceOrientationLandscape) {
                marginTop   = targetView.frame.size.width   -   60;                
            } else {
                marginTop   = targetView.frame.size.height   -   60;
            }
            break;
        case MRGrowlyCornerBottomRight:
            if (isDeviceOrientationLandscape) {
                marginLeft  = targetView.frame.size.height  -   220;
                marginTop   = targetView.frame.size.width   -   60;                
            } else {
                marginLeft  = targetView.frame.size.width  -   220;
                marginTop   = targetView.frame.size.height   -   60;
            }
            break;
        default:
            [NSException raise:@"MRGrowlyCornerIssueNil" 
                        format:@"A valid target corner has not been set."];
            break;
    }
    
    if ([growlies count] > 0) {
        UIView *lastView = [growlies lastObject];        
        lastHeight = lastView.frame.origin.y;
    }
    
    UIView *growlyView = [[UIView alloc] init];
    
    if (targetCorner == MRGrowlyCornerBottomLeft || targetCorner == MRGrowlyCornerBottomRight) {
        [growlyView setFrame:CGRectMake(marginLeft, lastHeight - 45, 200, 40)];
    } else if (targetCorner == MRGrowlyCornerTopLeft || targetCorner == MRGrowlyCornerTopRight) {
        [growlyView setFrame:CGRectMake(marginLeft, marginTop + (25 + lastHeight), 200, 40)];
    }
    
    [growlyView setAlpha:0.0f];
    [growlyView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];

    [growlyView.layer setCornerRadius:5];    
    
    [growlyView.layer setShadowOffset:CGSizeMake(0, 0)];
    [growlyView.layer setShadowRadius:5];
    [growlyView.layer setShadowOpacity:0.5];
    [growlyView.layer setMasksToBounds:NO];
    [growlyView.layer setShadowPath:[UIBezierPath bezierPathWithRect:growlyView.bounds].CGPath];
    
    [growlies addObject:growlyView];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 180, 20)];
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    [messageLabel setText:message];
    [messageLabel setTextColor:[UIColor whiteColor]];
    [growlyView addSubview:messageLabel];
    [messageLabel release];
    
    [targetView	 addSubview:growlyView];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [growlyView setAlpha:1.0f];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:seconds options:UIViewAnimationOptionAllowUserInteraction animations:^{
            [growlyView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            if (finished) {
                [growlies removeObject:growlyView];                
                [growlyView removeFromSuperview];
                [growlyView release];
            }
        }];
    }];
}

@end