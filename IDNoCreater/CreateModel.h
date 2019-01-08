//
//  CreateModel.h
//  IDNoCreater
//
//  Created by zhuang chaoxiao on 2019/1/6.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreateAreaModel : NSObject

@property(copy,nonatomic) NSString * name;
@property(copy,nonatomic) NSString * code;

+(CreateAreaModel*)modelWithDict:(NSDictionary*)dict;

@end

@interface CreateCityModel : NSObject

@property(copy,nonatomic) NSString * name;
@property(copy,nonatomic) NSString * code;
@property(strong,nonatomic) NSMutableArray * area;

+(CreateCityModel*)modelWithDict:(NSDictionary*)dict;

@end

//
@interface CreateProvModel : NSObject

@property(copy,nonatomic) NSString * name;
@property(copy,nonatomic) NSString * code;
@property(strong,nonatomic) NSMutableArray * city;

+(CreateProvModel*)modelWithDict:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
