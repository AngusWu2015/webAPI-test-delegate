//
//  APIService.m
//  kk-API-delegate
//
//  Created by AndyWu on 2018/1/31.
//  Copyright © 2018年 AndyWu. All rights reserved.
//

#import "APIService.h"

@implementation APIService
@synthesize delegate;
static APIService *service = nil;
+ (APIService *) instance
{
    if (! service)
        service = [[APIService alloc] init];
    
    return service;
}

-(void)fetchGetResponse{
    [self cancelTasks];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://httpbin.org/get"]];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        sessionDataTask = nil;
       
        if (error) {
            if ([delegate respondsToSelector:@selector(ResponseError:)]) {
                [delegate ResponseError:error];
                return ;
            }
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];

            if ([delegate respondsToSelector:@selector(fetchGetReply:)]) {
                [delegate fetchGetReply:dict];
            }else{
            }
       
    }];
    [sessionDataTask resume];
}
-(void)postCustomerName:(NSString *)name{

    [self cancelTasks];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://httpbin.org/post"]];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *args = [NSString stringWithFormat:@"custname=%@",name];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        sessionDataTask = nil;
        if (error) {
            if ([delegate respondsToSelector:@selector(ResponseError:)]) {
                [delegate ResponseError:error];
                return ;
            }
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        if ([delegate respondsToSelector:@selector(fetchGetReply:)]) {
            [delegate fetchGetReply:dict];
        }
    }];
    [sessionDataTask resume];
}
-(void)fetchImageWithCallback{
    [self cancelTasks];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://httpbin.org/image/png"]];
    downloadPhotoTask = [[NSURLSession sharedSession]downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        downloadPhotoTask = nil;
        if (error) {
            if ([delegate respondsToSelector:@selector(ResponseError:)]) {
                [delegate ResponseError:error];
                return ;
            }
            return;
        }
        
        UIImage *downloadedImage = [UIImage imageWithData:
                                    [NSData dataWithContentsOfURL:location]];
        
        if ([delegate respondsToSelector:@selector(fetchImage:)]) {
            [delegate fetchImage:downloadedImage];
        }
        
    }];
    
    [downloadPhotoTask resume];
}

//取消其他API
- (void)cancelTasks {
    if (sessionDataTask != nil) {
        [sessionDataTask cancel];
        sessionDataTask = nil;
    }
    if (downloadPhotoTask != nil) {
        [downloadPhotoTask cancel];
        downloadPhotoTask = nil;
    }
    //    NSURLSession *session = [NSURLSession sharedSession];
    //    [session invalidateAndCancel];
    //    [session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
    //
    //        if (!dataTasks || !dataTasks.count) {
    //            return;
    //        }
    //        for (NSURLSessionTask *task in dataTasks) {
    //            [task cancel];
    //        }
    //    }];
}
@end

