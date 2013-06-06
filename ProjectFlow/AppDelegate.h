//
//  AppDelegate.h
//  ProjectFlow
//
//  Created by Andrew Copp on 6/4/13.
//  Copyright (c) 2013 Andrew Copp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StickyViewController;
@class RevealViewController;
@class HiddenTableViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) StickyViewController *stickyViewController;
@property (strong, nonatomic) RevealViewController *revealViewController;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) HiddenTableViewController *hiddenVC;

@end
