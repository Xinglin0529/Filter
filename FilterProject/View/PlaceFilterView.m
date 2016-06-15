//
//  PlaceFilterView.m
//  FilterProject
//
//  Created by Dongdong on 16/4/20.
//  Copyright © 2016年 DD. All rights reserved.
//

#import "PlaceFilterView.h"
#import "PlaceFilterTableViewCell.h"
#import "PlaceFilterModel.h"

@interface PlaceFilterView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <PlaceFilterModel *> * filters;
@property (nonatomic, strong) UITableView *sectionTableView;
@property (nonatomic, strong) UITableView *rowTableView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSArray *rowData;

@property (nonatomic, assign) NSInteger lastSection;
@property (nonatomic, assign) NSInteger selectSection;
@property (nonatomic, assign) NSInteger selectRow;

@end

@implementation PlaceFilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - public

- (void)showFilterView:(NSArray<PlaceFilterModel *> *)filters section:(NSInteger)section row:(NSInteger)row
{
    self.filters = filters;
    self.lastSection = section;
    self.selectSection = section;
    self.selectRow = row;
    self.rowData = [self rowData:filters section:section];

    [self.sectionTableView reloadData];
    [self.rowTableView reloadData];
    [self showAnimation];
}

- (void)hideFilterView
{
    self.hidden = NO;
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(-[self containerHeight]));
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        [self layoutIfNeeded];
        [self updateConstraintsIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.alpha = 1;
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.sectionTableView) {
        return self.filters.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.sectionTableView) {
        return 1;
    }
    if (tableView == self.rowTableView) {
        return self.rowData.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.sectionTableView) {
        static NSString *sectionReuseIdentifier = @"PlaceFilterTableViewCell";
        UITableViewCell *sectionCell = [tableView dequeueReusableCellWithIdentifier:sectionReuseIdentifier];
        if (!sectionCell) {
            sectionCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionReuseIdentifier];
        }
        PlaceFilterModel *model = self.filters[indexPath.section];
        sectionCell.textLabel.text = model.sectionName;
        sectionCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.selectSection == indexPath.section) {
            sectionCell.backgroundColor = [UIColor whiteColor];
        } else {
            sectionCell.backgroundColor = [UIColor colorWithRGB:0xf2f2f2];
        }
        
        return sectionCell;
    }
    
    if (tableView == self.rowTableView) {
        static NSString *rowReuseIdentifier = @"rowReuseIdentifier";
        UITableViewCell *rowCell = [tableView dequeueReusableCellWithIdentifier:rowReuseIdentifier];
        if (!rowCell) {
            rowCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rowReuseIdentifier];
        }
        PlaceFilterSubmodel *sub = self.rowData[indexPath.row];
        rowCell.textLabel.text = sub.rowName;
        
        if (sub.selected) {
            rowCell.textLabel.textColor = [UIColor colorWithRGB:0x77d0fd];
        } else {
            rowCell.textLabel.textColor = [UIColor blackColor];
        }
        return rowCell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.sectionTableView) {
        self.rowData = [self selectSection:indexPath.section];
        self.selectSection = indexPath.section;
        [self.sectionTableView reloadData];
        [self.rowTableView reloadData];
    }
    
    if (tableView == self.rowTableView) {
        self.selectRow = indexPath.row;
        [self.rowTableView reloadData];
        [self hideFilterView];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(onSelectItem:row:)]) {
            [self.delegate onSelectItem:self.selectSection row:self.selectRow];
        }
    }
}

#pragma mark - private method

- (NSArray <NSString *> *)sectionData:(NSArray <PlaceFilterModel *> *)filters
{
    NSMutableArray *section = [[NSMutableArray alloc] init];
    for (PlaceFilterModel *model in filters) {
        [section addObject:model.sectionName];
    }
    return section;
}

- (NSArray <PlaceFilterSubmodel *> *)rowData:(NSArray <PlaceFilterModel *> *)filters section:(NSInteger)section
{
    return ((PlaceFilterModel *)filters[section]).filterSubmodels;
}

- (NSArray <PlaceFilterSubmodel *> *)selectSection:(NSInteger)section
{
    return ((PlaceFilterModel *)self.filters[section]).filterSubmodels;
}

- (void)showAnimation
{
    self.hidden = NO;
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
        [self updateConstraintsIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)commonInit
{
    self.hidden = YES;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.sectionTableView];
    [self.containerView addSubview:self.rowTableView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self);
        make.top.equalTo(@(-[self containerHeight]));
        make.height.equalTo(@([self containerHeight]));
    }];
    
    [self.sectionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.leading.equalTo(self.containerView);
        make.width.equalTo(@(kScreenWidth * 0.35));
    }];
    
    [self.rowTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.trailing.equalTo(self.containerView);
        make.leading.equalTo(self.sectionTableView.mas_trailing);
    }];
}

- (CGFloat)containerHeight
{
    return (kScreenHeight * 0.7);
}

#pragma mark - getter & setter

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (UITableView *)sectionTableView
{
    if (!_sectionTableView) {
        _sectionTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _sectionTableView.delegate = self;
        _sectionTableView.dataSource = self;
        _sectionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _sectionTableView.backgroundColor = [UIColor colorWithRGB:0xf2f2f2];
    }
    return _sectionTableView;
}

- (UITableView *)rowTableView
{
    if (!_rowTableView) {
        _rowTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rowTableView.delegate = self;
        _rowTableView.dataSource = self;
        _rowTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rowTableView.backgroundColor = [UIColor whiteColor];
        _rowTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }
    return _rowTableView;
}

@end
