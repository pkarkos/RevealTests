//
//  RevealViewController.m
//  ProjectFlow
//
//  Created by Andrew Copp on 6/4/13.
//  Copyright (c) 2013 Andrew Copp. All rights reserved.
//

#import "RevealViewController.h"

@interface RevealViewController ()

@property (strong, nonatomic) UIView *frontView;
@property (strong, nonatomic) UIView *rearView;

@end

@implementation RevealViewController

@synthesize frontViewController = _frontViewController;
@synthesize rearViewController = _rearViewController;

- (id)initWithFrontViewController:(UIViewController *)frontViewController
            andRearViewController:(UIViewController *)rearViewController
{
    self = [super init];
    if (self) {
        _frontViewController = frontViewController;
        _rearViewController = rearViewController;
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
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(revealGesture:)];
    [[self frontView] addGestureRecognizer:panGesture];
    
    [self addFrontViewControllerToHeirarchy:[self frontViewController]];
    [self addRearViewControllerToHeirarchy:[self rearViewController]];
}

- (void)revealGesture:(UIPanGestureRecognizer *)recognizer
{
    
    switch ([recognizer state]) {
        case UIGestureRecognizerStateChanged:
            [[self frontView] setFrame:CGRectMake([recognizer translationInView:[self view]].x,
                                                  0,
                                                  [[self view] frame].size.width,
                                                  [[self view] frame].size.height)];
            break;
            
        case UIGestureRecognizerStateEnded:
            if ([[self frontView] frame].origin.x <= 200) {
                [[self frontView] setFrame:CGRectMake(0,
                                                      0,
                                                      [[self view] frame].size.width,
                                                      [[self view] frame].size.height)];
            } else {
                [[self frontView] setFrame:CGRectMake(275,
                                                      0,
                                                      [[self view] frame].size.width,
                                                      [[self view] frame].size.height)];
            }
            break;
    }
    
    NSLog(@"%f",[recognizer translationInView:[self view]].x);
    
}


@end
