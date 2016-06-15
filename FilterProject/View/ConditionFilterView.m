//
//  ConditionFilter.m
//  FilterProject
//
//  Created by Dongdong on 16/4/19.
//  Copyright © 2016年 DD. All rights reserved.
//

#import "ConditionFilterView.h"
#import "FilterTableVIewCell.h"

@interface ConditionFilterView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <NSDictionary *> *contentFilters;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isShow;

@end

@implementation ConditionFilterView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - public

- (void)showFilter:(NSArray <NSDictionary *> *)content
{
    if (self.isShow) {
        return;
    }
    self.contentFilters = content;
    [self.tableView reloadData];
    [self layoutIfNeeded];
    [self showAnimation];
}

- (void)hideFilter
{
    self.isShow = NO;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(-[self tableHeight]));
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

#pragma mark - event

- (void)confirmBtnClick:(id)sender
{
    
}

#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.contentFilters.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FilterTableViewCell";
    FilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FilterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell config:(NSArray *)(((NSDictionary *)(self.contentFilters[indexPath.item]))[@"btn"]) header:((NSDictionary *)(self.contentFilters[indexPath.item]))[@"header"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.contentFilters.count - 1) {
        return 80;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = ((NSArray *)(((NSDictionary *)self.contentFilters[indexPath.item])[@"btn"])).count;
    return [FilterTableViewCell height:count];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == self.contentFilters.count - 1) {
        return [self addTableFooterView];
    }
    return nil;
}

#pragma mark - private method

- (void)showAnimation
{
    self.hidden = NO;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
        [self updateConstraintsIfNeeded];
    } completion:^(BOOL finished) {
        self.isShow = YES;
    }];
}

- (UIView *)addTableFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    footerView.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:0xfc9826]] forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(footerView).insets(UIEdgeInsetsMake(30, 30, 10, 30));
    }];
    return footerView;
}

- (void)commonInit
{
    self.hidden = YES;
    self.isShow = NO;
    [self setupSubviews];
}

- (void)setupSubviews
{
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self);
        make.top.equalTo(@(-[self tableHeight]));
        make.height.equalTo(@([self tableHeight]));
    }];
}

- (CGFloat)tableHeight
{
    if (kIsIphone4s) {
        return kScreenHeight * 0.7 + 44 + 64;
    }
    if (kIsIphone5) {
        return kScreenHeight * 0.7 + 44 + 80;
    }
    return kScreenHeight * 0.7 + 44;
}

#pragma mark - setter & getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundView = nil;
    }
    return _tableView;
}

@end
