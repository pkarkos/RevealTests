//
//  StickyViewController.m
//  ProjectFlow
//
//  Created by Andrew Copp on 6/4/13.
//  Copyright (c) 2013 Andrew Copp. All rights reserved.
//

#import "StickyViewController.h"

@interface StickyViewController ()

@end

@implementation StickyViewController

@synthesize stickyView = _stickyView;
@synthesize hiddenVC = _hiddenVC;

- (id)init
{
    self = [super init];
    if (self) {
        UIScrollView *notUsed = [[UIScrollView alloc] init];
        [notUsed setBounces:NO];
        _stickyView = [[StickyView alloc] initWithBody:notUsed];
        [self setView:[self stickyView]];
        [[[self stickyView] body] setDelegate:self];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setDirectionalLockEnabled:YES];
    [scrollView setBounces:NO];
    [self.view sendSubviewToBack:self.view];
    if (scrollView == [[self stickyView] body]) {
        NSLog(@"%f",[scrollView contentOffset].y);
        if ([scrollView contentOffset].y > -45) {
            [[[self stickyView] header] setFrame:CGRectMake(0,
                                                            [scrollView contentOffset].y - 120,
                                                            [[[self stickyView] header] frame].size.width,
                                                            [[[self stickyView] header] frame].size.height)];
        } else if ([scrollView contentOffset].y < -165) {
            [[[self stickyView] header] setFrame:CGRectMake(0,
                                                            [scrollView contentOffset].y,
                                                            [[[self stickyView] header] frame].size.width,
                                                            [[[self stickyView] header] frame].size.height)];
        }
        else if (scrollView.contentOffset.x != 0){
            self.hiddenVC = [[HiddenTableViewController alloc] init];
            [self.navigationController pushViewController:self.parentViewController animated:YES];
        }
    }
    
    

}

@end
