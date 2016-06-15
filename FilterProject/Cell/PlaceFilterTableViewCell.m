//
//  PlaceFilterTableViewCell.m
//  FilterProject
//
//  Created by Dongdong on 16/4/20.
//  Copyright © 2016年 DD. All rights reserved.
//

#import "PlaceFilterTableViewCell.h"

@interface PlaceFilterTableViewCell ()

@property (nonatomic, strong) UIView *pSelectBackgroundView;

@end

@implementation PlaceFilterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (UIView *)selectBackgroundView
{
    if (!_pSelectBackgroundView) {
        _pSelectBackgroundView = [UIView new];
    }
    return _pSelectBackgroundView;
}

@end
