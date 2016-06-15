//
//  PlaceFilterModel.h
//  FilterProject
//
//  Created by Dongdong on 16/4/20.
//  Copyright © 2016年 DD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceFilterSubmodel : NSObject

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSString *rowName;
@property (nonatomic, strong) NSString *type;

@end

@class PlaceFilterSubmodel;

@interface PlaceFilterModel : NSObject

@property (nonatomic, strong) NSString *sectionName;
@property (nonatomic, strong) NSArray <PlaceFilterSubmodel *> *filterSubmodels;

@end
