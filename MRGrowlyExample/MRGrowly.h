//
//  MRGrowly.h
//
//  Created by Benjamin de Jager on 4/18/11.
//  Copyright 2011 M0rph3v5. All rights reserved.
//

typedef enum {
    MRGrowlyCornerTopLeft = 0,
    MRGrowlyCornerTopRight = 1,
    MRGrowlyCornerBottomLeft = 2,
    MRGrowlyCornerBottomRight = 3
} MRGrowlyCorner;

@interface MRGrowly : NSObject {
    UIView *targetView;
    int targetCorner;
    
    NSMutableArray *growlies;
    BOOL isDeviceOrientationLandscape;
}

@property (nonatomic, assign) UIView *targetView;
@property (nonatomic, assign) int targetCorner;
@property (nonatomic, assign) BOOL isDeviceOrientationLandscape;

+(id)instance;
-(void)showNotificationWithMessage:(NSString*)message andDuration:(CGFloat)seconds;

@end