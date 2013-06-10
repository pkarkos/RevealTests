//
//  RevealViewController.h
//  ProjectFlow
//
//  Created by Andrew Copp on 6/4/13.
//  Copyright (c) 2013 Andrew Copp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiddenTableViewController.h"

typedef enum {
    FrontViewPositionLeft,
    FrontViewPositionRight,
} FrontViewController;

@interface RevealViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIViewController *frontViewController;
@property (strong, nonatomic) UIViewController *rearViewController;
@property (strong, nonatomic) HiddenTableViewController *hiddenTableViewController;
@property (assign, nonatomic) FrontViewController *currentFrontViewPosition;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

- (id)initWithFrontViewController:(UIViewController *)frontViewController
            andRearViewController:(UIViewController *)rearViewController;

- (void)addFrontViewControllerToHeirarchy:(UIViewController *)frontViewController;
- (void)addRearViewControllerToHeirarchy:(UIViewController *)rearViewController;

- (void)revealGesture:(UIPanGestureRecognizer *)recognizer;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

@end
