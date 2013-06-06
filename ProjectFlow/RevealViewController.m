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
@synthesize hiddenTableViewController = _hiddenTableViewController;
@synthesize hiddenViewIsBeingShown =_hiddenViewIsBeingShown;

- (id)initWithFrontViewController:(UIViewController *)frontViewController
            andRearViewController:(UIViewController *)rearViewController
{
    self = [super init];
    if (self) {
        _frontViewController = frontViewController;
        _rearViewController = rearViewController;
        [self addRearViewControllerToHeirarchy:_rearViewController];
        [self addFrontViewControllerToHeirarchy:_frontViewController];
        self.hiddenViewIsBeingShown = NO;
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
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(revealGesture:)];
    [[self frontView] addGestureRecognizer:panGesture];
    
    [self addFrontViewControllerToHeirarchy:[self frontViewController]];
    [self addRearViewControllerToHeirarchy:[self rearViewController]];
}

//- (void)revealGesture:(UIPanGestureRecognizer *)recognizer
//{
//    
//    NSLog(@"Offset: %f", [self frontView].frame.origin.x);
//    //NSLog(@"Translation In View: %f", [recognizer translationInView:[self view]].x);
//    switch ([recognizer state]) {
//        case UIGestureRecognizerStateBegan:
//        case UIGestureRecognizerStateChanged:
//           // NSLog(@"THIS IS THE TRANSLATION: %f", [recognizer translationInView:[self view]].x);
//            
//                 
//            
//            if ([recognizer translationInView:[self view]].x < 0) {
//                [[self frontView] setFrame:CGRectMake(0, 0, [[self view] frame].size.width, [[self view]frame].size.height)];
//                
//            }
//            else if (self.hiddenViewIsBeingShown){
//                NSLog(@"THIS IS THE X OFFSET: %f", [[self frontView] frame].origin.x);
//                NSLog(@"THIS IS THE TRANSLATION: %f", ([recognizer translationInView:[self view]].x + 275));
//                [[self frontView] setFrame:CGRectMake(([recognizer translationInView:[self view]].x + [[self frontView] frame].origin.x),
//                                                      0,
//                                                      [[self view] frame].size.width,
//                                                      [[self view] frame].size.height)];
//                //self.hiddenViewIsBeingShown = NO;
//                
//            }
//            else if ([[self frontView] frame].origin.x > 0){
//   
//            [[self frontView] setFrame:CGRectMake([recognizer translationInView:[self view]].x,
//                                                  0,
//                                                  [[self view] frame].size.width,
//                                                  [[self view] frame].size.height)];
//                self.hiddenViewIsBeingShown = NO;
//            }
//
//            if ([recognizer velocityInView:[self view]].x > 700) {
//                [UIView animateWithDuration:.10f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
//                    [[self frontView] setFrame:CGRectMake(275, 0, [[self view] frame].size.width,[[self view] frame].size.height )];
//                }completion:^(BOOL finished){
//                    
//                }];
//                self.hiddenViewIsBeingShown = YES;
//            }
//            break;
//            
//        case UIGestureRecognizerStateEnded:
//            if ([[self frontView] frame].origin.x <= 200) {
//                [UIView animateWithDuration:.10f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
//                    [[self frontView] setFrame:CGRectMake(0, 0, [[self view] frame].size.width,[[self view] frame].size.height )];
//                }completion:^(BOOL finished){
//                      NSLog(@"FINISHED STATE ENDED");
//                }];
//                self.hiddenViewIsBeingShown = YES;
//                
//            } else if ([[self frontView] frame].origin.x > 200) {
//                [UIView animateWithDuration:.050f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
//                    [[self frontView] setFrame:CGRectMake(275, 0, [[self view] frame].size.width,[[self view] frame].size.height )];
//                }completion:^(BOOL finished){
//                    NSLog(@"FINISHED STATE ENDED");
//                }];
//                self.hiddenViewIsBeingShown = YES;
//            }
//            break;
//    }
//    
//    //NSLog(@"%f",[recognizer translationInView:[self view]].x);
//    
//}
- (void)revealGesture:(UIPanGestureRecognizer *)recognizer
{
    
        if ([self currentFrontViewPosition] == FrontViewPositionLeft) {
            switch ([recognizer state]) {
                case UIGestureRecognizerStateChanged:
                    if ([recognizer translationInView:[self view]].x < 0) {
                        [[self frontView] setFrame:CGRectMake(0, 0, [[self view] frame].size.width, [[self view]frame].size.height)];
                
                    }
                    else if ([recognizer translationInView:[self view]].x  > 0){
                        [[self frontView] setFrame:CGRectMake([recognizer translationInView:[self view]].x,
                                                              0,
                                                              [[self view] frame].size.width,
                                                              [[self view] frame].size.height)];
                    }
                break;
                case UIGestureRecognizerStateEnded:
                    if ([[self frontView] frame].origin.x <= 200) {
                        [UIView animateWithDuration:.10f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
                            [[self frontView] setFrame:CGRectMake(0, 0, [[self view] frame].size.width,[[self view] frame].size.height )];
                        }completion:^(BOOL finished){
                            NSLog(@"FINISHED STATE ENDED");
                        }];
                    }
                    else{
                        [UIView animateWithDuration:.050f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
                            [[self frontView] setFrame:CGRectMake(275, 0, [[self view] frame].size.width,[[self view] frame].size.height )];
                        }completion:^(BOOL finished){
                            NSLog(@"FINISHED STATE ENDED");
                        }];
                    }
                break;
        
            }
            
        }
        else{
            switch ([recognizer state]) {
                case UIGestureRecognizerStateBegan:
                    [[self frontView] setFrame:CGRectMake(([recognizer translationInView:[self view]].x + [[self frontView] frame].origin.x),
                                                              0,
                                                              [[self view] frame].size.width,
                                                              [[self view] frame].size.height)];
                        
                    if ([recognizer velocityInView:[self view]].x > 1000 ) {
                        [UIView animateWithDuration:.10f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
                            [[self frontView] setFrame:CGRectMake(0, 0, [[self view] frame].size.width,[[self view] frame].size.height )];
                        }completion:^(BOOL finished){
                            NSLog(@"FINISHED STATE ENDED");
                        }];
                    }
                break;
            
                case UIGestureRecognizerStateEnded:
                    if ([[self view]frame].origin.x <= 100) {
                        [UIView animateWithDuration:.05f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
                            [[self frontView] setFrame:CGRectMake(0, 0, [[self view] frame].size.width,[[self view] frame].size.height )];
                        }completion:^(BOOL finished){
                            NSLog(@"FINISHED STATE ENDED");
                        }];
                    }
                    else{
                        [UIView animateWithDuration:.10f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
                            [[self frontView] setFrame:CGRectMake(275, 0, [[self view] frame].size.width,[[self view] frame].size.height )];
                        }completion:^(BOOL finished){
                            NSLog(@"FINISHED STATE ENDED");
                        }];
                    }
                break;
            }
        }
}



@end
