//
//  FilterTableViewCell.m
//  FilterProject
//
//  Created by Dongdong on 16/4/19.
//  Copyright © 2016年 DD. All rights reserved.
//

#import "FilterTableViewCell.h"
#import "FilterCollectionViewCell.h"

@interface FilterTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <NSString *> *btnTitles;
@property (nonatomic, strong) UILabel *headerLabel;

@end

@implementation FilterTableViewCell

#pragma mark - life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headerLabel];
        [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@15);
            make.trailing.equalTo(@-15);
            make.top.equalTo(@15);
            make.height.equalTo(@13);
        }];

        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerLabel.mas_bottom);
            make.leading.and.trailing.and.bottom.equalTo(self.contentView);
        }];        
    }
    return self;
}

#pragma mark - public

- (void)config:(NSArray<NSString *> *)btnTitles header:(NSString *)header
{
    self.btnTitles = btnTitles;
    self.headerLabel.text = header;
    [self.collectionView reloadData];
}

+ (CGFloat)height:(NSInteger)count
{
    CGFloat height = 0;
    if (count % 4 == 0) {
        height = (count / 4) * (kFilterButtonHeight / 2 + 15)+15+13;
    }
    if (count % 4 > 0) {
        height = (count / 4 + 1) * (kFilterButtonHeight / 2 + 15)+15+13;
    }
    return height;
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.btnTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterCollectionViewCell" forIndexPath:indexPath];
    [cell fill:self.btnTitles[indexPath.item]];
    if (indexPath.item == 0) {
        cell.btn.selected = YES;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kFilterButtonWidth, kFilterButtonHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

#pragma mark - setter & getter

- (UILabel *)headerLabel
{
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.textColor = [UIColor colorWithRGB:0xdadada];
        _headerLabel.textAlignment = NSTextAlignmentLeft;
        _headerLabel.font = kFilterButtonFont;
    }
    return _headerLabel;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 15.0;
        layout.minimumInteritemSpacing = 15.0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[FilterCollectionViewCell class] forCellWithReuseIdentifier:@"FilterCollectionViewCell"];
    }
    return _collectionView;
}

@end
