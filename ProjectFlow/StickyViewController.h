//
//  StickyViewController.h
//  ProjectFlow
//
//  Created by Andrew Copp on 6/4/13.
//  Copyright (c) 2013 Andrew Copp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StickyView.h"

@interface StickyViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) StickyView *stickyView;

@end
