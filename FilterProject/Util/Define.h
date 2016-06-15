//
//  Define.h
//  FilterProject
//
//  Created by Dongdong on 16/4/19.
//  Copyright © 2016年 DD. All rights reserved.
//

#ifndef Define_h
#define Define_h

// 屏幕总宽
#define         kScreenWidth ([UIScreen mainScreen].bounds.size.width)
// 屏幕总高
#define         kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define         kFilterButtonWidth ((kScreenWidth-15*5)/4)
#define         kFilterButtonHeight 30
#define         kFilterButtonFont [UIFont systemFontOfSize:13]

//iphone 4s
#define         kIsIphone4s (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 480)))

//iphone 5
#define         kIsIphone5 (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568)))

#endif /* Define_h */
