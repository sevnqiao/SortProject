//
//  SortView.m
//  Test
//
//  Created by Xiong on 2018/2/8.
//  Copyright © 2018年 Xiong. All rights reserved.
//

#import "SortView.h"

@implementation SortView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.frame;
    frame.origin.y = self.superview.frame.size.height - self.frame.size.height;
    self.frame = frame;
    
    CGFloat weight = self.frame.size.height / self.superview.frame.size.height;
    UIColor *color = [UIColor colorWithHue:weight saturation:1 brightness:1 alpha:1];
    self.backgroundColor = color;
}

- (void)updateSortViewWithHeight:(NSInteger)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end
