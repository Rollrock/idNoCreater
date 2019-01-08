//
//  CreateModel.m
//  IDNoCreater
//
//  Created by zhuang chaoxiao on 2019/1/6.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//

#import "CreateModel.h"

@implementation CreateProvModel

+(CreateProvModel*)modelWithDict:(NSDictionary*)dict
{
    CreateProvModel * model = [CreateProvModel new];
    model.name = dict[@"name"];
    model.code = dict[@"code"];
    model.city =[NSMutableArray new];
    
    for( NSDictionary * subDict in dict[@"city"] )
    {
        CreateCityModel * cityModel = [CreateCityModel modelWithDict:subDict];
        [model.city addObject:cityModel];
    }
    
    return model;
}

@end


@implementation CreateCityModel

+(CreateCityModel*)modelWithDict:(NSDictionary*)dict
{
    CreateCityModel * model = [CreateCityModel new];
    model.name = dict[@"name"];
    model.code = dict[@"code"];
    model.area =[NSMutableArray new];
    
    for( NSDictionary * subDict in dict[@"area"] )
    {
        CreateAreaModel * areaModel = [CreateAreaModel modelWithDict:subDict];
        [model.area addObject:areaModel];
    }
    
    return model;
}

@end



@implementation CreateAreaModel

+(CreateAreaModel*)modelWithDict:(NSDictionary*)dict
{
    CreateAreaModel * model = [CreateAreaModel new];
    model.name = dict[@"name"];
    model.code = dict[@"code"];
    
    return model;
}


@end
