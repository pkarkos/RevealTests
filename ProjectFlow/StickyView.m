//
//  StickyView.m
//  ProjectFlow
//
//  Created by Andrew Copp on 6/4/13.
//  Copyright (c) 2013 Andrew Copp. All rights reserved.
//

#import "StickyView.h"

@implementation StickyView

- (id)initWithBody:(UIScrollView *)body
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self setHeader:[[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                       -165,
                                                                       [self frame].size.width,
                                                                       165)]];
        
        [self setBody:[[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     [self frame].size.width,
                                                                     [self frame].size.height)]];
        
        [[self body] setContentSize:CGSizeMake([self frame].size.width, [self frame].size.height)];
        
        [[self body] setContentInset:UIEdgeInsetsMake(165.0f,
                                                      0.0f,
                                                      0.0f,
                                                      0.0f)];
        
        [[self body] setContentOffset:CGPointMake(0, -165)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 320, 25)];
        [label setText:@"test"];
        [label setTextColor:[UIColor blueColor]];
        
        
        [self addSubview:[self body]];
        [[self body] addSubview:label];
        [[self body] addSubview:[self header]];
    }
    return self;
}

@end
