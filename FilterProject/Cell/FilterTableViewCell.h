//
//  FilterTableViewCell.h
//  FilterProject
//
//  Created by Dongdong on 16/4/19.
//  Copyright © 2016年 DD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterTableViewCell : UITableViewCell

- (void)config:(NSArray <NSString *> *)btnTitles header:(NSString *)header;

+ (CGFloat)height:(NSInteger)count;

@end
