//
//  NetWorkUikits.m
//  iphone-xiaoer
//
//  Created by sks on 16/2/16.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "NetWorkUikits.h"
#import "AFNetworking.h"

@implementation NetWorkUikits

#pragma mark - 网络请求
+(void)requestWithUrl:(NSString* )url
                param:(NSDictionary*)param
             timerOut:(NSUInteger)timerout
     completionHandle:(NetworkFetcherCompletionHandle)completion
        failureHandle:(NetworkFetcherErrorHandle)failure
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer.timeoutInterval = timerout;
    
    if (param != nil) { // 参数不为空的时候
    
        [session POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (completion) {
                completion(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                 failure(error);
            }
        }];
    }else{ // 参数为空的时候
        [session POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (completion) {
                completion(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}


+(void)requestWithUrl:(NSString* )url
                param:(NSDictionary*)param
     completionHandle:(NetworkFetcherCompletionHandle)completion
        failureHandle:(NetworkFetcherErrorHandle)failure
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer.timeoutInterval = 90;
    
    
    
    if (1) { // 参数不为空的时候
        [session POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //DLog(@"data: %@",responseObject);
            if (completion) {
                completion(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

@end
