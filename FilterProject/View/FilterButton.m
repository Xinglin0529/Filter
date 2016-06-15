//
//  FilterButton.m
//  FilterProject
//
//  Created by Dongdong on 16/4/19.
//  Copyright © 2016年 DD. All rights reserved.
//

#import "FilterButton.h"

@implementation FilterButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 5.f;
        self.layer.borderWidth = 1.f;
        self.clipsToBounds = YES;

        [self setTitleColor:[UIColor colorWithRGB:0xdadada alpha:1] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:0x199dff]] forState:UIControlStateSelected];
        [self setupBorder:NO];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setupBorder:selected];
}

- (void)setupBorder:(BOOL)selected
{
    self.layer.borderColor = selected ? [UIColor colorWithRGB:0x199dff].CGColor : [UIColor colorWithRGB:0xdadada].CGColor;
}

@end
