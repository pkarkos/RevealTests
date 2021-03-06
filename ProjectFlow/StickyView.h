//
//  StickyView.h
//  ProjectFlow
//
//  Created by Andrew Copp on 6/4/13.
//  Copyright (c) 2013 Andrew Copp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StickyView : UIView

@property (strong, nonatomic) UIView *header;
@property (strong, nonatomic) UIScrollView *body;

- (id)initWithBody:(UIScrollView *)body;

@end
