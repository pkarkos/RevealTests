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
}

- (void)addRearViewControllerToHeirarchy:(UIViewController *)rearViewController
{
    [self addChildViewController:rearViewController];
    [[self rearView] addSubview:[rearViewController view]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setFrontView:[[UIView alloc] initWithFrame:[[self view] bounds]]];
    [self setRearView:[[UIView alloc] initWithFrame:[[self view] bounds]]];
    
    [[self view] addSubview:[self rearView]];
    [[self view] addSubview:[self frontView]];
    
    [self addFrontViewControllerToHeirarchy:[self frontViewController]];
    [self addRearViewControllerToHeirarchy:[self rearViewController]];
}

@end
