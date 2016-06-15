//
//  FilterCollectionViewCell.h
//  FilterProject
//
//  Created by Dongdong on 16/4/19.
//  Copyright © 2016年 DD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterCollectionViewCell;

@protocol FilterCollectionViewCellDelegate <NSObject>

- (void)touchEvent:(FilterCollectionViewCell *)cell;

@end

@interface FilterCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) FilterButton *btn;
@property (nonatomic, weak) id <FilterCollectionViewCellDelegate> delegate;

- (void)fill:(NSString *)btnTitle;

@end
