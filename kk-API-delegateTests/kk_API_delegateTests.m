//
//  kk_API_delegateTests.m
//  kk-API-delegateTests
//
//  Created by AndyWu on 2018/2/2.
//  Copyright © 2018年 AndyWu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APIService.h"
@interface kk_API_delegateTests : XCTestCase <APIserviceDelegate>
{
    XCTestExpectation *expectation;
}
@end

@implementation kk_API_delegateTests

- (void)setUp {
    [super setUp];
    [APIService instance].delegate = self;
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetchGetResponse{
    
    expectation = [self expectationWithDescription:@"GET"];
    
    [[APIService instance]fetchGetResponse];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@",error.localizedDescription);
        }
    }];
    
}
-(void)fetchGetReply:(NSDictionary * _Nullable)dic{
     XCTAssertNotNil(dic, "dictionary should not be nil");
    XCTAssertNotNil(dic[@"args"], "dictionary args key not be nil");
    XCTAssertNotNil(dic[@"headers"], "dictionary headers key not be nil");
    XCTAssertNotNil(dic[@"origin"], "dictionary origin key not be nil");
    XCTAssertNotNil(dic[@"url"], "dictionary url key not be nil");
    [expectation fulfill];
}
- (void)testpostCustomer{
    expectation = [self expectationWithDescription:@"POST"];
    [[APIService instance]postCustomerName:@"abc"];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@",error.localizedDescription);
        }
    }];
}
-(void)postReply:(NSDictionary * _Nullable)dic {
    XCTAssertNotNil(dic, "dictionary should not be nil");
    XCTAssertEqualObjects(dic[@"form"][@"custname"],@"abc",@"custname is not abc");
    [expectation fulfill];
}
-(void)testFetchImage{
    expectation = [self expectationWithDescription:@"IMAGE"];
    [[APIService instance]fetchImageWithCallback];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@",error.localizedDescription);
        }
    }];
}
-(void)fetchImage:(UIImage *  _Nullable)image{
    XCTAssertNotNil(image, "image should not be nil");
    [expectation fulfill];
}
-(void)ResponseError:(NSError * _Nullable)error{
    XCTAssertNil(error, "error should be nil");
}


@end
