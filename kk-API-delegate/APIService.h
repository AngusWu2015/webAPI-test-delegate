//
//  APIService.h
//  kk-API-delegate
//
//  Created by AndyWu on 2018/1/31.
//  Copyright © 2018年 AndyWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol APIserviceDelegate <NSObject>
-(void)fetchGetReply:(NSDictionary *_Nullable)reply;
-(void)postReply:(NSDictionary *_Nullable)reply;
-(void)fetchImage:(UIImage *_Nullable)image;
-(void)ResponseError:(NSError *_Nullable)error;
@end

@interface APIService : NSObject
{
    NSURLSessionDataTask * sessionDataTask;
    NSURLSessionDownloadTask *downloadPhotoTask;
}
@property (nonatomic, weak, nullable) id <APIserviceDelegate> delegate;
+ (APIService * _Nonnull) instance;
-(void)fetchGetResponse;
-(void)postCustomerName:(NSString *_Nonnull)name;
-(void)fetchImageWithCallback;
@end
