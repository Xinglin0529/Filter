//
//  FilterCollectionViewCell.m
//  FilterProject
//
//  Created by Dongdong on 16/4/19.
//  Copyright © 2016年 DD. All rights reserved.
//

#import "FilterCollectionViewCell.h"

@implementation FilterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.btn];
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.btn.selected = NO;
    [self.btn setTitle:@"" forState:UIControlStateNormal];
}

#pragma mark - public

- (void)fill:(NSString *)btnTitle
{
    [self.btn setTitle:btnTitle forState:UIControlStateNormal];
}

#pragma mark - event

- (void)btnTouchEvent:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchEvent:)]) {
        [self.delegate touchEvent:self];
    }
}

#pragma mark - getter & setter

- (FilterButton *)btn
{
    if (!_btn) {
        _btn = [[FilterButton alloc] init];
        _btn.titleLabel.font = kFilterButtonFont;
        [_btn addTarget:self action:@selector(btnTouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end

