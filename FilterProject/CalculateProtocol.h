//
//  CalculateProtocol.h
//  FilterProject
//
//  Created by Dongdong on 16/4/25.
//  Copyright © 2016年 DD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CalculateProtocol <NSObject>

- (void)plus:(int)number;
- (void)multiply:(int)number;

@end
