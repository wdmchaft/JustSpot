//
//  JustSpotAppDelegate.h
//  JustSpot
//
//  Created by Anton Grachev on 05.05.11.
//  Copyright 2011 Anton Grachev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JustSpotAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@end

