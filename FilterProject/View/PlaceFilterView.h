//
//  PlaceFilterView.h
//  FilterProject
//
//  Created by Dongdong on 16/4/20.
//  Copyright © 2016年 DD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlaceFilterModel;

@protocol PlaceFilterViewDelegate <NSObject>

- (void)onSelectItem:(NSInteger)section row:(NSInteger)row;

@end

@interface PlaceFilterView : UIView

@property (nonatomic, weak) id <PlaceFilterViewDelegate> delegate;
- (void)showFilterView:(NSArray <PlaceFilterModel *> *)filters section:(NSInteger)section row:(NSInteger)row;
- (void)hideFilterView;

@end
