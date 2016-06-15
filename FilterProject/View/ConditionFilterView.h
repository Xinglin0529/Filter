//
//  ConditionFilter.h
//  FilterProject
//
//  Created by Dongdong on 16/4/19.
//  Copyright © 2016年 DD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConditionFilterView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)showFilter:(NSArray <NSDictionary *> *)content;
- (void)hideFilter;

@end
