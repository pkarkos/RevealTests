//
//  RevealViewController.m
//  ProjectFlow
//
//  Created by Andrew Copp on 6/4/13.
//  Copyright (c) 2013 Andrew Copp. All rights reserved.
//

#import "RevealViewController.h"
#import "StickyViewController.h"


@interface RevealViewController ()

@property (strong, nonatomic) UIView *frontView;
@property (strong, nonatomic) UIView *rearView;

@end

@implementation RevealViewController

@synthesize frontViewController = _frontViewController;
@synthesize rearViewController = _rearViewController;
@synthesize hiddenTableViewController = _hiddenTableViewController;
@synthesize panGesture = _panGesture;

- (id)initWithFrontViewController:(UIViewController *)frontViewController
            andRearViewController:(UIViewController *)rearViewController
{
    self = [super init];
    if (self) {
        _frontViewController = frontViewController;
        _rearViewController = rearViewController;
        [self addRearViewControllerToHeirarchy:_rearViewController];
        [self addFrontViewControllerToHeirarchy:_frontViewController];
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(revealGesture:)];
        //self.hiddenTableViewController = [[HiddenTableViewController alloc] init];
        [self viewDidLoad];
    }
    return self;
}

- (void)addFrontViewControllerToHeirarchy:(UIViewController *)frontViewController
{
    [self addChildViewController:frontViewController];
    [[self frontView] addSubview:[frontViewController view]];
    [frontViewController didMoveToParentViewController:self];
}

- (void)addRearViewControllerToHeirarchy:(UIViewController *)rearViewController
{
    [self addChildViewController:rearViewController];
    [[self rearView] addSubview:[rearViewController view]];
    [rearViewController didMoveToParentViewController:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setFrontView:[[UIView alloc] initWithFrame:[[self view] bounds]]];
    [self setRearView:[[UIView alloc] initWithFrame:[[self view] bounds]]];
    
    [[self view] addSubview:[self rearView]];
    [[self view] addSubview:[self frontView]];
    
    
    [self setCurrentFrontViewPosition:FrontViewPositionLeft];
    
    [[self frontView] addGestureRecognizer:self.panGesture];
    [self.panGesture setDelegate:self];
    
    [self addFrontViewControllerToHeirarchy:[self frontViewController]];
    [self addRearViewControllerToHeirarchy:[self rearViewController]];
}

- (void)revealGesture:(UIPanGestureRecognizer *)recognizer
{
    StickyView *visibleController = (StickyView *)[self.frontViewController view];
        if ([self currentFrontViewPosition] == FrontViewPositionLeft) {
            switch ([recognizer state]) {
                case UIGestureRecognizerStateBegan:
                    if (ABS([recognizer translationInView:[self frontView]].y) >= ABS([recognizer translationInView:[self frontView]].x)) {
                        [recognizer setEnabled:NO];
                    }
                    else{
                        [visibleController.body setScrollEnabled:NO];
                    }
                case UIGestureRecognizerStateFailed:
                    [recognizer setEnabled:YES];

                break;
                case UIGestureRecognizerStateChanged:
                    if ([recognizer translationInView:[self view]].x < 0) {
                        [[self frontView] setFrame:CGRectMake(0, 0, [[self view] frame].size.width, [[self view]frame].size.height)];
                
                    }
                    else{
                        [[self frontView] setFrame:CGRectMake([recognizer translationInView:[self view]].x,
                                                              0,
                                                              [[self view] frame].size.width,
                                                              [[self view] frame].size.height)];
                    }
                break;
                case UIGestureRecognizerStateEnded:
                    if ([[self frontView] frame].origin.x >= 150 || [recognizer velocityInView:[self view]].x >= 1000) {
                        [UIView animateWithDuration:.20f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
                            [[self frontView] setFrame:CGRectMake(275, 0, [[self view] frame].size.width,[[self view] frame].size.height )];
                        }completion:^(BOOL finished){
                            [visibleController.body setScrollEnabled:NO];
                            [recognizer setEnabled:YES];
                            self.currentFrontViewPosition = FrontViewPositionRight;
                        }];
                    }
                    else{
                        [UIView animateWithDuration:.20f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
                            [[self frontView] setFrame:CGRectMake(0, 0, [[self view] frame].size.width,[[self view] frame].size.height )];
                        }completion:^(BOOL finished){
                        }];
                    }
            }
            
        }
        else{
            switch ([recognizer state]) {
                case UIGestureRecognizerStateBegan:
                    if (ABS([recognizer translationInView:[self frontView]].y) >= ABS([recognizer translationInView:[self frontView]].x) ) {
                        [recognizer setEnabled:NO];
                    }
                    else{
                        [visibleController.body setScrollEnabled:NO];
                    }
                case UIGestureRecognizerStateFailed:
                    [recognizer setEnabled:YES];
                break;
                
                case UIGestureRecognizerStateChanged:
                    if ([recognizer translationInView:[self view]].x > 0) {
                        [[self frontView] setFrame:CGRectMake(275, 0, self.frontView.frame.size.width, self.frontView.frame.size.height)];
                    }
                    else{
                    [[self frontView] setFrame:CGRectMake(([recognizer translationInView:[self view]].x + 275),
                                                              0,
                                                              [[self view] frame].size.width,
                                                              [[self view] frame].size.height)];
                    }
                    
                break;

                case UIGestureRecognizerStateEnded:
                    if ([[self frontView]frame].origin.x <= 100  || [recognizer velocityInView:[self view]].x < -800) {
                        [UIView animateWithDuration:.20f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
                            [[self frontView] setFrame:CGRectMake(0, 0, [[self view] frame].size.width,[[self view] frame].size.height )];
                        }completion:^(BOOL finished){
                            [visibleController.body setScrollEnabled:YES];
                            [recognizer setEnabled:YES];
                            self.currentFrontViewPosition = FrontViewPositionLeft;
                        }];
                    }
                    else{
                        [UIView animateWithDuration:.20f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
                            [[self frontView] setFrame:CGRectMake(275, 0, [[self view] frame].size.width,[[self view] frame].size.height )];
                        }completion:^(BOOL finished){
                        }];
                    }
                
            }
        }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
