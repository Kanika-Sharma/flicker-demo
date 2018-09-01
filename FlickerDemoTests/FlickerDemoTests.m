//
//  FlickerDemoTests.m
//  FlickerDemoTests
//
//  Created by Kanika Sharma on 30/08/18.
//  Copyright © 2018 RoundGlass. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CommonFunctions.h"

@interface FlickerDemoTests : XCTestCase

@end

@implementation FlickerDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testImageURL
{
    NSString *urlStr = [[CommonFunctions sharedFunctions] searchURL:@"kitten" withPageNumber:1];
    
    if([urlStr isEqualToString:@"error"])
    {
        XCTFail();
    }
    
    NSString *urlStrWithoutSearchText = [[CommonFunctions sharedFunctions] searchURL:@"" withPageNumber:1];
    
    if(![urlStrWithoutSearchText isEqualToString:@"error"])
    {
        XCTFail();
    }
    
    NSString *urlStrWithoutPage = [[CommonFunctions sharedFunctions] searchURL:@"kitten" withPageNumber:0];
    
    if(![urlStrWithoutPage isEqualToString:@"error"])
    {
        XCTFail();
    }
}

@end
