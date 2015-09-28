//
//  BWGithubRepoListDataSourceTests.m
//  Brightwheel
//
//  Created by Brett Lyon on 9/27/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface BWGithubRepoListDataSourceTests : XCTestCase

@end

@implementation BWGithubRepoListDataSourceTests

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
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

// Test that setting the data source's tableView property sets the dataSource property of the table view

// Test that the class responds to the willDisplayCell UITableView delegate method

// Data source methods before fetch

// Data source methods after successful initial fetch

// Data source methods after successful subsequent fetch

// Data source methods after error on initial fetch

// Data source methods after error on subsequent fetch

@end
