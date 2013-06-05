//
//  RevealViewController.h
//  ProjectFlow
//
//  Created by Andrew Copp on 6/4/13.
//  Copyright (c) 2013 Andrew Copp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RevealViewController : UIViewController

@property (strong, nonatomic) UIViewController *frontViewController;
@property (strong, nonatomic) UIViewController *rearViewController;

- (id)initWithFrontViewController:(UIViewController *)frontViewController
            andRearViewController:(UIViewController *)rearViewController;

- (void)addFrontViewControllerToHeirarchy:(UIViewController *)frontViewController;
- (void)addRearViewControllerToHeirarchy:(UIViewController *)rearViewController;

@end
